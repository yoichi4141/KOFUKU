import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/empathy.dart';
import '../../domain/repositories/empathy_repository.dart';
import '../../utils/constants/failures.dart';

@Injectable(as: EmpathyRepository)
class EmpathyRepositoryImpl implements EmpathyRepository {
  // インメモリでの共感データ管理（実際の実装ではHive/Firestoreを使用）
  static final Map<String, Empathy> _empathies = {};
  static final Map<String, List<String>> _userEmpathies = {}; // userId -> List<empathyId>
  static final Map<String, List<String>> _itemEmpathies = {}; // itemId -> List<empathyId>

  @override
  Future<Either<Failure, Empathy>> addEmpathy({
    required String userId,
    required String itemId,
    required EmpathyType type,
  }) async {
    try {
      // 既存の共感をチェック
      final existing = await getUserItemEmpathy(userId: userId, itemId: itemId);
      if (existing.isRight() && existing.getOrElse(() => null) != null) {
        return const Left(ValidationFailure(message: '既にこのアイテムに共感しています'));
      }

      // 新しい共感を作成
      final empathy = Empathy(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        itemId: itemId,
        createdAt: DateTime.now(),
        type: type,
      );

      // データを保存
      _empathies[empathy.id] = empathy;
      
      // インデックスを更新
      _userEmpathies.putIfAbsent(userId, () => []).add(empathy.id);
      _itemEmpathies.putIfAbsent(itemId, () => []).add(empathy.id);

      return Right(empathy);
    } catch (e) {
      return Left(ServerFailure(message: '共感の追加に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> removeEmpathy({
    required String userId,
    required String itemId,
  }) async {
    try {
      // 既存の共感を探す
      final existingResult = await getUserItemEmpathy(userId: userId, itemId: itemId);
      
      return existingResult.fold(
        (failure) => Left(failure),
        (empathy) {
          if (empathy == null) {
            return const Left(NotFoundFailure(message: '共感が見つかりません'));
          }

          // データから削除
          _empathies.remove(empathy.id);
          _userEmpathies[userId]?.remove(empathy.id);
          _itemEmpathies[itemId]?.remove(empathy.id);

          return const Right(null);
        },
      );
    } catch (e) {
      return Left(ServerFailure(message: '共感の削除に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Empathy>>> getUserEmpathies(String userId) async {
    try {
      final empathyIds = _userEmpathies[userId] ?? [];
      final empathies = empathyIds
          .map((id) => _empathies[id])
          .where((empathy) => empathy != null)
          .cast<Empathy>()
          .toList();

      // 作成日時でソート（新しい順）
      empathies.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return Right(empathies);
    } catch (e) {
      return Left(ServerFailure(message: 'ユーザー共感一覧の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, EmpathyStats>> getItemEmpathyStats(String itemId) async {
    try {
      final empathyIds = _itemEmpathies[itemId] ?? [];
      final empathies = empathyIds
          .map((id) => _empathies[id])
          .where((empathy) => empathy != null)
          .cast<Empathy>()
          .toList();

      // タイプ別にカウント
      final counts = <EmpathyType, int>{};
      for (final empathy in empathies) {
        counts[empathy.type] = (counts[empathy.type] ?? 0) + 1;
      }

      // 最新の共感を取得
      empathies.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final recentEmpathies = empathies.take(10).toList();

      final stats = EmpathyStats(
        counts: counts,
        totalCount: empathies.length,
        recentEmpathies: recentEmpathies,
      );

      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(message: 'アイテム共感統計の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, Empathy?>> getUserItemEmpathy({
    required String userId,
    required String itemId,
  }) async {
    try {
      final userEmpathyIds = _userEmpathies[userId] ?? [];
      
      for (final empathyId in userEmpathyIds) {
        final empathy = _empathies[empathyId];
        if (empathy != null && empathy.itemId == itemId) {
          return Right(empathy);
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'ユーザーアイテム共感の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPopularItemIds({
    int limit = 20,
    EmpathyType? filterByType,
  }) async {
    try {
      // アイテムごとの共感数を計算
      final itemCounts = <String, int>{};
      
      for (final empathies in _itemEmpathies.values) {
        for (final empathyId in empathies) {
          final empathy = _empathies[empathyId];
          if (empathy != null) {
            if (filterByType == null || empathy.type == filterByType) {
              itemCounts[empathy.itemId] = (itemCounts[empathy.itemId] ?? 0) + 1;
            }
          }
        }
      }

      // 共感数でソート
      final sortedItems = itemCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final itemIds = sortedItems
          .take(limit)
          .map((entry) => entry.key)
          .toList();

      return Right(itemIds);
    } catch (e) {
      return Left(ServerFailure(message: '人気アイテムの取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> searchItemsByEmpathy({
    required int minEmpathyCount,
    EmpathyType? filterByType,
  }) async {
    try {
      // アイテムごとの共感数を計算
      final itemCounts = <String, int>{};
      
      for (final empathies in _itemEmpathies.values) {
        for (final empathyId in empathies) {
          final empathy = _empathies[empathyId];
          if (empathy != null) {
            if (filterByType == null || empathy.type == filterByType) {
              itemCounts[empathy.itemId] = (itemCounts[empathy.itemId] ?? 0) + 1;
            }
          }
        }
      }

      // 最小共感数でフィルタ
      final filteredItems = itemCounts.entries
          .where((entry) => entry.value >= minEmpathyCount)
          .map((entry) => entry.key)
          .toList();

      return Right(filteredItems);
    } catch (e) {
      return Left(ServerFailure(message: '共感数での検索に失敗しました: $e'));
    }
  }

  // テスト用のデータクリア機能
  static void clearData() {
    _empathies.clear();
    _userEmpathies.clear();
    _itemEmpathies.clear();
  }
} 
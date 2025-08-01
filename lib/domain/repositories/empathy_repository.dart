import 'package:dartz/dartz.dart';

import '../entities/empathy.dart';
import '../../utils/constants/failures.dart';

abstract class EmpathyRepository {
  /// アイテムに共感を追加
  Future<Either<Failure, Empathy>> addEmpathy({
    required String userId,
    required String itemId,
    required EmpathyType type,
  });

  /// 共感を削除
  Future<Either<Failure, void>> removeEmpathy({
    required String userId,
    required String itemId,
  });

  /// ユーザーの共感一覧を取得
  Future<Either<Failure, List<Empathy>>> getUserEmpathies(String userId);

  /// アイテムの共感統計を取得
  Future<Either<Failure, EmpathyStats>> getItemEmpathyStats(String itemId);

  /// ユーザーがアイテムに共感しているかチェック
  Future<Either<Failure, Empathy?>> getUserItemEmpathy({
    required String userId,
    required String itemId,
  });

  /// 人気のアイテム（共感数順）を取得
  Future<Either<Failure, List<String>>> getPopularItemIds({
    int limit = 20,
    EmpathyType? filterByType,
  });

  /// 共感数でアイテムを検索
  Future<Either<Failure, List<String>>> searchItemsByEmpathy({
    required int minEmpathyCount,
    EmpathyType? filterByType,
  });
} 
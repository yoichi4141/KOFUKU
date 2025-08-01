import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/empathy.dart';
import '../../application/usecases/empathy_usecase.dart';
import '../../injection.dart';

part 'empathy_view_model.g.dart';

// 現在のユーザーID（実際の実装では認証システムから取得）
const String _currentUserId = 'user_001';

// ユーザーの共感一覧を管理するプロバイダー
@riverpod
class UserEmpathyList extends _$UserEmpathyList {
  @override
  Future<List<Empathy>> build() async {
    final empathyUseCase = getIt<EmpathyUseCase>();
    final result = await empathyUseCase.getUserEmpathies(_currentUserId);
    
    return result.fold(
      (failure) => throw Exception(failure.message),
      (empathies) => empathies,
    );
  }

  // 共感一覧を再読み込み
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

// アイテムの共感統計を管理するプロバイダー（ファミリー）
@riverpod
class ItemEmpathyStats extends _$ItemEmpathyStats {
  @override
  Future<EmpathyStats> build(String itemId) async {
    final empathyUseCase = getIt<EmpathyUseCase>();
    final result = await empathyUseCase.getItemEmpathyStats(itemId);
    
    return result.fold(
      (failure) => throw Exception(failure.message),
      (stats) => stats,
    );
  }

  // 統計を再読み込み
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(itemId));
  }
}

// ユーザーのアイテム共感状態を管理するプロバイダー（ファミリー）
@riverpod
class UserItemEmpathy extends _$UserItemEmpathy {
  @override
  Future<bool> build(String itemId) async {
    final empathyUseCase = getIt<EmpathyUseCase>();
    final result = await empathyUseCase.isEmpathized(
      userId: _currentUserId,
      itemId: itemId,
    );
    
    return result.fold(
      (failure) => false, // エラーの場合は未共感として扱う
      (isEmpathized) => isEmpathized,
    );
  }

  // 共感状態を切り替え
  Future<void> toggle({EmpathyType type = EmpathyType.love}) async {
    final empathyUseCase = getIt<EmpathyUseCase>();
    
    // 即座にUIを更新（楽観的アップデート）
    final currentState = state.value ?? false;
    state = AsyncValue.data(!currentState);

    // サーバーサイドの処理
    final result = await empathyUseCase.toggleEmpathy(
      userId: _currentUserId,
      itemId: itemId,
      type: type,
    );

    result.fold(
      (failure) {
        // エラーが発生した場合は元の状態に戻す
        state = AsyncValue.data(currentState);
        // エラーハンドリング（必要に応じてSnackBarなどで通知）
      },
      (newState) {
        // 成功した場合は結果を反映
        state = AsyncValue.data(newState);
        
        // 関連する他のプロバイダーを更新
        ref.invalidate(itemEmpathyStatsProvider(itemId));
        ref.invalidate(userEmpathyListProvider);
      },
    );
  }
}

// 人気アイテムIDのプロバイダー
@riverpod
Future<List<String>> popularItemIds(Ref ref, {
  int limit = 20,
  EmpathyType? filterByType,
}) async {
  final empathyUseCase = getIt<EmpathyUseCase>();
  final result = await empathyUseCase.getPopularItemIds(
    limit: limit,
    filterByType: filterByType,
  );
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (itemIds) => itemIds,
  );
}

// 共感タイプ別の統計プロバイダー
@riverpod
Future<Map<EmpathyType, int>> empathyTypeStats(Ref ref, String itemId) async {
  final statsAsync = ref.watch(itemEmpathyStatsProvider(itemId));
  
  return statsAsync.when(
    data: (stats) => stats.counts,
    loading: () => {},
    error: (error, stack) => {},
  );
}

// 共感アクションの状態管理
class EmpathyActions {
  final Ref ref;
  
  const EmpathyActions(this.ref);

  // アイテムに共感
  Future<void> empathizeItem(String itemId, {EmpathyType type = EmpathyType.love}) async {
    final notifier = ref.read(userItemEmpathyProvider(itemId).notifier);
    await notifier.toggle(type: type);
  }

  // 共感を取り消し
  Future<void> unempathizeItem(String itemId) async {
    final notifier = ref.read(userItemEmpathyProvider(itemId).notifier);
    await notifier.toggle();
  }

  // アイテムの共感状態を確認
  bool isEmpathized(String itemId) {
    return ref.read(userItemEmpathyProvider(itemId)).value ?? false;
  }

  // アイテムの共感数を取得
  int getEmpathyCount(String itemId) {
    final stats = ref.read(itemEmpathyStatsProvider(itemId));
    return stats.when(
      data: (stats) => stats.totalCount,
      loading: () => 0,
      error: (error, stack) => 0,
    );
  }
}

// 共感アクションプロバイダー
@riverpod
EmpathyActions empathyActions(Ref ref) {
  return EmpathyActions(ref);
} 
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/empathy.dart';
import '../../domain/repositories/empathy_repository.dart';
import '../../utils/constants/failures.dart';

@injectable
class EmpathyUseCase {
  final EmpathyRepository _empathyRepository;

  const EmpathyUseCase(this._empathyRepository);

  /// アイテムに共感する
  Future<Either<Failure, Empathy>> addEmpathy({
    required String userId,
    required String itemId,
    required EmpathyType type,
  }) async {
    // 既に共感しているかチェック
    final existingEmpathy = await _empathyRepository.getUserItemEmpathy(
      userId: userId,
      itemId: itemId,
    );

    return existingEmpathy.fold(
      (failure) => Left(failure),
      (empathy) {
        if (empathy != null) {
          // 既に共感している場合はエラー
          return const Left(ValidationFailure(message: '既にこのアイテムに共感しています'));
        }
        // 新しい共感を追加
        return _empathyRepository.addEmpathy(
          userId: userId,
          itemId: itemId,
          type: type,
        );
      },
    );
  }

  /// 共感を取り消す
  Future<Either<Failure, void>> removeEmpathy({
    required String userId,
    required String itemId,
  }) async {
    return _empathyRepository.removeEmpathy(
      userId: userId,
      itemId: itemId,
    );
  }

  /// 共感状態を切り替える
  Future<Either<Failure, bool>> toggleEmpathy({
    required String userId,
    required String itemId,
    EmpathyType type = EmpathyType.love,
  }) async {
    // 現在の共感状態をチェック
    final existingEmpathy = await _empathyRepository.getUserItemEmpathy(
      userId: userId,
      itemId: itemId,
    );

    return existingEmpathy.fold(
      (failure) => Left(failure),
      (empathy) async {
        if (empathy != null) {
          // 共感済みの場合は削除
          final result = await removeEmpathy(
            userId: userId,
            itemId: itemId,
          );
          return result.fold(
            (failure) => Left(failure),
            (_) => const Right(false), // false = 共感解除
          );
        } else {
          // 未共感の場合は追加
          final result = await addEmpathy(
            userId: userId,
            itemId: itemId,
            type: type,
          );
          return result.fold(
            (failure) => Left(failure),
            (_) => const Right(true), // true = 共感追加
          );
        }
      },
    );
  }

  /// ユーザーの共感一覧を取得
  Future<Either<Failure, List<Empathy>>> getUserEmpathies(String userId) {
    return _empathyRepository.getUserEmpathies(userId);
  }

  /// アイテムの共感統計を取得
  Future<Either<Failure, EmpathyStats>> getItemEmpathyStats(String itemId) {
    return _empathyRepository.getItemEmpathyStats(itemId);
  }

  /// ユーザーがアイテムに共感しているかチェック
  Future<Either<Failure, bool>> isEmpathized({
    required String userId,
    required String itemId,
  }) async {
    final result = await _empathyRepository.getUserItemEmpathy(
      userId: userId,
      itemId: itemId,
    );

    return result.fold(
      (failure) => Left(failure),
      (empathy) => Right(empathy != null),
    );
  }

  /// 人気のアイテムIDを取得
  Future<Either<Failure, List<String>>> getPopularItemIds({
    int limit = 20,
    EmpathyType? filterByType,
  }) {
    return _empathyRepository.getPopularItemIds(
      limit: limit,
      filterByType: filterByType,
    );
  }
} 
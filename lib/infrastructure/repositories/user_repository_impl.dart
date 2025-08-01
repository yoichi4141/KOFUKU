import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../utils/constants/failures.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  // Sample data for demonstration
  final List<User> _users = [
    User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    User(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(_users);
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to get users'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final user = _users.firstWhere((user) => user.id == id);
      return Right(user);
    } catch (e) {
      return const Left(NotFoundFailure(message: 'User not found'));
    }
  }

  @override
  Future<Either<Failure, User>> createUser(User user) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _users.add(user);
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to create user'));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = user;
        return Right(user);
      } else {
        return const Left(NotFoundFailure(message: 'User not found'));
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to update user'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _users.removeWhere((user) => user.id == id);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to delete user'));
    }
  }
} 
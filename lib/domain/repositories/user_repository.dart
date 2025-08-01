import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../../utils/constants/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, User>> getUserById(String id);
  Future<Either<Failure, User>> createUser(User user);
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, void>> deleteUser(String id);
} 
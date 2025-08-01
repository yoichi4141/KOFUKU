import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../utils/constants/failures.dart';

@injectable
class GetUsersUseCase {
  final UserRepository _userRepository;

  const GetUsersUseCase(this._userRepository);

  Future<Either<Failure, List<User>>> call() async {
    return await _userRepository.getUsers();
  }
} 
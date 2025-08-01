import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import '../../application/usecases/get_users_usecase.dart';
import '../../injection.dart';

class UserState {
  final List<User> users;
  final bool isLoading;
  final String? error;

  const UserState({
    this.users = const [],
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState());

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final getUsersUseCase = getIt<GetUsersUseCase>();
    final result = await getUsersUseCase();
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false, 
        error: failure.message,
      ),
      (users) => state = state.copyWith(
        isLoading: false, 
        users: users,
      ),
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
}); 
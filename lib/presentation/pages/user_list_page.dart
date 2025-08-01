import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/user_view_model.dart';
import '../widgets/user_card.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  ConsumerState<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends ConsumerState<UserListPage> {
  @override
  void initState() {
    super.initState();
    // ページが表示された時にユーザー一覧を読み込み
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(userProvider.notifier).loadUsers();
            },
          ),
        ],
      ),
      body: _buildBody(userState),
    );
  }

  Widget _buildBody(UserState userState) {
    if (userState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (userState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${userState.error}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(userProvider.notifier).loadUsers();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (userState.users.isEmpty) {
      return const Center(
        child: Text('No users found'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: userState.users.length,
      itemBuilder: (context, index) {
        final user = userState.users[index];
        return UserCard(user: user);
      },
    );
  }
} 
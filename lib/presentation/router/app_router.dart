import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/main_page.dart';
import '../pages/user_list_page.dart';
import '../pages/onboarding/splash_page.dart';
import '../pages/onboarding/welcome_page.dart';
import '../pages/onboarding/signup_page.dart';
import '../pages/onboarding/login_page.dart';
import '../pages/profile_edit_page.dart';
// import '../pages/category_search_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // オンボーディングフロー
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/profile-edit',
        name: 'profile-edit',
        builder: (context, state) => const ProfileEditPage(),
      ),
      
      // メインアプリ
      GoRoute(
        path: '/',
        name: 'main',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/users',
        name: 'users',
        builder: (context, state) => const UserListPage(),
      ),
      // 以下のルートは MainPage内でタブ管理されるため削除
      // GoRoute(
      //   path: '/category-search',
      //   name: 'category_search', 
      //   builder: (context, state) => const CategorySearchPage(),
      // ),
    ],
  );
} 
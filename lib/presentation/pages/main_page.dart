import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_theme.dart';
import 'home_page_content.dart';
import 'category_search_page.dart';
import 'user_list_page.dart';
import 'empathy_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _currentIndex = 0;

  // タブページのリスト
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePageContent(), // ボトムナビゲーションなしのホームページ
      const CategorySearchPage(), // 検索ページ
      const EmpathyPage(), // 共感ページ
      const MessagePage(), // メッセージページ（仮）
      const UserListPage(), // マイページ
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          border: Border(
            top: BorderSide(color: AppTheme.borderGray, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.darkCharcoal,
          unselectedItemColor: AppTheme.softGray,
          selectedLabelStyle: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 22.sp),
              activeIcon: Icon(Icons.home, size: 22.sp),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 22.sp),
              activeIcon: Icon(Icons.search, size: 22.sp),
              label: '検索',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 22.sp),
              activeIcon: Icon(Icons.favorite, size: 22.sp),
              label: '共感',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline, size: 22.sp),
              activeIcon: Icon(Icons.chat_bubble, size: 22.sp),
              label: 'メッセージ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 22.sp),
              activeIcon: Icon(Icons.person, size: 22.sp),
              label: 'マイページ',
            ),
          ],
        ),
      ),
    );
  }
}

// 仮の共感ページ
class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        title: Text(
          '共感した愛のエッセイ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64.sp,
              color: AppTheme.softGray,
            ),
            SizedBox(height: 16.h),
            Text(
              '共感機能は開発中です',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.softGray,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'お気に入りの愛のエッセイを\nここで管理できるようになります',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.softGray,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 仮のメッセージページ
class MessagePage extends ConsumerWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        title: Text(
          'メッセージ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64.sp,
              color: AppTheme.softGray,
            ),
            SizedBox(height: 16.h),
            Text(
              'メッセージ機能は開発中です',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.softGray,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'アイテムの出品者や購入者との\nやりとりができるようになります',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.softGray,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
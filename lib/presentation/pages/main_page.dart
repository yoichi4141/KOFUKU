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

// メッセージページ
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: AppTheme.darkCharcoal,
              size: 22.sp,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('検索機能は開発中です'),
                  backgroundColor: AppTheme.darkCharcoal,
                ),
              );
            },
          ),
        ],
      ),
      body: _buildMessageList(),
    );
  }

  Widget _buildMessageList() {
    // ダミーデータを表示
    final conversations = [
      {
        'title': '「ヴィンテージデニムジャケット」について',
        'lastMessage': 'ありがとうございます！とても素敵なエッセイでした。',
        'senderName': 'みどり',
        'time': '3時間前',
        'unread': 2,
        'type': '🛍️',
      },
      {
        'title': 'さくらさんとの会話',
        'lastMessage': 'あいこさんの愛のエッセイ、本当に感動しました💖',
        'senderName': 'さくら',
        'time': '30分前',
        'unread': 1,
        'type': '💬',
      },
      {
        'title': '「カシミヤコート」について',
        'lastMessage': 'ぜひお譲りします。大切にしていただけるとのことで...',
        'senderName': 'あいこ',
        'time': '15分前',
        'unread': 0,
        'type': '🛍️',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conv = conversations[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: AppTheme.pureWhite,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: AppTheme.subtleShadow,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16.w),
            leading: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: AppTheme.accentYellow.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Center(
                child: Text(
                  conv['type'] as String,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
            title: Text(
              conv['title'] as String,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.darkCharcoal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  conv['lastMessage'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.softGray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      conv['senderName'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      conv['time'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: conv['unread'] as int > 0
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.loveRed,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      (conv['unread'] as int).toString(),
                      style: TextStyle(
                        color: AppTheme.pureWhite,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : null,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('チャット画面は開発中です'),
                  backgroundColor: AppTheme.darkCharcoal,
                ),
              );
            },
          ),
        );
      },
    );
  }
} 
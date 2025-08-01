import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_theme.dart';
import '../../utils/dummy_data.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  // プロフィール用のダミーデータ
  final String userName = 'Yoichi Nemoto';
  final String followersCount = '1.2k フォロワー';
  final String bio = '''私は、古着とその物語を愛しています。
一着一着に宿る歴史と感情を大切にし、
持続可能なファッションを通じて新しい価値を創造したいと考えています。''';

  @override
  Widget build(BuildContext context) {
    final posts = DummyData.clothingItems.take(8).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      body: CustomScrollView(
        slivers: [
          // プロフィールヘッダー
          SliverAppBar(
            backgroundColor: AppTheme.pureWhite,
            elevation: 0,
            pinned: true,
            expandedHeight: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // 戻るボタン（必要に応じて）
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.darkCharcoal,
                        size: 20.sp,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkCharcoal,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showSettingsMenu();
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        color: AppTheme.darkCharcoal,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // プロフィールコンテンツ
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.pureWhite,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                children: [
                  // プロフィール画像
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.lightGray,
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.accentYellow.withValues(alpha: 0.3),
                              AppTheme.loveRed.withValues(alpha: 0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60.sp,
                          color: AppTheme.darkCharcoal.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ユーザー名
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // フォロワー情報
                  Text(
                    followersCount,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.softGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 自己紹介
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGray.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      bio,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.darkCharcoal,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h).toSliver(),

          // 投稿グリッド
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.pureWhite,
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'コレクション',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final item = posts[index];
                      return _buildPostItem(item, index);
                    },
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 80.h).toSliver(),
        ],
      ),
    );
  }

  Widget _buildPostItem(item, int index) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.title} を表示'),
            backgroundColor: AppTheme.darkCharcoal,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 背景画像
            Container(
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(12.r),
                image: item.imageUrls.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(item.imageUrls.first),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),

            // グラデーションオーバーレイ
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),

            // アイテム情報
            Positioned(
              bottom: 8.h,
              left: 8.w,
              right: 8.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '¥${item.price.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 10.sp,
                            color: AppTheme.loveRed,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            item.empathyCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppTheme.borderGray,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            _buildSettingsItem(Icons.edit, 'プロフィールを編集'),
            _buildSettingsItem(Icons.privacy_tip, 'プライバシー設定'),
            _buildSettingsItem(Icons.notifications, '通知設定'),
            _buildSettingsItem(Icons.help, 'ヘルプ'),
            _buildSettingsItem(Icons.logout, 'ログアウト'),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.darkCharcoal),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppTheme.darkCharcoal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title が選択されました'),
            backgroundColor: AppTheme.darkCharcoal,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }
}

// SizedBox用の拡張メソッド
extension SizedBoxSliver on SizedBox {
  Widget toSliver() => SliverToBoxAdapter(child: this);
} 
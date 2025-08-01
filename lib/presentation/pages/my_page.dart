import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_theme.dart';
import '../../utils/dummy_data.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> with TickerProviderStateMixin {
  late TabController _tabController;

  // プロフィール用のダミーデータ
  final String userName = '古着クリエイター';
  final bool isVerified = true;
  final String followingCount = '444';
  final String followersCount = '666';
  final String shortBio = 'ビンテージ';
  final String detailedBio = '''古物の心を理解し、人と物との出会いを紡ぎます。
世界の中に息づく歴史、物の命とその背景を通読します。
発見の日々は続く、過去と未来。''';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        _showSettingsMenu();
                      },
                      icon: Icon(
                        Icons.settings,
                        color: AppTheme.darkCharcoal,
                        size: 24.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showShareMenu();
                      },
                      icon: Icon(
                        Icons.share,
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
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                children: [
                  // プロフィール画像
                  Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 25,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.lightGray,
                          // 仏像画像のイメージ（実際の画像がある場合はNetworkImageを使用）
                          gradient: LinearGradient(
                            colors: [
                              Colors.brown.withValues(alpha: 0.3),
                              Colors.amber.withValues(alpha: 0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 70.sp,
                          color: AppTheme.darkCharcoal.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ユーザー名（認証マーク付き）
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          userName,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkCharcoal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (isVerified) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 20.sp,
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: 4.h),

                  // ユーザーハンドル
                  Text(
                    '@christina',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.softGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // 短い自己紹介
                  Text(
                    shortBio,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.darkCharcoal,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h),

                  // 詳細な自己紹介
                  Text(
                    detailedBio,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.darkCharcoal,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20.h),

                  // Following/Followers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFollowStat(followingCount, 'Following'),
                      SizedBox(width: 32.w),
                      _buildFollowStat(followersCount, 'Followers'),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Edit Profileボタン
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.go('/profile-edit');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.darkCharcoal,
                        side: BorderSide(color: AppTheme.borderGray, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Edit profile',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h).toSliver(),

          // タブバー
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.pureWhite,
              child: TabBar(
                controller: _tabController,
                labelColor: AppTheme.darkCharcoal,
                unselectedLabelColor: AppTheme.softGray,
                indicatorColor: AppTheme.darkCharcoal,
                indicatorWeight: 2.h,
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                tabs: [
                  Tab(text: 'コレクション'),
                  Tab(text: 'レシピ'),
                ],
              ),
            ),
          ),

          // タブコンテンツ
          SliverFillRemaining(
            child: Container(
              color: AppTheme.pureWhite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCollectionsTab(),
                  _buildRecipesTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.darkCharcoal,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.softGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildCollectionSection('コレクション1', 12),
          SizedBox(height: 24.h),
          _buildCollectionSection('コレクション2 Cuisine', 12),
        ],
      ),
    );
  }

  Widget _buildCollectionSection(String title, int itemCount) {
    final posts = DummyData.clothingItems.take(itemCount).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.darkCharcoal,
              ),
            ),
            Text(
              '$itemCount items',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.softGray,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            final item = posts[index % posts.length];
            return _buildGridItem(item);
          },
        ),
      ],
    );
  }

     Widget _buildGridItem(dynamic item) {
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
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.lightGray,
              image: item.imageUrls.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(item.imageUrls.first),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: item.imageUrls.isEmpty
                ? Icon(
                    Icons.image,
                    color: AppTheme.softGray,
                    size: 24.sp,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildRecipesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 64.sp,
            color: AppTheme.softGray,
          ),
          SizedBox(height: 16.h),
          Text(
            'レシピは開発中です',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.softGray,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '古着のコーディネートレシピを\n共有できる機能を準備中',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.softGray,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showShareMenu() {
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
            Text(
              'プロフィールを共有',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.darkCharcoal,
              ),
            ),
            SizedBox(height: 20.h),
            _buildShareItem(Icons.link, 'リンクをコピー'),
            _buildShareItem(Icons.message, 'メッセージで送信'),
            _buildShareItem(Icons.email, 'メールで送信'),
            SizedBox(height: 20.h),
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
            _buildSettingsItem(Icons.edit, 'プロフィールを編集', action: () {
              Navigator.pop(context);
              context.go('/profile-edit');
            }),
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

  Widget _buildShareItem(IconData icon, String title) {
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

  Widget _buildSettingsItem(IconData icon, String title, {VoidCallback? action}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.darkCharcoal),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppTheme.darkCharcoal,
        ),
      ),
      onTap: action ?? () {
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
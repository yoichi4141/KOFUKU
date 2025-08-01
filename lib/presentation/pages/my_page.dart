import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_theme.dart';
import '../../utils/dummy_profile_data.dart';
import '../../domain/entities/user_profile.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final UserProfile _currentProfile = DummyProfileData.currentUserProfile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          _buildProfileHeader(),
          _buildStatsRow(),
          _buildTabBar(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          boxShadow: AppTheme.subtleShadow,
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Row(
                children: [
                  // アバター
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.accentYellow.withValues(alpha: 0.3),
                          AppTheme.loveRed.withValues(alpha: 0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: AppTheme.accentYellow,
                        width: 2.w,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _currentProfile.displayName.substring(0, 1),
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkCharcoal,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 16.w),
                  
                  // プロフィール情報
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _currentProfile.displayName,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkCharcoal,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: _currentProfile.stats.activityLevel == ActivityLevel.veryActive 
                                    ? AppTheme.loveRed.withValues(alpha: 0.1)
                                    : AppTheme.accentYellow.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                _currentProfile.stats.activityLevel.emoji,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 4.h),
                        
                        if (_currentProfile.location != null)
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14.sp,
                                color: AppTheme.softGray,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                _currentProfile.location!,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.softGray,
                                ),
                              ),
                            ],
                          ),
                        
                        SizedBox(height: 8.h),
                        
                        // 評価とレビュー
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < _currentProfile.stats.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16.sp,
                                color: AppTheme.accentYellow,
                              );
                            }),
                            SizedBox(width: 8.w),
                            Text(
                              '${_currentProfile.stats.rating} (${_currentProfile.stats.reviewsCount})',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.softGray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // 設定ボタン
                  IconButton(
                    onPressed: () => _showSettingsBottomSheet(),
                    icon: Icon(
                      Icons.settings,
                      color: AppTheme.darkCharcoal,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16.h),
              
              // 自己紹介
              if (_currentProfile.bio != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGray,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    _currentProfile.bio!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.darkCharcoal,
                      height: 1.5,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = _currentProfile.stats;
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: AppTheme.subtleShadow,
        ),
        child: Row(
          children: [
            _buildStatItem('エッセイ', stats.essaysCount.toString(), Icons.article),
            _buildStatDivider(),
            _buildStatItem('共感', stats.empathyReceived.toString(), Icons.favorite),
            _buildStatDivider(),
            _buildStatItem('フォロワー', stats.followersCount.toString(), Icons.people),
            _buildStatDivider(),
            _buildStatItem('販売', stats.itemsSold.toString(), Icons.shopping_bag),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 24.sp,
            color: AppTheme.loveRed,
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.darkCharcoal,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.softGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40.h,
      width: 1.w,
      color: AppTheme.borderGray,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }

  Widget _buildTabBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: AppTheme.subtleShadow,
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: AppTheme.darkCharcoal,
          unselectedLabelColor: AppTheme.softGray,
          indicatorColor: AppTheme.loveRed,
          indicatorWeight: 3.h,
          labelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'エッセイ'),
            Tab(text: '共感'),
            Tab(text: '活動'),
            Tab(text: '実績'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return SliverFillRemaining(
      child: Container(
        margin: EdgeInsets.all(16.w),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildEssaysTab(),
            _buildEmpathyTab(),
            _buildActivityTab(),
            _buildAchievementsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildEssaysTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article,
            size: 64.sp,
            color: AppTheme.softGray,
          ),
          SizedBox(height: 16.h),
          Text(
            'エッセイ一覧は開発中です',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.softGray,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'あなたが投稿した\n愛のエッセイを確認できます',
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

  Widget _buildEmpathyTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 64.sp,
            color: AppTheme.loveRed,
          ),
          SizedBox(height: 16.h),
          Text(
            '共感したアイテム一覧は開発中です',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.softGray,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'あなたが共感したアイテムや\nエッセイを確認できます',
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

  Widget _buildActivityTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: DummyProfileData.recentActivities.length,
      itemBuilder: (context, index) {
        final activity = DummyProfileData.recentActivities[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.pureWhite,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: AppTheme.subtleShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppTheme.accentYellow.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    activity['icon'],
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['description'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkCharcoal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      activity['title'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatTimeAgo(activity['time']),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.softGray,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementsTab() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: DummyProfileData.achievements.length,
      itemBuilder: (context, index) {
        final achievement = DummyProfileData.achievements[index];
        final earned = achievement['earned'] as bool;
        
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.pureWhite,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: AppTheme.subtleShadow,
            border: earned 
                ? Border.all(color: AppTheme.accentYellow.withValues(alpha: 0.3), width: 1.w)
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: earned 
                      ? AppTheme.accentYellow.withValues(alpha: 0.2)
                      : AppTheme.softGray.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Center(
                  child: Opacity(
                    opacity: earned ? 1.0 : 0.5,
                    child: Text(
                      achievement['icon'],
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement['title'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: earned ? AppTheme.darkCharcoal : AppTheme.softGray,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      achievement['description'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                      ),
                    ),
                    if (!earned && achievement.containsKey('progress'))
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${(achievement['progress'] * 100).toInt()}% 達成',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.loveRed,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            LinearProgressIndicator(
                              value: achievement['progress'],
                              backgroundColor: AppTheme.borderGray,
                              color: AppTheme.loveRed,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (earned)
                Icon(
                  Icons.check_circle,
                  color: AppTheme.accentYellow,
                  size: 20.sp,
                ),
            ],
          ),
        );
      },
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: AppTheme.borderGray,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Text(
                '設定',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkCharcoal,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: DummyProfileData.settingsMenuItems.length,
                itemBuilder: (context, index) {
                  final item = DummyProfileData.settingsMenuItems[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: ListTile(
                      leading: Text(
                        item['icon'],
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      title: Text(
                        item['title'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: item['action'] == 'logout' 
                              ? AppTheme.loveRed 
                              : AppTheme.darkCharcoal,
                        ),
                      ),
                      subtitle: Text(
                        item['subtitle'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.softGray,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppTheme.softGray,
                        size: 20.sp,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item['title']}は開発中です'),
                            backgroundColor: AppTheme.darkCharcoal,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}日前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}時間前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分前';
    } else {
      return 'たった今';
    }
  }
} 
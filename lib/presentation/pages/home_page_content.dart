import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/dummy_data.dart';
import '../../utils/app_theme.dart';

class HomePageContent extends ConsumerStatefulWidget {
  const HomePageContent({super.key});

  @override
  ConsumerState<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends ConsumerState<HomePageContent> {
  String selectedCategory = 'すべて';

  @override
  Widget build(BuildContext context) {
    final featuredItems = DummyData.clothingItems.take(3).toList();
    final weeklyItems = DummyData.clothingItems.skip(1).take(2).toList();

    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      body: CustomScrollView(
        slivers: [
          // プロフィールヘッダー
          SliverAppBar(
            backgroundColor: AppTheme.pureWhite,
            elevation: 0,
            pinned: false,
            expandedHeight: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    // プロフィールアバター
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppTheme.lightGray,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppTheme.borderGray, width: 1),
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppTheme.softGray,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    
                    // ユーザー名
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Yoichi Nemoto',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkCharcoal,
                            ),
                          ),
                          Text(
                            'Homescreen',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.softGray,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // 通知アイコン
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: AppTheme.darkCharcoal,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // "愛のエッセイ発見" セクション
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '愛のエッセイ発見',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkCharcoal,
                        ),
                      ),
                      Text(
                        'すべて',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.loveRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 注目アイテム横スクロール
                SizedBox(
                  height: 220.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: featuredItems.length,
                    itemBuilder: (context, index) {
                      final item = featuredItems[index];
                      return Container(
                        width: 180.w,
                        margin: EdgeInsets.only(right: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: AppTheme.subtleShadow,
                        ),
                        child: Stack(
                          children: [
                            // 背景画像
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.lightGray,
                                borderRadius: BorderRadius.circular(16.r),
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
                                borderRadius: BorderRadius.circular(16.r),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                            
                            // コンテンツ
                            Positioned(
                              bottom: 16.h,
                              left: 16.w,
                              right: 16.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.white70,
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        item.ownerPenName,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // 時間ラベル
                            Positioned(
                              top: 12.h,
                              left: 12.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  '${15 + index} min',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h).toSliver(),

          // "古着カテゴリを選ぶ" セクション
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Text(
                    '古着カテゴリを選ぶ',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                ),
                
                // カテゴリ円形アイコン
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCategoryIcon('アウター', Icons.checkroom, AppTheme.loveRed),
                      _buildCategoryIcon('トップス', Icons.shopping_bag, AppTheme.accentYellow),
                      _buildCategoryIcon('ボトムス', Icons.content_cut, AppTheme.darkCharcoal),
                      _buildCategoryIcon('アクセサリー', Icons.star, AppTheme.softGray),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h).toSliver(),

          // "今週のおすすめ" セクション
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Text(
                    '今週のおすすめ',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                ),
                
                // おすすめアイテム
                for (var item in weeklyItems) Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: AppTheme.subtleShadow,
                  ),
                  child: Stack(
                    children: [
                      // 背景画像
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.lightGray,
                          borderRadius: BorderRadius.circular(16.r),
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
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withValues(alpha: 0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      
                      // コンテンツ
                      Positioned(
                        left: 20.w,
                        top: 20.h,
                        bottom: 20.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  item.ownerPenName,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 80.h).toSliver(),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label カテゴリを選択'),
            backgroundColor: AppTheme.darkCharcoal,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Icon(
              icon,
              size: 28.sp,
              color: color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.darkCharcoal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// SizedBox用の拡張メソッド
extension SizedBoxSliver on SizedBox {
  Widget toSliver() => SliverToBoxAdapter(child: this);
} 
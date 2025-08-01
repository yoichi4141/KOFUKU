import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../utils/dummy_data.dart';
import '../../utils/app_theme.dart';
import '../widgets/clothing_item_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String selectedCategory = 'すべて';
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = DummyData.clothingItems.where((item) {
      if (selectedCategory == 'すべて') return true;
      return item.category == selectedCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      body: CustomScrollView(
        slivers: [
          // カスタムAppBar
          SliverAppBar(
            backgroundColor: AppTheme.pureWhite,
            elevation: 0,
            pinned: true,
            expandedHeight: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: AppTheme.pureWhite,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.borderGray,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            title: Text(
              'KOFUKU',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border, 
                  color: AppTheme.darkCharcoal, size: 22.sp),
                onPressed: () {},
              ),
              SizedBox(width: 8.w),
            ],
          ),

          // ヒーローセクション
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'その服に、\nあなたの"愛"は\nありますか？',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w300,
                      height: 1.2,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'HOSPITALITY IS BEAUTY',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.softGray,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 検索バー
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.pureWhite,
              padding: EdgeInsets.all(24.w),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.lightGray,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppTheme.borderGray),
                ),
                child: GestureDetector(
                  onTap: () {
                    context.go('/category-search');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, 
                          color: AppTheme.softGray, size: 20.sp),
                        SizedBox(width: 12.w),
                        Text(
                          '愛のエッセイを検索',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.softGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // カテゴリータブ
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.pureWhite,
              padding: EdgeInsets.only(bottom: 24.h),
              child: SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: DummyData.categories.length,
                  itemBuilder: (context, index) {
                    final category = DummyData.categories[index];
                    final isSelected = category == selectedCategory;
                    
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.darkCharcoal : Colors.transparent,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(
                              color: isSelected ? AppTheme.darkCharcoal : AppTheme.borderGray,
                            ),
                          ),
                          child: Text(
                            category,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: isSelected ? AppTheme.pureWhite : AppTheme.softGray,
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 統計セクション（ダークセクション）
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.darkGradient,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                children: [
                  Text(
                    'LOVE STORIES\nSHARED TODAY',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.accentYellow,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          '${DummyData.clothingItems.length}',
                          '愛のエッセイ',
                          AppTheme.pureWhite,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildStatCard(
                          '${DummyData.clothingItems.fold(0, (sum, item) => sum + item.empathyCount)}',
                          '共感の総数',
                          AppTheme.pureWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 商品グリッド
          SliverPadding(
            padding: EdgeInsets.all(24.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = filteredItems[index];
                  return ClothingItemCard(
                    item: item,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.title} の詳細表示'),
                          backgroundColor: AppTheme.darkCharcoal,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: filteredItems.length,
              ),
            ),
          ),

          // フッタースペース
          SliverToBoxAdapter(
            child: SizedBox(height: 100.h),
          ),
        ],
      ),
      
      // 洗練されたフローティングアクションボタン
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('愛のエッセイを書く機能は開発中です'),
              backgroundColor: AppTheme.darkCharcoal,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          );
        },
        backgroundColor: AppTheme.accentYellow,
        foregroundColor: AppTheme.darkCharcoal,
        icon: Icon(Icons.edit, size: 20.sp),
        label: Text(
          '愛を語る',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // 洗練された下部ナビゲーション
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          border: Border(
            top: BorderSide(color: AppTheme.borderGray, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.darkCharcoal,
          unselectedItemColor: AppTheme.softGray,
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
          onTap: (index) {
            switch (index) {
              case 0:
                break;
              case 1:
                context.go('/category-search');
                break;
              case 2:
                _showSnackBar(context, '共感機能は開発中です');
                break;
              case 3:
                _showSnackBar(context, 'メッセージ機能は開発中です');
                break;
              case 4:
                context.go('/users');
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: textColor.withValues(alpha: 0.7),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.darkCharcoal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/dummy_data.dart';
import '../../utils/app_theme.dart';
import '../widgets/empathy_item_card.dart';

class HomePageContent extends ConsumerStatefulWidget {
  const HomePageContent({super.key});

  @override
  ConsumerState<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends ConsumerState<HomePageContent> {
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
              color: AppTheme.pureWhite,
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 24.h,
                bottom: 32.h,
              ),
              child: Column(
                children: [
                  // メインメッセージ
                  Text(
                    'その服に、あなたの"愛"は\nありますか？',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // 統計情報カード
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: AppTheme.subtleShadow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard('${DummyData.clothingItems.length}', '愛のエッセイ', AppTheme.darkCharcoal),
                        Container(
                          width: 1.w,
                          height: 40.h,
                          color: AppTheme.darkCharcoal.withValues(alpha: 0.2),
                        ),
                        _buildStatCard('1,247', '共感の総数', AppTheme.darkCharcoal),
                        Container(
                          width: 1.w,
                          height: 40.h,
                          color: AppTheme.darkCharcoal.withValues(alpha: 0.2),
                        ),
                        _buildStatCard('892', '新しい出会い', AppTheme.darkCharcoal),
                      ],
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
                    // 検索タブに切り替え（MainPageで管理される）
                    final mainPageState = context.findAncestorStateOfType<State>();
                    if (mainPageState != null && mainPageState.mounted) {
                      // MainPageの検索タブ（index: 1）にアニメーション付きで切り替え
                      // 注意: この方法は推奨されないので、後でProviderやNotifierで改善
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('下部の検索タブをタップしてください'),
                          backgroundColor: AppTheme.darkCharcoal,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
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

          // 愛を語るボタン
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.pureWhite,
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkCharcoal,
                  foregroundColor: AppTheme.pureWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      '愛を語る',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // アイテムグリッド
          SliverPadding(
            padding: EdgeInsets.all(24.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7, // 0.75 → 0.7にさらに調整して高さを増やす
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 20.h,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return EmpathyItemCard(
                    item: filteredItems[index],
                    onTap: () {
                      // アイテム詳細ページ（未実装）
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${filteredItems[index].title}の詳細ページ（未実装）'),
                          backgroundColor: AppTheme.darkCharcoal,
                        ),
                      );
                    },
                  );
                },
                childCount: filteredItems.length,
              ),
            ),
          ),
        ],
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
} 
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/clothing_item.dart';
import '../../utils/app_theme.dart';
import '../../utils/dummy_categories.dart';
import '../../utils/dummy_data.dart';
import '../widgets/clothing_item_card.dart';

class CategorySearchPage extends ConsumerStatefulWidget {
  const CategorySearchPage({super.key});

  @override
  ConsumerState<CategorySearchPage> createState() => _CategorySearchPageState();
}

class _CategorySearchPageState extends ConsumerState<CategorySearchPage> {
  final List<Category?> _selectedPath = [null, null, null, null, null];
  final List<ScrollController> _scrollControllers = List.generate(5, (index) => ScrollController());
  
  @override
  void dispose() {
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectCategory(Category category, int level) {
    setState(() {
      // 選択されたレベル以降をクリア
      for (int i = level; i < _selectedPath.length; i++) {
        _selectedPath[i] = null;
      }
      
      // 選択されたカテゴリを設定
      _selectedPath[level] = category;
    });
  }

  List<Category> _getCurrentCategories(int level) {
    switch (level) {
      case 0:
        return DummyCategories.mainCategories;
      case 1:
      case 2:
      case 3:
      case 4:
        final parent = _selectedPath[level - 1];
        return parent?.subcategories ?? [];
      default:
        return [];
    }
  }

  List<ClothingItem> _getFilteredItems() {
    // 最後に選択されたカテゴリに基づいてアイテムをフィルタリング
    final selectedCategory = _selectedPath.lastWhere((cat) => cat != null, orElse: () => null);
    if (selectedCategory == null) {
      return DummyData.clothingItems;
    }
    
    // 簡単なフィルタリング（実際にはもっと複雑なロジックが必要）
    return DummyData.clothingItems.where((item) {
      return item.category.toLowerCase().contains(selectedCategory.name.toLowerCase()) ||
             selectedCategory.name.toLowerCase().contains(item.category.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        title: Text(
          'カテゴリから探す',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, 
            color: AppTheme.darkCharcoal, size: 20.sp),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          // デバッグ用スキップボタン
          if (kDebugMode)
            Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: AppTheme.darkCharcoal.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () => context.go('/'),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home,
                          color: AppTheme.accentYellow,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'HOME',
                          style: TextStyle(
                            color: AppTheme.accentYellow,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ブレッドクラム
            _buildBreadcrumb(),
            
            // カテゴリナビゲーション
            Expanded(
              child: Row(
                children: [
                  // カテゴリカラム（最大5つ）
                  ..._buildCategoryColumns(),
                  
                  // 商品一覧カラム
                  _buildItemsColumn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb() {
    final selectedCategories = _selectedPath.where((cat) => cat != null).toList();
    
    if (selectedCategories.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            Icon(
              Icons.home_outlined,
              size: 16.sp,
              color: AppTheme.softGray,
            ),
            SizedBox(width: 8.w),
            Text(
              'カテゴリトップ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.softGray,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(
              Icons.home_outlined,
              size: 16.sp,
              color: AppTheme.softGray,
            ),
                         SizedBox(width: 8.w),
             ...selectedCategories.asMap().entries.map((entry) {
               final index = entry.key;
               final category = entry.value!;
               final isLast = index == selectedCategories.length - 1;
               
               return Row(
                 children: [
                   if (index > 0) ...[
                     SizedBox(width: 4.w),
                     Icon(
                       Icons.chevron_right,
                       size: 16.sp,
                       color: AppTheme.softGray,
                     ),
                     SizedBox(width: 4.w),
                   ],
                   Text(
                     category.name,
                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                       color: isLast ? AppTheme.darkCharcoal : AppTheme.softGray,
                       fontWeight: isLast ? FontWeight.w500 : FontWeight.normal,
                     ),
                   ),
                 ],
               );
             }),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategoryColumns() {
    final List<Widget> columns = [];
    
    for (int level = 0; level < 5; level++) {
      final categories = _getCurrentCategories(level);
      final selectedCategory = _selectedPath[level];
      
      if (categories.isEmpty && level > 0) break;
      
      columns.add(_buildCategoryColumn(categories, level, selectedCategory));
    }
    
    return columns;
  }

  Widget _buildCategoryColumn(List<Category> categories, int level, Category? selectedCategory) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppTheme.borderGray,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                     // カラムヘッダー
           Container(
             padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppTheme.lightGray,
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.borderGray,
                  width: 0.5,
                ),
              ),
            ),
                         child: Text(
               _getColumnTitle(level),
               style: Theme.of(context).textTheme.labelMedium?.copyWith(
                 fontWeight: FontWeight.w500,
                 color: AppTheme.darkCharcoal,
                 fontSize: 11.sp,
               ),
             ),
          ),
          
          // カテゴリリスト
          Expanded(
            child: ListView.builder(
              controller: _scrollControllers[level],
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                
                return _buildCategoryItem(category, level, isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Category category, int level, bool isSelected) {
    return Material(
      color: isSelected ? AppTheme.accentYellow.withValues(alpha: 0.1) : Colors.transparent,
      child: InkWell(
        onTap: () => _selectCategory(category, level),
                 child: Container(
           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppTheme.borderGray.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
                             if (category.icon != null) ...[
                 Text(
                   category.icon!,
                   style: TextStyle(fontSize: 12.sp),
                 ),
                 SizedBox(width: 6.w),
               ],
                             Expanded(
                 child: Text(
                   category.name,
                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                     color: isSelected ? AppTheme.darkCharcoal : AppTheme.darkCharcoal,
                     fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                     fontSize: 12.sp,
                   ),
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
                             if (category.hasSubcategories)
                 Icon(
                   Icons.chevron_right,
                   size: 14.sp,
                   color: AppTheme.softGray,
                 ),
            ],
          ),
        ),
      ),
    );
  }

     Widget _buildItemsColumn() {
     final items = _getFilteredItems();
     
     return Expanded(
       child: Container(
         color: AppTheme.pureWhite,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
                     // アイテムヘッダー
           Container(
             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppTheme.lightGray,
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.borderGray,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '商品一覧 (${items.length}件)',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkCharcoal,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'ソート',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.sort,
                      size: 16.sp,
                      color: AppTheme.softGray,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // アイテムグリッド
          Expanded(
            child: items.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: EdgeInsets.all(8.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ClothingItemCard(item: items[index]);
                    },
                  ),
          ),
        ],
      ),
    ),
  );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.sp,
            color: AppTheme.softGray,
          ),
          SizedBox(height: 16.h),
          Text(
            'このカテゴリの商品が\n見つかりませんでした',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.softGray,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedPath.fillRange(0, _selectedPath.length, null);
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.darkCharcoal,
              side: BorderSide(color: AppTheme.borderGray),
            ),
            child: Text('カテゴリをリセット'),
          ),
        ],
      ),
    );
  }

  String _getColumnTitle(int level) {
    switch (level) {
      case 0:
        return 'カテゴリ';
      case 1:
        return 'サブカテゴリ';
      case 2:
        return '詳細カテゴリ';
      case 3:
        return '商品タイプ';
      case 4:
        return 'ブランド/特徴';
      default:
        return '';
    }
  }
} 
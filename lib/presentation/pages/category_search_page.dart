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
  // 現在の階層レベル（0: メインカテゴリ, 1: サブカテゴリ, etc.）
  int _currentLevel = 0;
  
  // 選択されたカテゴリのパス
  final List<Category> _selectedPath = [];
  
  // 検索テキストコントローラー
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 現在のレベルに表示するカテゴリを取得
  List<Category> _getCurrentCategories() {
    if (_currentLevel == 0) {
      return DummyCategories.mainCategories;
    }
    
    if (_selectedPath.length < _currentLevel) {
      return [];
    }
    
    final parentCategory = _selectedPath[_currentLevel - 1];
    return DummyCategories.getSubcategories(parentCategory.id);
  }

  // カテゴリ選択時の処理
  void _selectCategory(Category category) {
    setState(() {
      // 現在のレベルが選択パス長以上の場合、パスを拡張
      if (_currentLevel >= _selectedPath.length) {
        _selectedPath.add(category);
      } else {
        // 既存のパスを更新し、それ以降をクリア
        _selectedPath[_currentLevel] = category;
        _selectedPath.removeRange(_currentLevel + 1, _selectedPath.length);
      }
    });
    
    // サブカテゴリが存在するかチェック
    final subcategories = DummyCategories.getSubcategories(category.id);
    if (subcategories.isNotEmpty) {
      // 次のレベルに進む
      setState(() {
        _currentLevel++;
      });
    } else {
      // 商品一覧レベルに進む
      setState(() {
        _currentLevel = 99; // 商品一覧を示す特別な値
      });
    }
  }

  // 戻るボタンの処理
  void _goBack() {
    if (_currentLevel > 0) {
      setState(() {
        if (_currentLevel == 99) {
          // 商品一覧から戻る場合
          _currentLevel = _selectedPath.length - 1;
        } else {
          _currentLevel--;
          if (_selectedPath.length > _currentLevel) {
            _selectedPath.removeAt(_selectedPath.length - 1);
          }
        }
      });
    } else {
      // トップレベルから戻る場合
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    }
  }

  // ブレッドクラムのタイトルを取得
  String _getPageTitle() {
    if (_currentLevel == 0) {
      return 'カテゴリ';
    } else if (_currentLevel == 99) {
      return '商品一覧 (${_getFilteredItems().length}件)';
    } else if (_selectedPath.isNotEmpty) {
      return _selectedPath.last.name;
    }
    return 'カテゴリから探す';
  }

  // フィルタされた商品を取得
  List<ClothingItem> _getFilteredItems() {
    if (_selectedPath.isEmpty) {
      return DummyData.clothingItems.take(3).toList();
    }

    final selectedCategory = _selectedPath.last;
    final filteredItems = DummyData.clothingItems.where((item) {
      return _isRelatedCategory(selectedCategory.name, item.category);
    }).toList();

    if (filteredItems.isEmpty) {
      return DummyData.clothingItems.take(3).toList();
    }

    return filteredItems;
  }

  bool _isRelatedCategory(String selectedCategory, String itemCategory) {
    final categoryMappings = {
      'アウター': ['コート', 'ジャケット', 'カーディガン', 'ブレザー'],
      'トップス': ['シャツ', 'ブラウス', 'ニット', 'セーター', 'tシャツ'],
      'ボトムス': ['パンツ', 'スカート', 'ジーンズ', 'ショートパンツ'],
      'コート': ['アウター'],
      'ジャケット': ['アウター'],
    };

    for (final entry in categoryMappings.entries) {
      if (selectedCategory.contains(entry.key.toLowerCase())) {
        return entry.value.any((related) =>
            itemCategory.contains(related.toLowerCase()));
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        title: Text(
          _getPageTitle(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: AppTheme.darkCharcoal, size: 20.sp),
          onPressed: _goBack,
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
            // 検索バー
            _buildSearchBar(),
            
            // ブレッドクラム
            if (_selectedPath.isNotEmpty) _buildBreadcrumb(),
            
            // コンテンツ
            Expanded(
              child: _currentLevel == 99 ? _buildProductGrid() : _buildCategoryList(),
            ),
          ],
        ),
      ),
    );
  }

  // 検索バーを構築
  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.lightGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'カテゴリを検索',
          hintStyle: TextStyle(
            color: AppTheme.softGray,
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.softGray,
            size: 20.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: AppTheme.darkCharcoal,
        ),
      ),
    );
  }

  // ブレッドクラムを構築
  Widget _buildBreadcrumb() {
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _selectedPath.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;
                  final isLast = index == _selectedPath.length - 1;

                  return Row(
                    children: [
                      if (index == 0) ...[
                        Text(
                          'カテゴリ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.softGray,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.chevron_right,
                          size: 16.sp,
                          color: AppTheme.softGray,
                        ),
                        SizedBox(width: 4.w),
                      ] else ...[
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
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // カテゴリリストを構築
  Widget _buildCategoryList() {
    final categories = _getCurrentCategories();
    
    if (categories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 48.sp,
              color: AppTheme.softGray,
            ),
            SizedBox(height: 16.h),
            Text(
              'カテゴリが見つかりません',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.softGray,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final hasSubcategories = DummyCategories.getSubcategories(category.id).isNotEmpty;
        
        return _buildCategoryItem(category, hasSubcategories);
      },
    );
  }

  // カテゴリアイテムを構築
  Widget _buildCategoryItem(Category category, bool hasSubcategories) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Material(
        color: AppTheme.pureWhite,
        child: InkWell(
          onTap: () => _selectCategory(category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                // カテゴリアイコン
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGray,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: category.icon != null
                      ? Text(
                          category.icon!,
                          style: TextStyle(fontSize: 18.sp),
                          textAlign: TextAlign.center,
                        )
                      : Icon(
                          Icons.category,
                          size: 18.sp,
                          color: AppTheme.darkCharcoal,
                        ),
                ),
                SizedBox(width: 12.w),
                
                // カテゴリ名
                Expanded(
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                ),
                
                // 右矢印（サブカテゴリがある場合）
                if (hasSubcategories)
                  Icon(
                    Icons.chevron_right,
                    size: 20.sp,
                    color: AppTheme.softGray,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 商品グリッドを構築
  Widget _buildProductGrid() {
    final items = _getFilteredItems();
    
    return Column(
      children: [
        // ソートバー
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        
        // 商品グリッド
        Expanded(
          child: items.isEmpty
              ? _buildEmptyState()
              : GridView.builder(
                  padding: EdgeInsets.all(8.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.42, // モバイル最適化: 十分な高さを確保
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ClothingItemCard(
                      item: items[index],
                      onTap: () {
                        // TODO: 商品詳細ページに遷移
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  // 空の状態を構築
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
            '商品が見つかりません',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.softGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '他のカテゴリをお試しください',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.softGray,
            ),
          ),
        ],
      ),
    );
  }
} 
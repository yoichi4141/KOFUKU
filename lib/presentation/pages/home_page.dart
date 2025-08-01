import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../utils/dummy_data.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'KOFUKU',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 検索バー
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: '愛のエッセイを検索...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),

          // カテゴリータブ
          Container(
            color: Colors.white,
            height: 60.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: DummyData.categories.length,
              itemBuilder: (context, index) {
                final category = DummyData.categories[index];
                final isSelected = category == selectedCategory;
                
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(height: 1.h, color: Colors.grey[200]),

          // 愛の統計セクション
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    '今日語られた愛',
                    '${DummyData.clothingItems.length}',
                    Icons.favorite,
                    Colors.red[400]!,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    '共感の総数',
                    '${DummyData.clothingItems.fold(0, (sum, item) => sum + item.empathyCount)}',
                    Icons.sentiment_satisfied_alt,
                    Colors.orange[400]!,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // アイテムグリッド
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ClothingItemCard(
                  item: item,
                  onTap: () {
                    // TODO: アイテム詳細画面への遷移
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.title} の詳細表示'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      
      // メルカリ風フローティングアクションボタン
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: 愛のエッセイ投稿画面への遷移
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('愛のエッセイを書く機能は開発中です'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.edit, color: Colors.white),
        label: Text(
          '愛を語る',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // 下部ナビゲーション
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '共感',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'メッセージ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'マイページ',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // ホーム（現在のページ）
              break;
            case 1:
              // 検索ページ
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('検索機能は開発中です')),
              );
              break;
            case 2:
              // 共感ページ
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('共感機能は開発中です')),
              );
              break;
            case 3:
              // メッセージ
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('メッセージ機能は開発中です')),
              );
              break;
            case 4:
              // マイページ（既存のユーザー一覧に遷移）
              context.go('/users');
              break;
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.sp, color: color),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
} 
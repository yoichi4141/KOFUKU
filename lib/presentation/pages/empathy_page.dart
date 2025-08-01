import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/empathy.dart';
import '../../utils/app_theme.dart';
import '../../utils/dummy_data.dart';
import '../view_models/empathy_view_model.dart';
import '../widgets/empathy_item_card.dart';

class EmpathyPage extends ConsumerStatefulWidget {
  const EmpathyPage({super.key});

  @override
  ConsumerState<EmpathyPage> createState() => _EmpathyPageState();
}

class _EmpathyPageState extends ConsumerState<EmpathyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  EmpathyType? _selectedType;

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
    final userEmpathiesAsync = ref.watch(userEmpathyListProvider);

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: AppTheme.darkCharcoal,
              size: 22.sp,
            ),
            onPressed: _showFilterDialog,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.darkCharcoal,
          unselectedLabelColor: AppTheme.softGray,
          indicatorColor: AppTheme.loveRed,
          indicatorWeight: 2.h,
          labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: '共感したアイテム'),
            Tab(text: '共感統計'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 共感したアイテム一覧
          _buildEmpathizedItemsList(userEmpathiesAsync),
          // 共感統計
          _buildEmpathyStats(userEmpathiesAsync),
        ],
      ),
    );
  }

  Widget _buildEmpathizedItemsList(AsyncValue<List<Empathy>> userEmpathiesAsync) {
    return userEmpathiesAsync.when(
      data: (empathies) {
        // フィルタリング
        final filteredEmpathies = _selectedType != null
            ? empathies.where((e) => e.type == _selectedType).toList()
            : empathies;

        if (filteredEmpathies.isEmpty) {
          return _buildEmptyState();
        }

        // アイテムデータを取得
        final items = filteredEmpathies
            .map((empathy) => DummyData.clothingItems
                .where((item) => item.id == empathy.itemId)
                .firstOrNull)
            .where((item) => item != null)
            .toList();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(userEmpathyListProvider);
          },
          child: CustomScrollView(
            slivers: [
              // フィルタ情報
              if (_selectedType != null)
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppTheme.accentYellow.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppTheme.accentYellow.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _selectedType!.emoji,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '「${_selectedType!.displayName}」でフィルタ中',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.darkCharcoal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedType = null;
                            });
                          },
                          child: Icon(
                            Icons.close,
                            size: 18.sp,
                            color: AppTheme.darkCharcoal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // アイテムグリッド
              SliverPadding(
                padding: EdgeInsets.all(16.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      final empathy = filteredEmpathies[index];
                      
                      return Column(
                        children: [
                          Expanded(
                            child: EmpathyItemCard(
                              item: item!,
                              onTap: () {
                                // アイテム詳細ページに遷移（未実装）
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item.title}の詳細ページ（未実装）'),
                                    backgroundColor: AppTheme.darkCharcoal,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 4.h),
                          // 共感タイプ表示
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.loveRed.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  empathy.type.emoji,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  empathy.type.displayName,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 9.sp,
                                    color: AppTheme.loveRed,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(
          color: AppTheme.loveRed,
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: AppTheme.softGray,
            ),
            SizedBox(height: 16.h),
            Text(
              'エラーが発生しました',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.softGray,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.softGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpathyStats(AsyncValue<List<Empathy>> userEmpathiesAsync) {
    return userEmpathiesAsync.when(
      data: (empathies) {
        // 統計データを計算
        final typeStats = <EmpathyType, int>{};
        for (final empathy in empathies) {
          typeStats[empathy.type] = (typeStats[empathy.type] ?? 0) + 1;
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 総合統計
              _buildStatCard(
                title: '総共感数',
                value: empathies.length.toString(),
                icon: Icons.favorite,
                color: AppTheme.loveRed,
              ),
              SizedBox(height: 16.h),

              // タイプ別統計
              Text(
                '共感タイプ別統計',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              SizedBox(height: 12.h),
              
              ...EmpathyType.values.map((type) {
                final count = typeStats[type] ?? 0;
                final percentage = empathies.isNotEmpty
                    ? (count / empathies.length * 100).round()
                    : 0;
                
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _buildTypeStatRow(type, count, percentage),
                );
              }),

              SizedBox(height: 24.h),

              // 最近の共感活動
              Text(
                '最近の共感活動',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              SizedBox(height: 12.h),

              ...empathies.take(5).map((empathy) {
                final item = DummyData.clothingItems
                    .where((item) => item.id == empathy.itemId)
                    .firstOrNull;
                
                if (item == null) return const SizedBox.shrink();
                
                return _buildRecentEmpathyItem(empathy, item);
              }),
            ],
          ),
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(color: AppTheme.loveRed),
      ),
      error: (error, stack) => Center(
        child: Text('統計の読み込みに失敗しました'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
            'まだ共感したアイテムがありません',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.softGray,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'ホーム画面で気になるアイテムに\n共感してみましょう',
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

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: AppTheme.subtleShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.softGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeStatRow(EmpathyType type, int count, int percentage) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppTheme.borderGray),
      ),
      child: Row(
        children: [
          Text(
            type.emoji,
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.displayName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkCharcoal,
                      ),
                    ),
                    Text(
                      '$count回 ($percentage%)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                LinearProgressIndicator(
                  value: count > 0 ? count / 10 : 0, // 仮の最大値
                  backgroundColor: AppTheme.borderGray,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.loveRed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentEmpathyItem(Empathy empathy, item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppTheme.borderGray),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppTheme.lightGray,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: item.imageUrls.isNotEmpty
                  ? Image.network(
                      item.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Icon(
                        Icons.image_outlined,
                        size: 20.sp,
                        color: AppTheme.softGray,
                      ),
                    )
                  : Icon(
                      Icons.image_outlined,
                      size: 20.sp,
                      color: AppTheme.softGray,
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkCharcoal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  item.ownerPenName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.softGray,
                  ),
                ),
              ],
            ),
          ),
          Text(
            empathy.type.emoji,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '共感タイプでフィルタ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.darkCharcoal,
              ),
            ),
            SizedBox(height: 24.h),
            
            // 全て表示オプション
            ListTile(
              leading: Icon(Icons.all_inclusive, color: AppTheme.darkCharcoal),
              title: Text('すべて表示'),
              onTap: () {
                setState(() {
                  _selectedType = null;
                });
                Navigator.pop(context);
              },
            ),
            
            // 各タイプオプション
            ...EmpathyType.values.map((type) => ListTile(
              leading: Text(type.emoji, style: TextStyle(fontSize: 24.sp)),
              title: Text(type.displayName),
              onTap: () {
                setState(() {
                  _selectedType = type;
                });
                Navigator.pop(context);
              },
            )),
            
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/empathy.dart';
import '../../utils/app_theme.dart';
import '../view_models/empathy_view_model.dart';

class EmpathyButton extends ConsumerStatefulWidget {
  final String itemId;
  final EmpathyType type;
  final bool showCount;
  final VoidCallback? onPressed;

  const EmpathyButton({
    super.key,
    required this.itemId,
    this.type = EmpathyType.love,
    this.showCount = true,
    this.onPressed,
  });

  @override
  ConsumerState<EmpathyButton> createState() => _EmpathyButtonState();
}

class _EmpathyButtonState extends ConsumerState<EmpathyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    // アニメーション開始
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // カスタムコールバックがあれば実行
    widget.onPressed?.call();

    // 共感状態を切り替え
    final notifier = ref.read(userItemEmpathyProvider(widget.itemId).notifier);
    notifier.toggle(type: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final isEmpathizedAsync = ref.watch(userItemEmpathyProvider(widget.itemId));
    final statsAsync = ref.watch(itemEmpathyStatsProvider(widget.itemId));

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: GestureDetector(
              onTap: _onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 共感アイコン
                  isEmpathizedAsync.when(
                    data: (isEmpathized) => Icon(
                      isEmpathized ? Icons.favorite : Icons.favorite_border,
                      size: 20.sp,
                      color: isEmpathized 
                          ? AppTheme.loveRed 
                          : AppTheme.softGray,
                    ),
                    loading: () => Icon(
                      Icons.favorite_border,
                      size: 20.sp,
                      color: AppTheme.softGray,
                    ),
                    error: (error, stack) => Icon(
                      Icons.favorite_border,
                      size: 20.sp,
                      color: AppTheme.softGray,
                    ),
                  ),

                  // 共感数
                  if (widget.showCount) ...[
                    SizedBox(width: 4.w),
                    statsAsync.when(
                      data: (stats) => Text(
                        stats.totalCount.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: isEmpathizedAsync.value == true 
                              ? AppTheme.loveRed 
                              : AppTheme.softGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      loading: () => Text(
                        '0',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: AppTheme.softGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      error: (error, stack) => Text(
                        '0',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: AppTheme.softGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// マルチタイプ共感ボタン（長押しで詳細選択）
class MultiEmpathyButton extends ConsumerStatefulWidget {
  final String itemId;
  final bool showCount;

  const MultiEmpathyButton({
    super.key,
    required this.itemId,
    this.showCount = true,
  });

  @override
  ConsumerState<MultiEmpathyButton> createState() => _MultiEmpathyButtonState();
}

class _MultiEmpathyButtonState extends ConsumerState<MultiEmpathyButton> {
  void _showEmpathyTypeSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => EmpathyTypeSelector(
        itemId: widget.itemId,
        onSelected: (type) {
          Navigator.of(context).pop();
          final notifier = ref.read(userItemEmpathyProvider(widget.itemId).notifier);
          notifier.toggle(type: type);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 通常のタップは愛タイプ
        final notifier = ref.read(userItemEmpathyProvider(widget.itemId).notifier);
        notifier.toggle(type: EmpathyType.love);
      },
      onLongPress: _showEmpathyTypeSelector,
      child: EmpathyButton(
        itemId: widget.itemId,
        type: EmpathyType.love,
        showCount: widget.showCount,
      ),
    );
  }
}

// 共感タイプ選択ダイアログ
class EmpathyTypeSelector extends StatelessWidget {
  final String itemId;
  final Function(EmpathyType) onSelected;

  const EmpathyTypeSelector({
    super.key,
    required this.itemId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ハンドル
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppTheme.softGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // タイトル
          Text(
            'どんな気持ちですか？',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.darkCharcoal,
            ),
          ),
          SizedBox(height: 24.h),

          // 共感タイプ一覧
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            children: EmpathyType.values.map((type) {
              return GestureDetector(
                onTap: () => onSelected(type),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGray,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppTheme.borderGray),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        type.emoji,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        type.displayName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkCharcoal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
} 
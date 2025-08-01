import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/clothing_item.dart';
import '../../utils/app_theme.dart';
import 'empathy_button.dart';

class EmpathyItemCard extends StatelessWidget {
  final ClothingItem item;
  final VoidCallback? onTap;

  const EmpathyItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppTheme.borderGray,
            width: 0.5,
          ),
          boxShadow: AppTheme.subtleShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 画像部分
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.lightGray,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.r),
                  ),
                ),
                child: Stack(
                  children: [
                    // メイン画像
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.r),
                      ),
                      child: item.imageUrls.isNotEmpty
                          ? Image.network(
                              item.imageUrls.first,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppTheme.lightGray,
                                  child: Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 40.sp,
                                      color: AppTheme.softGray,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: AppTheme.lightGray,
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 40.sp,
                                  color: AppTheme.softGray,
                                ),
                              ),
                            ),
                    ),

                    // 共感ボタン（右上）
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.pureWhite.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.darkCharcoal.withValues(alpha: 0.1),
                              blurRadius: 4.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: EmpathyButton(
                          itemId: item.id,
                          showCount: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // コンテンツ部分
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h), // パディングをさらに縮小
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 最小サイズに制限
                  children: [
                    // タイトル
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 11.sp, // 12sp → 11spにさらに調整
                        fontWeight: FontWeight.w500,
                        height: 1.15, // 1.2 → 1.15にさらに調整
                        color: AppTheme.darkCharcoal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: 2.h), // 3h → 2hにさらに調整
                    
                    // ペンネーム
                    Text(
                      item.ownerPenName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 8.sp, // 9sp → 8spにさらに調整
                        color: AppTheme.softGray,
                        letterSpacing: 0.05, // 0.1 → 0.05にさらに調整
                      ),
                    ),
                    
                    SizedBox(height: 4.h), // 6h → 4hに調整
                    
                    // 価格
                    Row(
                      children: [
                        Text(
                          '¥${item.price.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},',
                          )}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 12.sp, // 13sp → 12spにさらに調整
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkCharcoal,
                          ),
                        ),
                        const Spacer(),
                        // 愛のエッセイアイコン
                        Icon(
                          Icons.article_outlined,
                          size: 10.sp, // 12sp → 10spにさらに調整
                          color: AppTheme.accentYellow,
                        ),
                        SizedBox(width: 1.w), // 2w → 1wに調整
                        Text(
                          'Essay',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 7.sp, // 8sp → 7spにさらに調整
                            color: AppTheme.accentYellow,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
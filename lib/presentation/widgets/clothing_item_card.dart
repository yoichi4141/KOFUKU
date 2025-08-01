import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/clothing_item.dart';
import '../../utils/app_theme.dart';

class ClothingItemCard extends StatelessWidget {
  final ClothingItem item;
  final VoidCallback? onTap;

  const ClothingItemCard({
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
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.r),
                  ),
                  child: item.imageUrls.isNotEmpty
                      ? Image.network(
                          item.imageUrls.first,
                          fit: BoxFit.cover,
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
              ),
            ),
            
            // コンテンツ部分
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h), // モバイル最適化: 適切な余白
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 最小サイズに制限
                  children: [
                    // タイトル
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13.sp, // モバイル最適化: 読みやすいサイズに復元
                        fontWeight: FontWeight.w500,
                        height: 1.3, // 読みやすい行間に復元
                        color: AppTheme.darkCharcoal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: 4.h), // 適切な間隔に復元
                    
                    // ペンネーム
                    Text(
                      item.ownerPenName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp, // モバイル最適化: 読みやすいサイズに復元
                        color: AppTheme.softGray,
                        letterSpacing: 0.1, // 適切な文字間隔に復元
                      ),
                    ),
                    
                    SizedBox(height: 6.h), // 適切な間隔に復元
                    
                    // 価格と共感数
                    Row(
                      children: [
                        // 価格
                        Text(
                          '¥${item.price.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},',
                          )}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp, // モバイル最適化: 重要な価格情報を見やすく
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkCharcoal,
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // 共感数
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 12.sp, // モバイル最適化: タッチしやすいサイズに復元
                              color: AppTheme.loveRed,
                            ),
                            SizedBox(width: 3.w), // 適切な間隔に復元
                            Text(
                              item.empathyCount.toString(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 10.sp, // モバイル最適化: 読みやすいサイズに復元
                                color: AppTheme.loveRed,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
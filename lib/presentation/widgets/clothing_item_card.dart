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
              flex: 2,
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
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h), // さらにパディング圧縮
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 最小サイズに制限
                  children: [
                    // タイトル
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 10.sp, // 11sp → 10spにさらに調整
                        fontWeight: FontWeight.w500,
                        height: 1.1, // 1.15 → 1.1にさらに調整
                        color: AppTheme.darkCharcoal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: 1.h), // 2h → 1hにさらに調整
                    
                    // ペンネーム
                    Text(
                      item.ownerPenName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 7.sp, // 8sp → 7spにさらに調整
                        color: AppTheme.softGray,
                        letterSpacing: 0.0, // 0.05 → 0.0にさらに調整
                      ),
                    ),
                    
                    SizedBox(height: 2.h), // 4h → 2hにさらに調整
                    
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
                            fontSize: 11.sp, // 12sp → 11spにさらに調整
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
                              size: 9.sp, // 10sp → 9spにさらに調整
                              color: AppTheme.loveRed,
                            ),
                            SizedBox(width: 1.w), // 2w → 1wにさらに調整
                            Text(
                              item.empathyCount.toString(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 7.sp, // 8sp → 7spにさらに調整
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
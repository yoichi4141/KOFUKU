import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_theme.dart';
import '../../utils/dummy_notification_data.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        title: Text(
          '背き（通知）',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.darkCharcoal,
            size: 20.sp,
          ),
        ),
        actions: [
          TextButton(
                         onPressed: () {
               setState(() {
                 DummyNotificationData.markAllAsRead();
               });
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                   content: Text('すべて既読にしました'),
                   backgroundColor: AppTheme.darkCharcoal,
                   behavior: SnackBarBehavior.floating,
                   duration: Duration(seconds: 2),
                 ),
               );
             },
            child: Text(
              'すべて既読',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.loveRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
             body: ListView(
         children: _buildNotificationList(),
       ),
    );
  }

  Widget _buildTimeSection(String title) {
    return Container(
      color: AppTheme.pureWhite,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.darkCharcoal,
        ),
      ),
    );
  }



  Widget _getAvatarImage(String name) {
    // 実際の実装では、ユーザーのプロフィール画像を表示します
    // ここではダミーとして色分けされたアイコンを使用
    final colors = [
      AppTheme.loveRed,
      AppTheme.accentYellow,
      AppTheme.darkCharcoal,
      Colors.purple,
      Colors.green,
      Colors.orange,
    ];
    
    final colorIndex = name.hashCode % colors.length;
    final color = colors[colorIndex];

    return Container(
      color: color.withValues(alpha: 0.1),
      child: Icon(
        Icons.person,
        color: color,
        size: 24.sp,
      ),
    );
  }

  Widget _getItemImage() {
    // 実際の実装では、関連するアイテムの画像を表示します
    // ここではダミーとして衣類アイコンを使用
    return Container(
      color: AppTheme.lightGray.withValues(alpha: 0.5),
      child: Icon(
        Icons.checkroom,
        color: AppTheme.softGray,
        size: 20.sp,
      ),
    );
  }

  String _extractUserName(String fullName) {
    // 実際の実装では、適切なユーザー名抽出ロジックを使用
    if (fullName.contains(' ')) {
      return fullName.split(' ').first;
    }
    return fullName;
  }

  List<Widget> _buildNotificationList() {
    final List<Widget> widgets = [];
    final groupedNotifications = DummyNotificationData.groupedNotifications;
    
    groupedNotifications.forEach((sectionTitle, notifications) {
      // セクションタイトル
      widgets.add(_buildTimeSection(sectionTitle));
      
      // 通知アイテム
      for (final notification in notifications) {
        widgets.add(_buildNotificationItemFromData(notification));
      }
      
      // セクション間のスペース
      if (sectionTitle != groupedNotifications.keys.last) {
        widgets.add(SizedBox(height: 16.h));
      }
    });
    
    widgets.add(SizedBox(height: 80.h));
    return widgets;
  }

  Widget _buildNotificationItemFromData(NotificationData notification) {
    return GestureDetector(
      onTap: () {
        if (!notification.isRead) {
          setState(() {
            DummyNotificationData.markAsRead(notification.id);
          });
        }
      },
      child: Container(
        color: notification.isRead 
            ? AppTheme.pureWhite 
            : AppTheme.lightGray.withValues(alpha: 0.3),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ユーザーアバター
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.borderGray, width: 1),
              ),
              child: ClipOval(
                child: _getAvatarImage(notification.userName),
              ),
            ),

            SizedBox(width: 12.w),

            // 通知内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // メッセージテキスト
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.darkCharcoal,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: _extractUserName(notification.userName),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' '),
                        TextSpan(text: notification.message),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // 時間表示
                  Text(
                    notification.timeAgo,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.softGray,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),

            // アイテム画像（条件付き表示）
            if (notification.itemId != null) ...[
              SizedBox(width: 12.w),
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightGray,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppTheme.borderGray, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.r),
                  child: _getItemImage(),
                ),
              ),
            ],

            // 未読インジケーター
            if (!notification.isRead) ...[
              SizedBox(width: 8.w),
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppTheme.loveRed,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 
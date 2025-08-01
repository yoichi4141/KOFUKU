class NotificationData {
  final String id;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final NotificationType type;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? itemId;
  final String? itemImageUrl;

  const NotificationData({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.type,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.itemId,
    this.itemImageUrl,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}時間前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日前';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).round()}週間前';
    } else {
      return '${(difference.inDays / 30).round()}ヶ月前';
    }
  }
}

enum NotificationType {
  empathy,      // 共感
  comment,      // コメント
  follow,       // フォロー
  mention,      // メンション
  itemUsed,     // アイテム使用
  newPost,      // 新規投稿
}

class DummyNotificationData {
  static final List<NotificationData> notifications = [
    // 本日の朝（七時）
    NotificationData(
      id: '1',
      userId: 'suzuki_masami',
      userName: '鈴木 雅美',
      userAvatarUrl: '',
      type: NotificationType.newPost,
      message: 'さんのアカウント 洋女な気分で夏服をチョイ。豊かで本当に涼しく感じたので結構な気にって',
      timestamp: DateTime.now().subtract(Duration(minutes: 45)),
      isRead: false,
      itemId: 'item_1',
      itemImageUrl: 'https://example.com/item1.jpg',
    ),
    NotificationData(
      id: '2',
      userId: 'fujiki_masami',
      userName: '藤木 雅美',
      userAvatarUrl: '',
      type: NotificationType.newPost,
      message: 'さんのアカウント 新女中身が初めて古着の美しさに感激しました。豊かでスタイルし始めます。',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      isRead: false,
      itemId: 'item_2',
      itemImageUrl: 'https://example.com/item2.jpg',
    ),
    NotificationData(
      id: '3',
      userId: 'sato_masato',
      userName: '佐藤 雅人',
      userAvatarUrl: '',
      type: NotificationType.empathy,
      message: '田中 雅美、鈴木 雅美 あなたの投稿した古着に共感しました。豊か',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      isRead: false,
    ),
    NotificationData(
      id: '4',
      userId: 'suzuki_masami',
      userName: '鈴木 雅美',
      userAvatarUrl: '',
      type: NotificationType.newPost,
      message: 'さんのアカウント 洋女な気分でスタイルしまして、豊かで涼しく感じたので結構の気',
      timestamp: DateTime.now().subtract(Duration(hours: 3)),
      isRead: false,
      itemId: 'item_3',
      itemImageUrl: 'https://example.com/item3.jpg',
    ),

    // 昨日の夕刻
    NotificationData(
      id: '5',
      userId: 'abigail_hughes',
      userName: 'Abigail Hughes',
      userAvatarUrl: '',
      type: NotificationType.empathy,
      message: 'Leo Morris あなたの投稿した古着に共感しました。豊か',
      timestamp: DateTime.now().subtract(Duration(hours: 18)),
      isRead: true,
    ),
    NotificationData(
      id: '6',
      userId: 'stylist_syun',
      userName: 'スタイリストスユン',
      userAvatarUrl: '',
      type: NotificationType.itemUsed,
      message: '活中の本格を使用しました。🔥',
      timestamp: DateTime.now().subtract(Duration(hours: 19)),
      isRead: true,
      itemId: 'item_4',
      itemImageUrl: 'https://example.com/item4.jpg',
    ),
    NotificationData(
      id: '7',
      userId: 'naruko_hamasaki',
      userName: 'Naruko Hamasaki',
      userAvatarUrl: '',
      type: NotificationType.comment,
      message: 'あなたのちにされ好き、あなたの古今・古風に著書行きました。',
      timestamp: DateTime.now().subtract(Duration(hours: 19)),
      isRead: true,
      itemId: 'item_5',
      itemImageUrl: 'https://example.com/item5.jpg',
    ),
    NotificationData(
      id: '8',
      userId: 'naruko_hamasaki',
      userName: 'Naruko Hamasaki',
      userAvatarUrl: '',
      type: NotificationType.newPost,
      message: '独行の製品書で、活中に新行き結まして（始日）4時間',
      timestamp: DateTime.now().subtract(Duration(hours: 20)),
      isRead: true,
      itemId: 'item_6',
      itemImageUrl: 'https://example.com/item6.jpg',
    ),

    // かつての瞳き/技術の攻略
    NotificationData(
      id: '9',
      userId: 'abigail_hughes',
      userName: 'Abigail Hughes',
      userAvatarUrl: '',
      type: NotificationType.comment,
      message: 'Leo Morris あなたの古着に新しれちゃらさまこと、コメントをしました。',
      timestamp: DateTime.now().subtract(Duration(days: 28)),
      isRead: true,
    ),
    NotificationData(
      id: '10',
      userId: 'stylist_syun',
      userName: 'スタイリストスユン',
      userAvatarUrl: '',
      type: NotificationType.itemUsed,
      message: '活中の本格を使用しました。🔥',
      timestamp: DateTime.now().subtract(Duration(days: 28)),
      isRead: true,
      itemId: 'item_7',
      itemImageUrl: 'https://example.com/item7.jpg',
    ),
    NotificationData(
      id: '11',
      userId: 'suzuki_masami',
      userName: '鈴木 雅美',
      userAvatarUrl: '',
      type: NotificationType.newPost,
      message: 'さんのアカウント 一語記されろ　子商品のこころ活という結まました。豊か',
      timestamp: DateTime.now().subtract(Duration(days: 28)),
      isRead: true,
      itemId: 'item_8',
      itemImageUrl: 'https://example.com/item8.jpg',
    ),
    NotificationData(
      id: '12',
      userId: 'stylist_syun',
      userName: 'スタイリストスユン',
      userAvatarUrl: '',
      type: NotificationType.comment,
      message: '活中し。古風に著書行きました。',
      timestamp: DateTime.now().subtract(Duration(days: 28)),
      isRead: true,
      itemId: 'item_9',
      itemImageUrl: 'https://example.com/item9.jpg',
    ),
  ];

  // 時間帯別にグループ化
  static Map<String, List<NotificationData>> get groupedNotifications {
    final Map<String, List<NotificationData>> grouped = {};
    
    for (final notification in notifications) {
      final section = _getTimeSection(notification.timestamp);
      if (!grouped.containsKey(section)) {
        grouped[section] = [];
      }
      grouped[section]!.add(notification);
    }
    
    return grouped;
  }

  // 未読通知数
  static int get unreadCount {
    return notifications.where((n) => !n.isRead).length;
  }

  static String _getTimeSection(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inHours < 12 && 
        timestamp.day == now.day && 
        timestamp.hour >= 6 && timestamp.hour < 12) {
      return '本日の朝（七時）';
    } else if (difference.inDays == 1 || 
               (difference.inHours >= 12 && difference.inHours < 24)) {
      return '昨日の夕刻';
    } else {
      return 'かつての瞳き/技術の攻略';
    }
  }

  // 通知を既読にする
  static void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = NotificationData(
        id: notifications[index].id,
        userId: notifications[index].userId,
        userName: notifications[index].userName,
        userAvatarUrl: notifications[index].userAvatarUrl,
        type: notifications[index].type,
        message: notifications[index].message,
        timestamp: notifications[index].timestamp,
        isRead: true,
        itemId: notifications[index].itemId,
        itemImageUrl: notifications[index].itemImageUrl,
      );
    }
  }

  // すべてを既読にする
  static void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (!notifications[i].isRead) {
        notifications[i] = NotificationData(
          id: notifications[i].id,
          userId: notifications[i].userId,
          userName: notifications[i].userName,
          userAvatarUrl: notifications[i].userAvatarUrl,
          type: notifications[i].type,
          message: notifications[i].message,
          timestamp: notifications[i].timestamp,
          isRead: true,
          itemId: notifications[i].itemId,
          itemImageUrl: notifications[i].itemImageUrl,
        );
      }
    }
  }
} 
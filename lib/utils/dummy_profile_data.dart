import '../domain/entities/user.dart';
import '../domain/entities/user_profile.dart';

class DummyProfileData {
  // 現在のユーザー（あいこさん）
  static final User currentUser = User(
    id: 'user_001',
    name: 'あいこ',
    email: 'aiko@example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 180)),
  );

  // 現在のユーザープロフィール
  static final UserProfile currentUserProfile = UserProfile(
    user: currentUser,
    avatarUrl: 'https://example.com/avatars/aiko.jpg', // 実際はAssets使用
    penName: 'あいこ',
    bio: '古着に込められた愛のエッセイを書いています。一つ一つのアイテムには必ず物語があると信じています。✨\n\n大学でファッション史を学び、現在はヴィンテージショップで働きながら、服の持つストーリーを大切にしています。',
    location: '東京',
    birthDate: DateTime(1998, 3, 15),
    preferences: const UserPreferences(
      notificationsEnabled: true,
      emailNotifications: false,
      pushNotifications: true,
      privacyLevel: PrivacyLevel.normal,
      language: 'ja',
      themeMode: ThemeMode.system,
      showRealName: false,
    ),
    stats: UserStats(
      essaysCount: 12,
      empathyReceived: 156,
      empathyGiven: 89,
      itemsSold: 8,
      itemsPurchased: 15,
      messagesCount: 47,
      followersCount: 234,
      followingCount: 187,
      rating: 4.8,
      reviewsCount: 23,
      lastActiveAt: DateTime.now().subtract(const Duration(hours: 2)),
      joinedAt: DateTime.now().subtract(const Duration(days: 180)),
    ),
  );

  // サンプルユーザープロフィール一覧
  static final List<UserProfile> userProfiles = [
    currentUserProfile,
    
    UserProfile(
      user: User(
        id: 'user_002',
        name: 'みどり',
        email: 'midori@example.com',
        createdAt: DateTime.now().subtract(const Duration(days: 120)),
      ),
      avatarUrl: 'https://example.com/avatars/midori.jpg',
      penName: 'みどり',
      bio: 'サステナブルファッションに興味があります。エシカルな消費を心がけ、服の新しい価値を見つけています。',
      location: '大阪',
      birthDate: DateTime(1995, 7, 22),
      preferences: const UserPreferences(
        notificationsEnabled: true,
        emailNotifications: true,
        pushNotifications: true,
        privacyLevel: PrivacyLevel.public,
        language: 'ja',
        themeMode: ThemeMode.light,
        showRealName: true,
      ),
      stats: UserStats(
        essaysCount: 18,
        empathyReceived: 203,
        empathyGiven: 142,
        itemsSold: 12,
        itemsPurchased: 22,
        messagesCount: 73,
        followersCount: 312,
        followingCount: 256,
        rating: 4.9,
        reviewsCount: 31,
        lastActiveAt: DateTime.now().subtract(const Duration(minutes: 30)),
        joinedAt: DateTime.now().subtract(const Duration(days: 120)),
      ),
    ),

    UserProfile(
      user: User(
        id: 'user_003',
        name: 'さくら',
        email: 'sakura@example.com',
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
      avatarUrl: 'https://example.com/avatars/sakura.jpg',
      penName: 'さくら',
      bio: '母から受け継いだ着物を愛用しています。和装の美しさと現代ファッションの融合を探求中です。',
      location: '京都',
      birthDate: DateTime(2000, 4, 10),
      preferences: const UserPreferences(
        notificationsEnabled: true,
        emailNotifications: false,
        pushNotifications: false,
        privacyLevel: PrivacyLevel.private,
        language: 'ja',
        themeMode: ThemeMode.dark,
        showRealName: false,
      ),
      stats: UserStats(
        essaysCount: 7,
        empathyReceived: 98,
        empathyGiven: 67,
        itemsSold: 4,
        itemsPurchased: 9,
        messagesCount: 28,
        followersCount: 156,
        followingCount: 123,
        rating: 4.7,
        reviewsCount: 15,
        lastActiveAt: DateTime.now().subtract(const Duration(days: 1)),
        joinedAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
    ),
  ];

  // 最近のアクティビティ
  static final List<Map<String, dynamic>> recentActivities = [
    {
      'type': 'essay_posted',
      'title': '母のカシミヤコートに込めた愛',
      'time': DateTime.now().subtract(const Duration(hours: 3)),
      'icon': '📝',
      'description': '新しいエッセイを投稿しました',
    },
    {
      'type': 'empathy_received',
      'title': 'ヴィンテージデニムジャケット',
      'time': DateTime.now().subtract(const Duration(hours: 8)),
      'icon': '💖',
      'description': 'みどりさんから共感をもらいました',
    },
    {
      'type': 'item_sold',
      'title': '花柄ワンピース',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'icon': '🛍️',
      'description': 'アイテムが新しい家族のもとへ',
    },
    {
      'type': 'message_received',
      'title': 'さくらさんからメッセージ',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'icon': '💬',
      'description': 'エッセイについて素敵なメッセージをいただきました',
    },
    {
      'type': 'follower_gained',
      'title': '新しいフォロワー',
      'time': DateTime.now().subtract(const Duration(days: 3)),
      'icon': '👥',
      'description': 'ひかりさんがフォローしてくれました',
    },
  ];

  // 設定項目
  static final List<Map<String, dynamic>> settingsMenuItems = [
    {
      'title': 'プロフィール編集',
      'subtitle': 'ペンネーム、自己紹介などを変更',
      'icon': '👤',
      'action': 'edit_profile',
    },
    {
      'title': '通知設定',
      'subtitle': 'プッシュ通知、メール通知の設定',
      'icon': '🔔',
      'action': 'notification_settings',
    },
    {
      'title': 'プライバシー',
      'subtitle': '公開範囲、プライバシーレベルの設定',
      'icon': '🔒',
      'action': 'privacy_settings',
    },
    {
      'title': 'アカウント',
      'subtitle': 'メールアドレス、パスワードの変更',
      'icon': '⚙️',
      'action': 'account_settings',
    },
    {
      'title': 'テーマ',
      'subtitle': 'ライト・ダーク・システム',
      'icon': '🎨',
      'action': 'theme_settings',
    },
    {
      'title': 'ヘルプ・サポート',
      'subtitle': 'よくある質問、お問い合わせ',
      'icon': '❓',
      'action': 'help_support',
    },
    {
      'title': '利用規約',
      'subtitle': 'KOFUKUの利用規約を確認',
      'icon': '📄',
      'action': 'terms_of_service',
    },
    {
      'title': 'プライバシーポリシー',
      'subtitle': '個人情報の取り扱いについて',
      'icon': '🛡️',
      'action': 'privacy_policy',
    },
    {
      'title': 'ログアウト',
      'subtitle': 'アカウントからログアウトします',
      'icon': '🚪',
      'action': 'logout',
    },
  ];

  // 実績・バッジ
  static final List<Map<String, dynamic>> achievements = [
    {
      'title': '愛のエッセイスト',
      'description': '10個以上のエッセイを投稿',
      'icon': '📝',
      'earned': true,
      'earnedAt': DateTime.now().subtract(const Duration(days: 30)),
    },
    {
      'title': '共感の達人',
      'description': '100個以上の共感を受け取る',
      'icon': '💖',
      'earned': true,
      'earnedAt': DateTime.now().subtract(const Duration(days: 15)),
    },
    {
      'title': 'ストーリーテラー',
      'description': '感動的なエッセイで多くの共感を獲得',
      'icon': '✨',
      'earned': true,
      'earnedAt': DateTime.now().subtract(const Duration(days: 45)),
    },
    {
      'title': 'ヴィンテージ愛好家',
      'description': 'ヴィンテージアイテムを5個以上出品',
      'icon': '👗',
      'earned': false,
      'progress': 0.6, // 60%達成
    },
    {
      'title': 'コミュニティリーダー',
      'description': '200人以上のフォロワーを獲得',
      'icon': '👑',
      'earned': true,
      'earnedAt': DateTime.now().subtract(const Duration(days: 10)),
    },
    {
      'title': 'メッセンジャー',
      'description': '50通以上のメッセージをやりとり',
      'icon': '💬',
      'earned': false,
      'progress': 0.94, // 94%達成
    },
  ];

  // お気に入りカテゴリ
  static final List<String> favoriteCategories = [
    'ヴィンテージ',
    'デニム',
    'コート・アウター',
    'ワンピース',
    'アクセサリー',
  ];

  // よく使うタグ
  static final List<String> frequentTags = [
    '#愛のエッセイ',
    '#ヴィンテージ',
    '#思い出',
    '#サステナブル',
    '#ストーリー',
    '#母の愛',
    '#大切な服',
  ];
} 
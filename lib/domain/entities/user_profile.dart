import 'user.dart';

// ユーザープロフィール（拡張版）
class UserProfile {
  final User user; // 基本ユーザー情報
  final String? avatarUrl; // アバター画像URL
  final String? penName; // ペンネーム
  final String? bio; // 自己紹介
  final String? location; // 居住地
  final DateTime? birthDate; // 生年月日
  final UserPreferences preferences; // ユーザー設定
  final UserStats stats; // ユーザー統計

  const UserProfile({
    required this.user,
    this.avatarUrl,
    this.penName,
    this.bio,
    this.location,
    this.birthDate,
    required this.preferences,
    required this.stats,
  });

  // 表示用の名前（ペンネームがあれば優先、なければname）
  String get displayName => penName ?? user.name;

  // 年齢計算
  int? get age {
    if (birthDate == null) return null;
    final now = DateTime.now();
    int age = now.year - birthDate!.year;
    if (now.month < birthDate!.month || 
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  UserProfile copyWith({
    User? user,
    String? avatarUrl,
    String? penName,
    String? bio,
    String? location,
    DateTime? birthDate,
    UserPreferences? preferences,
    UserStats? stats,
  }) {
    return UserProfile(
      user: user ?? this.user,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      penName: penName ?? this.penName,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      birthDate: birthDate ?? this.birthDate,
      preferences: preferences ?? this.preferences,
      stats: stats ?? this.stats,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.user == user &&
        other.avatarUrl == avatarUrl &&
        other.penName == penName &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return Object.hash(user, avatarUrl, penName, bio);
  }

  @override
  String toString() {
    return 'UserProfile(id: ${user.id}, penName: $penName, stats: $stats)';
  }
}

// ユーザー設定
class UserPreferences {
  final bool notificationsEnabled; // 通知設定
  final bool emailNotifications; // メール通知
  final bool pushNotifications; // プッシュ通知
  final PrivacyLevel privacyLevel; // プライバシーレベル
  final String language; // 言語設定
  final ThemeMode themeMode; // テーマ設定
  final bool showRealName; // 実名表示設定

  const UserPreferences({
    this.notificationsEnabled = true,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.privacyLevel = PrivacyLevel.normal,
    this.language = 'ja',
    this.themeMode = ThemeMode.system,
    this.showRealName = false,
  });

  UserPreferences copyWith({
    bool? notificationsEnabled,
    bool? emailNotifications,
    bool? pushNotifications,
    PrivacyLevel? privacyLevel,
    String? language,
    ThemeMode? themeMode,
    bool? showRealName,
  }) {
    return UserPreferences(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      privacyLevel: privacyLevel ?? this.privacyLevel,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      showRealName: showRealName ?? this.showRealName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPreferences &&
        other.notificationsEnabled == notificationsEnabled &&
        other.emailNotifications == emailNotifications &&
        other.pushNotifications == pushNotifications &&
        other.privacyLevel == privacyLevel;
  }

  @override
  int get hashCode {
    return Object.hash(
      notificationsEnabled,
      emailNotifications,
      pushNotifications,
      privacyLevel,
    );
  }
}

// ユーザー統計
class UserStats {
  final int essaysCount; // 投稿したエッセイ数
  final int empathyReceived; // 受けた共感数
  final int empathyGiven; // 与えた共感数
  final int itemsSold; // 販売したアイテム数
  final int itemsPurchased; // 購入したアイテム数
  final int messagesCount; // メッセージ数
  final int followersCount; // フォロワー数
  final int followingCount; // フォロー数
  final double rating; // 評価（1-5）
  final int reviewsCount; // レビュー数
  final DateTime lastActiveAt; // 最終活動日時
  final DateTime joinedAt; // 参加日時

  const UserStats({
    this.essaysCount = 0,
    this.empathyReceived = 0,
    this.empathyGiven = 0,
    this.itemsSold = 0,
    this.itemsPurchased = 0,
    this.messagesCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.rating = 5.0,
    this.reviewsCount = 0,
    required this.lastActiveAt,
    required this.joinedAt,
  });

  // アクティビティレベル
  ActivityLevel get activityLevel {
    final daysAgo = DateTime.now().difference(lastActiveAt).inDays;
    if (daysAgo <= 1) return ActivityLevel.veryActive;
    if (daysAgo <= 7) return ActivityLevel.active;
    if (daysAgo <= 30) return ActivityLevel.moderate;
    return ActivityLevel.inactive;
  }

  // 参加期間（月数）
  int get membershipMonths {
    return DateTime.now().difference(joinedAt).inDays ~/ 30;
  }

  UserStats copyWith({
    int? essaysCount,
    int? empathyReceived,
    int? empathyGiven,
    int? itemsSold,
    int? itemsPurchased,
    int? messagesCount,
    int? followersCount,
    int? followingCount,
    double? rating,
    int? reviewsCount,
    DateTime? lastActiveAt,
    DateTime? joinedAt,
  }) {
    return UserStats(
      essaysCount: essaysCount ?? this.essaysCount,
      empathyReceived: empathyReceived ?? this.empathyReceived,
      empathyGiven: empathyGiven ?? this.empathyGiven,
      itemsSold: itemsSold ?? this.itemsSold,
      itemsPurchased: itemsPurchased ?? this.itemsPurchased,
      messagesCount: messagesCount ?? this.messagesCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserStats &&
        other.essaysCount == essaysCount &&
        other.empathyReceived == empathyReceived &&
        other.empathyGiven == empathyGiven &&
        other.itemsSold == itemsSold;
  }

  @override
  int get hashCode {
    return Object.hash(essaysCount, empathyReceived, empathyGiven, itemsSold);
  }

  @override
  String toString() {
    return 'UserStats(essays: $essaysCount, empathy: $empathyReceived/$empathyGiven, items: $itemsSold)';
  }
}

// プライバシーレベル
enum PrivacyLevel {
  public('公開', '誰でも見ることができます'),
  normal('標準', '一部の情報を制限します'),
  private('非公開', '最小限の情報のみ表示します');

  const PrivacyLevel(this.displayName, this.description);
  
  final String displayName;
  final String description;
}

// アクティビティレベル
enum ActivityLevel {
  veryActive('とてもアクティブ', '🔥'),
  active('アクティブ', '✨'),
  moderate('普通', '💫'),
  inactive('非アクティブ', '😴');

  const ActivityLevel(this.displayName, this.emoji);
  
  final String displayName;
  final String emoji;
}

// テーマモード
enum ThemeMode {
  system('システム'),
  light('ライト'),
  dark('ダーク');

  const ThemeMode(this.displayName);
  final String displayName;
} 
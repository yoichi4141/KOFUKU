import 'package:flutter/material.dart';

// メッセージエンティティ
class Message {
  final String id;
  final String conversationId; // 会話ID
  final String senderId; // 送信者ID
  final String senderName; // 送信者名（ペンネーム）
  final String content; // メッセージ内容
  final MessageType type; // メッセージタイプ
  final DateTime createdAt;
  final bool isRead; // 既読フラグ
  final String? itemId; // 関連アイテムID（アイテム関連メッセージの場合）
  final String? replyToId; // 返信先メッセージID
  final List<MessageAttachment> attachments; // 添付ファイル

  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.itemId,
    this.replyToId,
    this.attachments = const [],
  });

  Message copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? senderName,
    String? content,
    MessageType? type,
    DateTime? createdAt,
    bool? isRead,
    String? itemId,
    String? replyToId,
    List<MessageAttachment>? attachments,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      itemId: itemId ?? this.itemId,
      replyToId: replyToId ?? this.replyToId,
      attachments: attachments ?? this.attachments,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message &&
        other.id == id &&
        other.conversationId == conversationId &&
        other.senderId == senderId &&
        other.content == content &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      conversationId,
      senderId,
      content,
      type,
      createdAt,
      isRead,
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, content: $content, type: $type)';
  }
}

// 会話エンティティ
class Conversation {
  final String id;
  final String title; // 会話タイトル
  final ConversationType type; // 会話タイプ
  final List<String> participantIds; // 参加者ID
  final List<String> participantNames; // 参加者名（ペンネーム）
  final String? itemId; // 関連アイテムID
  final Message? lastMessage; // 最新メッセージ
  final DateTime createdAt;
  final DateTime updatedAt;
  final int unreadCount; // 未読数
  final bool isActive; // アクティブ状態

  const Conversation({
    required this.id,
    required this.title,
    required this.type,
    required this.participantIds,
    required this.participantNames,
    this.itemId,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    this.unreadCount = 0,
    this.isActive = true,
  });

  Conversation copyWith({
    String? id,
    String? title,
    ConversationType? type,
    List<String>? participantIds,
    List<String>? participantNames,
    String? itemId,
    Message? lastMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? unreadCount,
    bool? isActive,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      participantIds: participantIds ?? this.participantIds,
      participantNames: participantNames ?? this.participantNames,
      itemId: itemId ?? this.itemId,
      lastMessage: lastMessage ?? this.lastMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Conversation &&
        other.id == id &&
        other.title == title &&
        other.type == type &&
        other.unreadCount == unreadCount;
  }

  @override
  int get hashCode {
    return Object.hash(id, title, type, unreadCount);
  }

  @override
  String toString() {
    return 'Conversation(id: $id, title: $title, type: $type, unreadCount: $unreadCount)';
  }
}

// メッセージタイプ
enum MessageType {
  text('テキスト', Icons.chat_bubble_outline),
  image('画像', Icons.image),
  itemInquiry('商品問い合わせ', Icons.shopping_bag),
  essayComment('エッセイコメント', Icons.article),
  empathyMessage('共感メッセージ', Icons.favorite),
  system('システム', Icons.info),
  storyHandover('ストーリー引き継ぎ', Icons.sync_alt);

  const MessageType(this.displayName, this.icon);
  
  final String displayName;
  final IconData icon;
}

// 会話タイプ
enum ConversationType {
  direct('ダイレクトメッセージ', '💬'),
  itemDiscussion('商品について', '🛍️'),
  essayDiscussion('エッセイについて', '📝'),
  storyHandover('ストーリー引き継ぎ', '🔄'),
  support('サポート', '🆘');

  const ConversationType(this.displayName, this.emoji);
  
  final String displayName;
  final String emoji;
}

// 添付ファイル
class MessageAttachment {
  final String id;
  final String url;
  final String filename;
  final AttachmentType type;
  final int? size; // バイト数

  const MessageAttachment({
    required this.id,
    required this.url,
    required this.filename,
    required this.type,
    this.size,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageAttachment &&
        other.id == id &&
        other.url == url &&
        other.filename == filename &&
        other.type == type;
  }

  @override
  int get hashCode {
    return Object.hash(id, url, filename, type);
  }
}

enum AttachmentType {
  image('画像'),
  document('文書');

  const AttachmentType(this.displayName);
  final String displayName;
}

// メッセージ統計
class MessageStats {
  final int totalConversations;
  final int unreadMessages;
  final int todayMessages;
  final Map<MessageType, int> messageTypeCounts;
  final List<Conversation> recentConversations;

  const MessageStats({
    required this.totalConversations,
    required this.unreadMessages,
    required this.todayMessages,
    required this.messageTypeCounts,
    required this.recentConversations,
  });

  factory MessageStats.empty() {
    return const MessageStats(
      totalConversations: 0,
      unreadMessages: 0,
      todayMessages: 0,
      messageTypeCounts: {},
      recentConversations: [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageStats &&
        other.totalConversations == totalConversations &&
        other.unreadMessages == unreadMessages &&
        other.todayMessages == todayMessages;
  }

  @override
  int get hashCode {
    return Object.hash(totalConversations, unreadMessages, todayMessages);
  }
} 
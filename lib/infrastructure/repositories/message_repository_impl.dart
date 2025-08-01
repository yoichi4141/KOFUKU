import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../../utils/constants/failures.dart';
import '../../utils/dummy_message_data.dart';

@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  // インメモリでのメッセージデータ管理（実際の実装ではFirestore/Hiveを使用）
  static final Map<String, Message> _messages = {};
  static final Map<String, Conversation> _conversations = {};
  static final Map<String, List<String>> _userConversations = {}; // userId -> List<conversationId>
  static final Map<String, List<String>> _conversationMessages = {}; // conversationId -> List<messageId>

  // リアルタイム更新用のStreamController
  static final Map<String, StreamController<List<Message>>> _messageStreamControllers = {};
  static final Map<String, StreamController<int>> _unreadStreamControllers = {};

  // 初期データを設定
  static bool _isInitialized = false;

  MessageRepositoryImpl() {
    if (!_isInitialized) {
      _initializeData();
      _isInitialized = true;
    }
  }

  static void _initializeData() {
    // ダミー会話を設定
    for (final conversation in DummyMessageData.conversations) {
      _conversations[conversation.id] = conversation;
      
      // ユーザー会話リストに追加
      for (final participantId in conversation.participantIds) {
        _userConversations.putIfAbsent(participantId, () => []).add(conversation.id);
      }
    }

    // ダミーメッセージを設定
    for (final message in DummyMessageData.messages) {
      _messages[message.id] = message;
      
      // 会話メッセージリストに追加
      _conversationMessages.putIfAbsent(message.conversationId, () => []).add(message.id);
    }
  }

  @override
  Future<Either<Failure, List<Conversation>>> getConversations(String userId) async {
    try {
      final conversationIds = _userConversations[userId] ?? [];
      final conversations = conversationIds
          .map((id) => _conversations[id])
          .where((conv) => conv != null)
          .cast<Conversation>()
          .toList();

      // 更新日時でソート
      conversations.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return Right(conversations);
    } catch (e) {
      return Left(ServerFailure(message: '会話一覧の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, Conversation?>> getConversation(String conversationId) async {
    try {
      final conversation = _conversations[conversationId];
      return Right(conversation);
    } catch (e) {
      return Left(ServerFailure(message: '会話の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(
    String conversationId, {
    int limit = 50,
    String? beforeMessageId,
  }) async {
    try {
      final messageIds = _conversationMessages[conversationId] ?? [];
      final messages = messageIds
          .map((id) => _messages[id])
          .where((msg) => msg != null)
          .cast<Message>()
          .toList();

      // 作成日時でソート
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      // beforeMessageIdが指定されている場合はその前のメッセージのみ
      if (beforeMessageId != null) {
        final beforeIndex = messages.indexWhere((msg) => msg.id == beforeMessageId);
        if (beforeIndex > 0) {
          return Right(messages.sublist(0, beforeIndex).take(limit).toList());
        }
      }

      return Right(messages.take(limit).toList());
    } catch (e) {
      return Left(ServerFailure(message: 'メッセージの取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required String content,
    required MessageType type,
    String? itemId,
    String? replyToId,
    List<MessageAttachment> attachments = const [],
  }) async {
    try {
      // 会話が存在するかチェック
      if (!_conversations.containsKey(conversationId)) {
        return const Left(NotFoundFailure(message: '会話が見つかりません'));
      }

      // 新しいメッセージを作成
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: conversationId,
        senderId: senderId,
        senderName: senderName,
        content: content,
        type: type,
        createdAt: DateTime.now(),
        isRead: false,
        itemId: itemId,
        replyToId: replyToId,
        attachments: attachments,
      );

      // メッセージを保存
      _messages[message.id] = message;
      _conversationMessages.putIfAbsent(conversationId, () => []).add(message.id);

      // 会話を更新
      final conversation = _conversations[conversationId]!;
      _conversations[conversationId] = conversation.copyWith(
        lastMessage: message,
        updatedAt: DateTime.now(),
        unreadCount: conversation.unreadCount + 1,
      );

      // リアルタイム更新を通知
      _notifyMessageUpdate(conversationId);
      _notifyUnreadUpdate(conversation.participantIds);

      return Right(message);
    } catch (e) {
      return Left(ServerFailure(message: 'メッセージの送信に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, Conversation>> createConversation({
    required String title,
    required ConversationType type,
    required List<String> participantIds,
    required List<String> participantNames,
    String? itemId,
  }) async {
    try {
      final now = DateTime.now();
      final conversation = Conversation(
        id: now.millisecondsSinceEpoch.toString(),
        title: title,
        type: type,
        participantIds: participantIds,
        participantNames: participantNames,
        itemId: itemId,
        createdAt: now,
        updatedAt: now,
        unreadCount: 0,
        isActive: true,
      );

      // 会話を保存
      _conversations[conversation.id] = conversation;

      // ユーザー会話リストに追加
      for (final participantId in participantIds) {
        _userConversations.putIfAbsent(participantId, () => []).add(conversation.id);
      }

      return Right(conversation);
    } catch (e) {
      return Left(ServerFailure(message: '会話の作成に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead({
    required String messageId,
    required String userId,
  }) async {
    try {
      final message = _messages[messageId];
      if (message == null) {
        return const Left(NotFoundFailure(message: 'メッセージが見つかりません'));
      }

      // メッセージを既読にする
      _messages[messageId] = message.copyWith(isRead: true);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'メッセージの既読化に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markConversationAsRead({
    required String conversationId,
    required String userId,
  }) async {
    try {
      // 会話の全メッセージを既読にする
      final messageIds = _conversationMessages[conversationId] ?? [];
      for (final messageId in messageIds) {
        final message = _messages[messageId];
        if (message != null && message.senderId != userId && !message.isRead) {
          _messages[messageId] = message.copyWith(isRead: true);
        }
      }

      // 会話の未読数をリセット
      final conversation = _conversations[conversationId];
      if (conversation != null) {
        _conversations[conversationId] = conversation.copyWith(unreadCount: 0);
      }

      // 未読数更新を通知
      _notifyUnreadUpdate([userId]);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: '会話の既読化に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String userId) async {
    try {
      final conversationIds = _userConversations[userId] ?? [];
      int totalUnread = 0;

      for (final conversationId in conversationIds) {
        final conversation = _conversations[conversationId];
        if (conversation != null) {
          totalUnread += conversation.unreadCount;
        }
      }

      return Right(totalUnread);
    } catch (e) {
      return Left(ServerFailure(message: '未読数の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, MessageStats>> getMessageStats(String userId) async {
    try {
      final stats = DummyMessageData.getMessageStats(userId);
      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(message: 'メッセージ統計の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Conversation>>> searchConversations({
    required String userId,
    required String query,
  }) async {
    try {
      final conversationIds = _userConversations[userId] ?? [];
      final conversations = conversationIds
          .map((id) => _conversations[id])
          .where((conv) => conv != null)
          .cast<Conversation>()
          .where((conv) => 
              conv.title.toLowerCase().contains(query.toLowerCase()) ||
              conv.participantNames.any((name) => 
                  name.toLowerCase().contains(query.toLowerCase())))
          .toList();

      conversations.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return Right(conversations);
    } catch (e) {
      return Left(ServerFailure(message: '会話の検索に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Conversation>>> getItemConversations(String itemId) async {
    try {
      final conversations = _conversations.values
          .where((conv) => conv.itemId == itemId)
          .toList();

      conversations.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return Right(conversations);
    } catch (e) {
      return Left(ServerFailure(message: 'アイテム会話の取得に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, Conversation>> getOrCreateDirectConversation({
    required String currentUserId,
    required String currentUserName,
    required String targetUserId,
    required String targetUserName,
  }) async {
    try {
      // 既存のダイレクト会話を探す
      final existingConversation = _conversations.values
          .where((conv) => 
              conv.type == ConversationType.direct &&
              conv.participantIds.contains(currentUserId) &&
              conv.participantIds.contains(targetUserId))
          .firstOrNull;

      if (existingConversation != null) {
        return Right(existingConversation);
      }

      // 新しいダイレクト会話を作成
      return createConversation(
        title: '$targetUserNameさんとの会話',
        type: ConversationType.direct,
        participantIds: [currentUserId, targetUserId],
        participantNames: [currentUserName, targetUserName],
      );
    } catch (e) {
      return Left(ServerFailure(message: 'ダイレクト会話の取得・作成に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage({
    required String messageId,
    required String userId,
  }) async {
    try {
      final message = _messages[messageId];
      if (message == null) {
        return const Left(NotFoundFailure(message: 'メッセージが見つかりません'));
      }

      if (message.senderId != userId) {
        return const Left(ValidationFailure(message: '自分のメッセージのみ削除できます'));
      }

      // メッセージを削除
      _messages.remove(messageId);
      _conversationMessages[message.conversationId]?.remove(messageId);

      // リアルタイム更新を通知
      _notifyMessageUpdate(message.conversationId);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'メッセージの削除に失敗しました: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> archiveConversation({
    required String conversationId,
    required String userId,
  }) async {
    try {
      final conversation = _conversations[conversationId];
      if (conversation == null) {
        return const Left(NotFoundFailure(message: '会話が見つかりません'));
      }

      // 会話を非アクティブにする
      _conversations[conversationId] = conversation.copyWith(isActive: false);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: '会話のアーカイブに失敗しました: $e'));
    }
  }

  @override
  Stream<List<Message>> getMessageStream(String conversationId) {
    _messageStreamControllers.putIfAbsent(
      conversationId,
      () => StreamController<List<Message>>.broadcast(),
    );

    // 初期データを送信
    _notifyMessageUpdate(conversationId);

    return _messageStreamControllers[conversationId]!.stream;
  }

  @override
  Stream<int> getUnreadCountStream(String userId) {
    _unreadStreamControllers.putIfAbsent(
      userId,
      () => StreamController<int>.broadcast(),
    );

    // 初期データを送信
    _notifyUnreadUpdate([userId]);

    return _unreadStreamControllers[userId]!.stream;
  }

  // リアルタイム更新通知
  void _notifyMessageUpdate(String conversationId) {
    if (_messageStreamControllers.containsKey(conversationId)) {
      final messageIds = _conversationMessages[conversationId] ?? [];
      final messages = messageIds
          .map((id) => _messages[id])
          .where((msg) => msg != null)
          .cast<Message>()
          .toList();

      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      _messageStreamControllers[conversationId]!.add(messages);
    }
  }

  void _notifyUnreadUpdate(List<String> userIds) {
    for (final userId in userIds) {
      if (_unreadStreamControllers.containsKey(userId)) {
        final conversationIds = _userConversations[userId] ?? [];
        int totalUnread = 0;

        for (final conversationId in conversationIds) {
          final conversation = _conversations[conversationId];
          if (conversation != null) {
            totalUnread += conversation.unreadCount;
          }
        }

        _unreadStreamControllers[userId]!.add(totalUnread);
      }
    }
  }

  // テスト用のデータクリア機能
  static void clearData() {
    _messages.clear();
    _conversations.clear();
    _userConversations.clear();
    _conversationMessages.clear();
    _messageStreamControllers.clear();
    _unreadStreamControllers.clear();
    _isInitialized = false;
  }
} 
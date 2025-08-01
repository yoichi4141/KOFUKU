import 'package:dartz/dartz.dart';

import '../entities/message.dart';
import '../../utils/constants/failures.dart';

abstract class MessageRepository {
  /// 会話一覧を取得
  Future<Either<Failure, List<Conversation>>> getConversations(String userId);

  /// 会話の詳細を取得
  Future<Either<Failure, Conversation?>> getConversation(String conversationId);

  /// 会話のメッセージ一覧を取得
  Future<Either<Failure, List<Message>>> getMessages(String conversationId, {
    int limit = 50,
    String? beforeMessageId,
  });

  /// メッセージを送信
  Future<Either<Failure, Message>> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required String content,
    required MessageType type,
    String? itemId,
    String? replyToId,
    List<MessageAttachment> attachments = const [],
  });

  /// 会話を作成
  Future<Either<Failure, Conversation>> createConversation({
    required String title,
    required ConversationType type,
    required List<String> participantIds,
    required List<String> participantNames,
    String? itemId,
  });

  /// メッセージを既読にする
  Future<Either<Failure, void>> markAsRead({
    required String messageId,
    required String userId,
  });

  /// 会話の未読メッセージを全て既読にする
  Future<Either<Failure, void>> markConversationAsRead({
    required String conversationId,
    required String userId,
  });

  /// ユーザーの未読メッセージ数を取得
  Future<Either<Failure, int>> getUnreadCount(String userId);

  /// メッセージ統計を取得
  Future<Either<Failure, MessageStats>> getMessageStats(String userId);

  /// 会話を検索
  Future<Either<Failure, List<Conversation>>> searchConversations({
    required String userId,
    required String query,
  });

  /// アイテムに関する会話を取得
  Future<Either<Failure, List<Conversation>>> getItemConversations(String itemId);

  /// ユーザー間のダイレクト会話を取得または作成
  Future<Either<Failure, Conversation>> getOrCreateDirectConversation({
    required String currentUserId,
    required String currentUserName,
    required String targetUserId,
    required String targetUserName,
  });

  /// メッセージを削除
  Future<Either<Failure, void>> deleteMessage({
    required String messageId,
    required String userId,
  });

  /// 会話をアーカイブ
  Future<Either<Failure, void>> archiveConversation({
    required String conversationId,
    required String userId,
  });

  /// リアルタイム更新のストリーム取得
  Stream<List<Message>> getMessageStream(String conversationId);
  
  /// 未読通知のストリーム取得
  Stream<int> getUnreadCountStream(String userId);
} 
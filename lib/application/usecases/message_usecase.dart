import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../../utils/constants/failures.dart';

@injectable
class MessageUseCase {
  final MessageRepository _messageRepository;

  const MessageUseCase(this._messageRepository);

  /// 会話一覧を取得
  Future<Either<Failure, List<Conversation>>> getConversations(String userId) {
    return _messageRepository.getConversations(userId);
  }

  /// 会話の詳細とメッセージ履歴を取得
  Future<Either<Failure, Map<String, dynamic>>> getConversationDetails(
    String conversationId, {
    int messageLimit = 50,
  }) async {
    final conversationResult = await _messageRepository.getConversation(conversationId);
    
    return conversationResult.fold(
      (failure) => Left(failure),
      (conversation) async {
        if (conversation == null) {
          return const Left(NotFoundFailure(message: '会話が見つかりません'));
        }

        final messagesResult = await _messageRepository.getMessages(
          conversationId,
          limit: messageLimit,
        );

        return messagesResult.fold(
          (failure) => Left(failure),
          (messages) => Right({
            'conversation': conversation,
            'messages': messages,
          }),
        );
      },
    );
  }

  /// メッセージを送信
  Future<Either<Failure, Message>> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required String content,
    MessageType type = MessageType.text,
    String? itemId,
    String? replyToId,
    List<MessageAttachment> attachments = const [],
  }) async {
    // バリデーション
    if (content.trim().isEmpty && attachments.isEmpty) {
      return const Left(ValidationFailure(message: 'メッセージ内容または添付ファイルが必要です'));
    }

    if (content.length > 1000) {
      return const Left(ValidationFailure(message: 'メッセージは1000文字以内で入力してください'));
    }

    return _messageRepository.sendMessage(
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      content: content.trim(),
      type: type,
      itemId: itemId,
      replyToId: replyToId,
      attachments: attachments,
    );
  }

  /// 会話を作成
  Future<Either<Failure, Conversation>> createConversation({
    required String title,
    required ConversationType type,
    required List<String> participantIds,
    required List<String> participantNames,
    String? itemId,
  }) async {
    // バリデーション
    if (participantIds.length < 2) {
      return const Left(ValidationFailure(message: '会話には最低2人の参加者が必要です'));
    }

    if (participantIds.length != participantNames.length) {
      return const Left(ValidationFailure(message: '参加者IDと名前の数が一致しません'));
    }

    return _messageRepository.createConversation(
      title: title,
      type: type,
      participantIds: participantIds,
      participantNames: participantNames,
      itemId: itemId,
    );
  }

  /// アイテムについての問い合わせ会話を作成
  Future<Either<Failure, Conversation>> createItemInquiry({
    required String itemId,
    required String itemTitle,
    required String inquirerId,
    required String inquirerName,
    required String sellerId,
    required String sellerName,
    required String initialMessage,
  }) async {
    // 既存の会話をチェック
    final existingConversations = await _messageRepository.getItemConversations(itemId);
    
    return existingConversations.fold(
      (failure) => Left(failure),
      (conversations) async {
        // 同じ参加者間の会話が存在するかチェック
        final existingConversation = conversations
            .where((conv) => 
                conv.participantIds.contains(inquirerId) &&
                conv.participantIds.contains(sellerId))
            .firstOrNull;

        if (existingConversation != null) {
          // 既存の会話に初期メッセージを送信
          final messageResult = await sendMessage(
            conversationId: existingConversation.id,
            senderId: inquirerId,
            senderName: inquirerName,
            content: initialMessage,
            type: MessageType.itemInquiry,
            itemId: itemId,
          );

          return messageResult.fold(
            (failure) => Left(failure),
            (_) => Right(existingConversation),
          );
        }

        // 新しい会話を作成
        final conversationResult = await createConversation(
          title: '「$itemTitle」について',
          type: ConversationType.itemDiscussion,
          participantIds: [inquirerId, sellerId],
          participantNames: [inquirerName, sellerName],
          itemId: itemId,
        );

        return conversationResult.fold(
          (failure) => Left(failure),
          (conversation) async {
            // 初期メッセージを送信
            final messageResult = await sendMessage(
              conversationId: conversation.id,
              senderId: inquirerId,
              senderName: inquirerName,
              content: initialMessage,
              type: MessageType.itemInquiry,
              itemId: itemId,
            );

            return messageResult.fold(
              (failure) => Left(failure),
              (_) => Right(conversation),
            );
          },
        );
      },
    );
  }

  /// ダイレクトメッセージ会話を取得または作成
  Future<Either<Failure, Conversation>> getOrCreateDirectMessage({
    required String currentUserId,
    required String currentUserName,
    required String targetUserId,
    required String targetUserName,
    String? initialMessage,
  }) async {
    final result = await _messageRepository.getOrCreateDirectConversation(
      currentUserId: currentUserId,
      currentUserName: currentUserName,
      targetUserId: targetUserId,
      targetUserName: targetUserName,
    );

    if (initialMessage != null && initialMessage.trim().isNotEmpty) {
      return result.fold(
        (failure) => Left(failure),
        (conversation) async {
          final messageResult = await sendMessage(
            conversationId: conversation.id,
            senderId: currentUserId,
            senderName: currentUserName,
            content: initialMessage.trim(),
            type: MessageType.text,
          );

          return messageResult.fold(
            (failure) => Left(failure),
            (_) => Right(conversation),
          );
        },
      );
    }

    return result;
  }

  /// メッセージを既読にする
  Future<Either<Failure, void>> markAsRead({
    required String messageId,
    required String userId,
  }) {
    return _messageRepository.markAsRead(
      messageId: messageId,
      userId: userId,
    );
  }

  /// 会話の全メッセージを既読にする
  Future<Either<Failure, void>> markConversationAsRead({
    required String conversationId,
    required String userId,
  }) {
    return _messageRepository.markConversationAsRead(
      conversationId: conversationId,
      userId: userId,
    );
  }

  /// 未読メッセージ数を取得
  Future<Either<Failure, int>> getUnreadCount(String userId) {
    return _messageRepository.getUnreadCount(userId);
  }

  /// メッセージ統計を取得
  Future<Either<Failure, MessageStats>> getMessageStats(String userId) {
    return _messageRepository.getMessageStats(userId);
  }

  /// 会話を検索
  Future<Either<Failure, List<Conversation>>> searchConversations({
    required String userId,
    required String query,
  }) async {
    if (query.trim().isEmpty) {
      return const Left(ValidationFailure(message: '検索キーワードを入力してください'));
    }

    return _messageRepository.searchConversations(
      userId: userId,
      query: query.trim(),
    );
  }

  /// メッセージを削除
  Future<Either<Failure, void>> deleteMessage({
    required String messageId,
    required String userId,
  }) {
    return _messageRepository.deleteMessage(
      messageId: messageId,
      userId: userId,
    );
  }

  /// 会話をアーカイブ
  Future<Either<Failure, void>> archiveConversation({
    required String conversationId,
    required String userId,
  }) {
    return _messageRepository.archiveConversation(
      conversationId: conversationId,
      userId: userId,
    );
  }

  /// リアルタイムメッセージストリーム
  Stream<List<Message>> getMessageStream(String conversationId) {
    return _messageRepository.getMessageStream(conversationId);
  }

  /// 未読通知ストリーム
  Stream<int> getUnreadCountStream(String userId) {
    return _messageRepository.getUnreadCountStream(userId);
  }
} 
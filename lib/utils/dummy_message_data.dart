import '../domain/entities/message.dart';
import 'dummy_data.dart';

class DummyMessageData {
  // 現在のユーザーID（実際の実装では認証システムから取得）
  static const String currentUserId = 'user_001';
  static const String currentUserName = 'あいこ';

  // ダミーユーザー
  static const List<Map<String, String>> users = [
    {'id': 'user_001', 'name': 'あいこ'},
    {'id': 'user_002', 'name': 'みどり'},
    {'id': 'user_003', 'name': 'さくら'},
    {'id': 'user_004', 'name': 'ひかり'},
    {'id': 'user_005', 'name': 'ゆめ'},
  ];

  // ダミー会話
  static final List<Conversation> conversations = [
    Conversation(
      id: 'conv_001',
      title: '「ヴィンテージデニムジャケット」について',
      type: ConversationType.itemDiscussion,
      participantIds: [currentUserId, 'user_002'],
      participantNames: [currentUserName, 'みどり'],
      itemId: DummyData.clothingItems[0].id,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 2,
      lastMessage: Message(
        id: 'msg_005',
        conversationId: 'conv_001',
        senderId: 'user_002',
        senderName: 'みどり',
        content: 'ありがとうございます！とても素敵なエッセイでした。ぜひ譲っていただきたいです。',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: false,
        itemId: DummyData.clothingItems[0].id,
      ),
    ),
    
    Conversation(
      id: 'conv_002',
      title: 'さくらさんとの会話',
      type: ConversationType.direct,
      participantIds: [currentUserId, 'user_003'],
      participantNames: [currentUserName, 'さくら'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      unreadCount: 1,
      lastMessage: Message(
        id: 'msg_010',
        conversationId: 'conv_002',
        senderId: 'user_003',
        senderName: 'さくら',
        content: 'あいこさんの愛のエッセイ、本当に感動しました💖',
        type: MessageType.empathyMessage,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
    ),

    Conversation(
      id: 'conv_003',
      title: '「カシミヤコート」について',
      type: ConversationType.itemDiscussion,
      participantIds: [currentUserId, 'user_004'],
      participantNames: [currentUserName, 'ひかり'],
      itemId: DummyData.clothingItems[1].id,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 15)),
      unreadCount: 0,
      lastMessage: Message(
        id: 'msg_015',
        conversationId: 'conv_003',
        senderId: currentUserId,
        senderName: currentUserName,
        content: 'ぜひお譲りします。大切にしていただけるとのことで、安心しました。',
        type: MessageType.text,
        createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: true,
        itemId: DummyData.clothingItems[1].id,
      ),
    ),
  ];

  // ダミーメッセージ
  static final List<Message> messages = [
    // conv_001のメッセージ
    Message(
      id: 'msg_001',
      conversationId: 'conv_001',
      senderId: 'user_002',
      senderName: 'みどり',
      content: 'こんにちは！このデニムジャケットについて質問があります。',
      type: MessageType.itemInquiry,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      itemId: DummyData.clothingItems[0].id,
    ),
    
    Message(
      id: 'msg_002',
      conversationId: 'conv_001',
      senderId: currentUserId,
      senderName: currentUserName,
      content: 'こんにちは！どのようなことでしょうか？',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: -1)),
      isRead: true,
    ),

    Message(
      id: 'msg_003',
      conversationId: 'conv_001',
      senderId: 'user_002',
      senderName: 'みどり',
      content: 'エッセイを読ませていただいて、とても感動しました。このジャケットとの思い出が素敵ですね。サイズはMでしょうか？',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: -2)),
      isRead: true,
    ),

    Message(
      id: 'msg_004',
      conversationId: 'conv_001',
      senderId: currentUserId,
      senderName: currentUserName,
      content: 'ありがとうございます😊 はい、Mサイズです。大学時代からずっと愛用していて、たくさんの思い出が詰まっています。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 20)),
      isRead: true,
    ),

    Message(
      id: 'msg_005',
      conversationId: 'conv_001',
      senderId: 'user_002',
      senderName: 'みどり',
      content: 'ありがとうございます！とても素敵なエッセイでした。ぜひ譲っていただきたいです。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: false,
      itemId: DummyData.clothingItems[0].id,
    ),

    // conv_002のメッセージ
    Message(
      id: 'msg_006',
      conversationId: 'conv_002',
      senderId: 'user_003',
      senderName: 'さくら',
      content: 'はじめまして！あいこさんの愛のエッセイを読んで、メッセージさせていただきました。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),

    Message(
      id: 'msg_007',
      conversationId: 'conv_002',
      senderId: currentUserId,
      senderName: currentUserName,
      content: 'こんにちは！メッセージありがとうございます😊',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: -1)),
      isRead: true,
    ),

    Message(
      id: 'msg_008',
      conversationId: 'conv_002',
      senderId: 'user_003',
      senderName: 'さくら',
      content: '私も古着が大好きで、特に物語性のあるアイテムに惹かれます。あいこさんのエッセイを読んで、服への愛情がとても伝わってきました。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      isRead: true,
    ),

    Message(
      id: 'msg_009',
      conversationId: 'conv_002',
      senderId: currentUserId,
      senderName: currentUserName,
      content: 'そう言っていただけて嬉しいです！さくらさんも愛のエッセイを書かれているのですね。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),

    Message(
      id: 'msg_010',
      conversationId: 'conv_002',
      senderId: 'user_003',
      senderName: 'さくら',
      content: 'あいこさんの愛のエッセイ、本当に感動しました💖',
      type: MessageType.empathyMessage,
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
    ),

    // conv_003のメッセージ
    Message(
      id: 'msg_011',
      conversationId: 'conv_003',
      senderId: 'user_004',
      senderName: 'ひかり',
      content: 'カシミヤコートについて質問があります。',
      type: MessageType.itemInquiry,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      isRead: true,
      itemId: DummyData.clothingItems[1].id,
    ),

    Message(
      id: 'msg_012',
      conversationId: 'conv_003',
      senderId: currentUserId,
      senderName: currentUserName,
      content: 'はい、どのようなことでしょうか？',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 5, minutes: 45)),
      isRead: true,
    ),

    Message(
      id: 'msg_013',
      conversationId: 'conv_003',
      senderId: 'user_004',
      senderName: 'ひかり',
      content: 'エッセイを読んで、母親への想いがとても伝わってきました。私にも同じような経験があって...このコートを大切にしたいと思います。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: true,
    ),

    Message(
      id: 'msg_014',
      conversationId: 'conv_003',
      senderId: currentUserId,
      senderName: currentUserName,
      content: '温かいお言葉をありがとうございます。母も喜んでいると思います。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
    ),

    Message(
      id: 'msg_015',
      conversationId: 'conv_003',
      senderId: currentUserId,
      senderName: currentUserName,
      content: 'ぜひお譲りします。大切にしていただけるとのことで、安心しました。',
      type: MessageType.text,
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: true,
      itemId: DummyData.clothingItems[1].id,
    ),
  ];

  // 会話IDでメッセージを取得
  static List<Message> getMessagesByConversationId(String conversationId) {
    return messages
        .where((message) => message.conversationId == conversationId)
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  // ユーザーIDで会話一覧を取得
  static List<Conversation> getConversationsByUserId(String userId) {
    return conversations
        .where((conv) => conv.participantIds.contains(userId))
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  // ユーザーの未読メッセージ数を取得
  static int getUnreadCount(String userId) {
    return getConversationsByUserId(userId)
        .fold(0, (total, conv) => total + conv.unreadCount);
  }

  // メッセージ統計を取得
  static MessageStats getMessageStats(String userId) {
    final userConversations = getConversationsByUserId(userId);
    final userMessages = messages
        .where((msg) => userConversations
            .any((conv) => conv.id == msg.conversationId))
        .toList();

    // タイプ別メッセージ数
    final typeCounts = <MessageType, int>{};
    for (final message in userMessages) {
      typeCounts[message.type] = (typeCounts[message.type] ?? 0) + 1;
    }

    // 今日のメッセージ数
    final today = DateTime.now();
    final todayMessages = userMessages
        .where((msg) => 
            msg.createdAt.year == today.year &&
            msg.createdAt.month == today.month &&
            msg.createdAt.day == today.day)
        .length;

    return MessageStats(
      totalConversations: userConversations.length,
      unreadMessages: getUnreadCount(userId),
      todayMessages: todayMessages,
      messageTypeCounts: typeCounts,
      recentConversations: userConversations.take(5).toList(),
    );
  }
} 
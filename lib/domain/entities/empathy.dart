class Empathy {
  final String id;
  final String userId; // 共感したユーザーID
  final String itemId; // 共感されたアイテムID
  final DateTime createdAt;
  final EmpathyType type; // 共感の種類

  const Empathy({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.createdAt,
    required this.type,
  });

  Empathy copyWith({
    String? id,
    String? userId,
    String? itemId,
    DateTime? createdAt,
    EmpathyType? type,
  }) {
    return Empathy(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      itemId: itemId ?? this.itemId,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Empathy &&
        other.id == id &&
        other.userId == userId &&
        other.itemId == itemId &&
        other.createdAt == createdAt &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        itemId.hashCode ^
        createdAt.hashCode ^
        type.hashCode;
  }

  @override
  String toString() {
    return 'Empathy(id: $id, userId: $userId, itemId: $itemId, createdAt: $createdAt, type: $type)';
  }
}

// 共感の種類
enum EmpathyType {
  love('💖', '愛'), // 愛のエッセイに深く共感
  moved('😭', '感動'), // 感動した
  beautiful('✨', '美しい'), // 美しいと思った
  want('🛍️', '欲しい'), // 欲しいと思った
  story('📚', 'ストーリー'); // ストーリーが良い

  const EmpathyType(this.emoji, this.displayName);
  
  final String emoji;
  final String displayName;
}

// 共感統計情報
class EmpathyStats {
  final Map<EmpathyType, int> counts;
  final int totalCount;
  final List<Empathy> recentEmpathies;

  const EmpathyStats({
    required this.counts,
    required this.totalCount,
    required this.recentEmpathies,
  });

  factory EmpathyStats.empty() {
    return const EmpathyStats(
      counts: {},
      totalCount: 0,
      recentEmpathies: [],
    );
  }

  EmpathyStats copyWith({
    Map<EmpathyType, int>? counts,
    int? totalCount,
    List<Empathy>? recentEmpathies,
  }) {
    return EmpathyStats(
      counts: counts ?? this.counts,
      totalCount: totalCount ?? this.totalCount,
      recentEmpathies: recentEmpathies ?? this.recentEmpathies,
    );
  }
} 
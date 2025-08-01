class ClothingItem {
  final String id;
  final String title;
  final String description;
  final String loveEssay; // 愛のエッセイ（1000文字以上）
  final String ownerPenName; // ペンネーム
  final String category;
  final String size;
  final String brand;
  final List<String> imageUrls;
  final int empathyCount; // 共感数
  final int price; // WASURENA コイン
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final String condition; // 状態（良好、使用感あり、など）

  const ClothingItem({
    required this.id,
    required this.title,
    required this.description,
    required this.loveEssay,
    required this.ownerPenName,
    required this.category,
    required this.size,
    required this.brand,
    required this.imageUrls,
    required this.empathyCount,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    required this.condition,
  });

  ClothingItem copyWith({
    String? id,
    String? title,
    String? description,
    String? loveEssay,
    String? ownerPenName,
    String? category,
    String? size,
    String? brand,
    List<String>? imageUrls,
    int? empathyCount,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    String? condition,
  }) {
    return ClothingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      loveEssay: loveEssay ?? this.loveEssay,
      ownerPenName: ownerPenName ?? this.ownerPenName,
      category: category ?? this.category,
      size: size ?? this.size,
      brand: brand ?? this.brand,
      imageUrls: imageUrls ?? this.imageUrls,
      empathyCount: empathyCount ?? this.empathyCount,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      condition: condition ?? this.condition,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClothingItem &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.loveEssay == loveEssay &&
        other.ownerPenName == ownerPenName &&
        other.category == category &&
        other.size == size &&
        other.brand == brand &&
        other.imageUrls.toString() == imageUrls.toString() &&
        other.empathyCount == empathyCount &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.tags.toString() == tags.toString() &&
        other.condition == condition;
  }

  @override
  int get hashCode => Object.hash(
    id, title, description, loveEssay, ownerPenName,
    category, size, brand, imageUrls, empathyCount,
    price, createdAt, updatedAt, tags, condition,
  );

  @override
  String toString() {
    return 'ClothingItem(id: $id, title: $title, category: $category, empathyCount: $empathyCount)';
  }
} 
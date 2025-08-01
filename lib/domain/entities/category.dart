class Category {
  final String id;
  final String name;
  final String? icon;
  final List<Category> subcategories;
  final int level; // 1: メイン, 2: サブ, 3: 詳細, 4: ブランド/サイズ, 5: 商品
  final String? parentId;

  const Category({
    required this.id,
    required this.name,
    this.icon,
    this.subcategories = const [],
    required this.level,
    this.parentId,
  });

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    List<Category>? subcategories,
    int? level,
    String? parentId,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      subcategories: subcategories ?? this.subcategories,
      level: level ?? this.level,
      parentId: parentId ?? this.parentId,
    );
  }

  bool get hasSubcategories => subcategories.isNotEmpty;
  bool get isLeafCategory => subcategories.isEmpty;
  bool get isMainCategory => level == 1;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, level: $level, subcategories: ${subcategories.length})';
  }
}

// 検索フィルター用のデータクラス
class SearchFilter {
  final PriceRange? priceRange;
  final List<String> conditions; // 新品、美品、良品、etc
  final List<String> brands;
  final List<String> sizes;
  final bool? hasLoveEssay; // 愛のエッセイ有無
  final SortOption sortOption;

  const SearchFilter({
    this.priceRange,
    this.conditions = const [],
    this.brands = const [],
    this.sizes = const [],
    this.hasLoveEssay,
    this.sortOption = SortOption.newest,
  });

  SearchFilter copyWith({
    PriceRange? priceRange,
    List<String>? conditions,
    List<String>? brands,
    List<String>? sizes,
    bool? hasLoveEssay,
    SortOption? sortOption,
  }) {
    return SearchFilter(
      priceRange: priceRange ?? this.priceRange,
      conditions: conditions ?? this.conditions,
      brands: brands ?? this.brands,
      sizes: sizes ?? this.sizes,
      hasLoveEssay: hasLoveEssay ?? this.hasLoveEssay,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

class PriceRange {
  final int? min;
  final int? max;

  const PriceRange({this.min, this.max});

  @override
  String toString() {
    if (min != null && max != null) {
      return '¥${min!.toStringAsFixed(0)} - ¥${max!.toStringAsFixed(0)}';
    } else if (min != null) {
      return '¥${min!.toStringAsFixed(0)}以上';
    } else if (max != null) {
      return '¥${max!.toStringAsFixed(0)}以下';
    }
    return '価格指定なし';
  }
}

enum SortOption {
  newest('新着順'),
  priceAsc('価格の安い順'),
  priceDesc('価格の高い順'),
  popular('人気順'),
  empathyCount('共感数順'),
  loveEssayLength('エッセイの長さ順');

  const SortOption(this.displayName);
  final String displayName;
} 
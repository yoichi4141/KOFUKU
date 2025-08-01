import '../domain/entities/category.dart';

class DummyCategories {
  static final List<Category> mainCategories = [
    // 1. ファッション（メイン）
    Category(
      id: 'fashion',
      name: 'ファッション',
      icon: '👗',
      level: 1,
      subcategories: [
        // レディースファッション
        Category(
          id: 'women_fashion',
          name: 'レディース',
          level: 2,
          parentId: 'fashion',
          subcategories: [
            Category(
              id: 'women_outer',
              name: 'アウター',
              level: 3,
              parentId: 'women_fashion',
              subcategories: [
                Category(id: 'women_coat', name: 'コート', level: 4, parentId: 'women_outer'),
                Category(id: 'women_jacket', name: 'ジャケット', level: 4, parentId: 'women_outer'),
                Category(id: 'women_cardigan', name: 'カーディガン', level: 4, parentId: 'women_outer'),
                Category(id: 'women_blazer', name: 'ブレザー', level: 4, parentId: 'women_outer'),
              ],
            ),
            Category(
              id: 'women_tops',
              name: 'トップス',
              level: 3,
              parentId: 'women_fashion',
              subcategories: [
                Category(id: 'women_tshirt', name: 'Tシャツ/カットソー', level: 4, parentId: 'women_tops'),
                Category(id: 'women_blouse', name: 'シャツ/ブラウス', level: 4, parentId: 'women_tops'),
                Category(id: 'women_knit', name: 'ニット/セーター', level: 4, parentId: 'women_tops'),
                Category(id: 'women_tank', name: 'タンクトップ', level: 4, parentId: 'women_tops'),
              ],
            ),
            Category(
              id: 'women_bottoms',
              name: 'ボトムス',
              level: 3,
              parentId: 'women_fashion',
              subcategories: [
                Category(id: 'women_skirt', name: 'スカート', level: 4, parentId: 'women_bottoms'),
                Category(id: 'women_pants', name: 'パンツ', level: 4, parentId: 'women_bottoms'),
                Category(id: 'women_jeans', name: 'デニム/ジーンズ', level: 4, parentId: 'women_bottoms'),
                Category(id: 'women_shorts', name: 'ショートパンツ', level: 4, parentId: 'women_bottoms'),
              ],
            ),
            Category(
              id: 'women_dress',
              name: 'ワンピース/ドレス',
              level: 3,
              parentId: 'women_fashion',
              subcategories: [
                Category(id: 'women_onepiece', name: 'ひざ丈ワンピース', level: 4, parentId: 'women_dress'),
                Category(id: 'women_long_dress', name: 'ロングワンピース', level: 4, parentId: 'women_dress'),
                Category(id: 'women_party_dress', name: 'パーティードレス', level: 4, parentId: 'women_dress'),
              ],
            ),
          ],
        ),
        // メンズファッション
        Category(
          id: 'men_fashion',
          name: 'メンズ',
          level: 2,
          parentId: 'fashion',
          subcategories: [
            Category(
              id: 'men_outer',
              name: 'アウター',
              level: 3,
              parentId: 'men_fashion',
              subcategories: [
                Category(id: 'men_jacket', name: 'テーラードジャケット', level: 4, parentId: 'men_outer'),
                Category(id: 'men_coat', name: 'チェスターコート', level: 4, parentId: 'men_outer'),
                Category(id: 'men_parka', name: 'パーカー', level: 4, parentId: 'men_outer'),
                Category(id: 'men_blouson', name: 'ブルゾン', level: 4, parentId: 'men_outer'),
              ],
            ),
            Category(
              id: 'men_tops',
              name: 'トップス',
              level: 3,
              parentId: 'men_fashion',
              subcategories: [
                Category(id: 'men_tshirt', name: 'Tシャツ/カットソー', level: 4, parentId: 'men_tops'),
                Category(id: 'men_shirt', name: 'シャツ', level: 4, parentId: 'men_tops'),
                Category(id: 'men_knit', name: 'ニット/セーター', level: 4, parentId: 'men_tops'),
                Category(id: 'men_polo', name: 'ポロシャツ', level: 4, parentId: 'men_tops'),
              ],
            ),
            Category(
              id: 'men_bottoms',
              name: 'ボトムス',
              level: 3,
              parentId: 'men_fashion',
              subcategories: [
                Category(id: 'men_pants', name: 'スラックス', level: 4, parentId: 'men_bottoms'),
                Category(id: 'men_jeans', name: 'デニム/ジーンズ', level: 4, parentId: 'men_bottoms'),
                Category(id: 'men_chino', name: 'チノパン', level: 4, parentId: 'men_bottoms'),
                Category(id: 'men_shorts', name: 'ショートパンツ', level: 4, parentId: 'men_bottoms'),
              ],
            ),
          ],
        ),
      ],
    ),
    
    // 2. シューズ（メイン）
    Category(
      id: 'shoes',
      name: 'シューズ',
      icon: '👟',
      level: 1,
      subcategories: [
        Category(
          id: 'women_shoes',
          name: 'レディースシューズ',
          level: 2,
          parentId: 'shoes',
          subcategories: [
            Category(id: 'women_sneakers', name: 'スニーカー', level: 3, parentId: 'women_shoes'),
            Category(id: 'women_heels', name: 'ハイヒール/パンプス', level: 3, parentId: 'women_shoes'),
            Category(id: 'women_boots', name: 'ブーツ', level: 3, parentId: 'women_shoes'),
            Category(id: 'women_flats', name: 'フラットシューズ', level: 3, parentId: 'women_shoes'),
          ],
        ),
        Category(
          id: 'men_shoes',
          name: 'メンズシューズ',
          level: 2,
          parentId: 'shoes',
          subcategories: [
            Category(id: 'men_sneakers', name: 'スニーカー', level: 3, parentId: 'men_shoes'),
            Category(id: 'men_dress_shoes', name: 'ドレスシューズ', level: 3, parentId: 'men_shoes'),
            Category(id: 'men_boots', name: 'ブーツ', level: 3, parentId: 'men_shoes'),
            Category(id: 'men_sandals', name: 'サンダル', level: 3, parentId: 'men_shoes'),
          ],
        ),
      ],
    ),
    
    // 3. バッグ（メイン）
    Category(
      id: 'bags',
      name: 'バッグ',
      icon: '👜',
      level: 1,
      subcategories: [
        Category(
          id: 'women_bags',
          name: 'レディースバッグ',
          level: 2,
          parentId: 'bags',
          subcategories: [
            Category(id: 'handbag', name: 'ハンドバッグ', level: 3, parentId: 'women_bags'),
            Category(id: 'shoulder_bag', name: 'ショルダーバッグ', level: 3, parentId: 'women_bags'),
            Category(id: 'tote_bag', name: 'トートバッグ', level: 3, parentId: 'women_bags'),
            Category(id: 'clutch_bag', name: 'クラッチバッグ', level: 3, parentId: 'women_bags'),
          ],
        ),
        Category(
          id: 'men_bags',
          name: 'メンズバッグ',
          level: 2,
          parentId: 'bags',
          subcategories: [
            Category(id: 'business_bag', name: 'ビジネスバッグ', level: 3, parentId: 'men_bags'),
            Category(id: 'backpack', name: 'リュック/バックパック', level: 3, parentId: 'men_bags'),
            Category(id: 'messenger_bag', name: 'メッセンジャーバッグ', level: 3, parentId: 'men_bags'),
            Category(id: 'waist_bag', name: 'ウエストバッグ', level: 3, parentId: 'men_bags'),
          ],
        ),
      ],
    ),
    
    // 4. アクセサリー（メイン）
    Category(
      id: 'accessories',
      name: 'アクセサリー',
      icon: '💍',
      level: 1,
      subcategories: [
        Category(
          id: 'jewelry',
          name: 'ジュエリー',
          level: 2,
          parentId: 'accessories',
          subcategories: [
            Category(id: 'necklace', name: 'ネックレス', level: 3, parentId: 'jewelry'),
            Category(id: 'earrings', name: 'ピアス/イヤリング', level: 3, parentId: 'jewelry'),
            Category(id: 'rings', name: 'リング', level: 3, parentId: 'jewelry'),
            Category(id: 'bracelet', name: 'ブレスレット', level: 3, parentId: 'jewelry'),
          ],
        ),
        Category(
          id: 'watches',
          name: '時計',
          level: 2,
          parentId: 'accessories',
          subcategories: [
            Category(id: 'women_watch', name: 'レディース時計', level: 3, parentId: 'watches'),
            Category(id: 'men_watch', name: 'メンズ時計', level: 3, parentId: 'watches'),
            Category(id: 'smartwatch', name: 'スマートウォッチ', level: 3, parentId: 'watches'),
            Category(id: 'vintage_watch', name: 'ヴィンテージ時計', level: 3, parentId: 'watches'),
          ],
        ),
      ],
    ),
    
    // 5. ライフスタイル（メイン）
    Category(
      id: 'lifestyle',
      name: 'ライフスタイル',
      icon: '🏠',
      level: 1,
      subcategories: [
        Category(
          id: 'home_decor',
          name: 'インテリア',
          level: 2,
          parentId: 'lifestyle',
          subcategories: [
            Category(id: 'furniture', name: '家具', level: 3, parentId: 'home_decor'),
            Category(id: 'decor_items', name: '雑貨', level: 3, parentId: 'home_decor'),
            Category(id: 'lighting', name: '照明', level: 3, parentId: 'home_decor'),
            Category(id: 'textiles', name: 'ファブリック', level: 3, parentId: 'home_decor'),
          ],
        ),
        Category(
          id: 'books_media',
          name: '本・メディア',
          level: 2,
          parentId: 'lifestyle',
          subcategories: [
            Category(id: 'books', name: '書籍', level: 3, parentId: 'books_media'),
            Category(id: 'magazines', name: '雑誌', level: 3, parentId: 'books_media'),
            Category(id: 'vinyl', name: 'レコード', level: 3, parentId: 'books_media'),
            Category(id: 'art_books', name: 'アートブック', level: 3, parentId: 'books_media'),
          ],
        ),
      ],
    ),
  ];

  // カテゴリIDから検索するヘルパーメソッド
  static Category? findCategoryById(String categoryId) {
    for (final mainCategory in mainCategories) {
      final result = _searchCategoryById(mainCategory, categoryId);
      if (result != null) return result;
    }
    return null;
  }

  static Category? _searchCategoryById(Category category, String targetId) {
    if (category.id == targetId) return category;
    
    for (final subcategory in category.subcategories) {
      final result = _searchCategoryById(subcategory, targetId);
      if (result != null) return result;
    }
    return null;
  }

  // 指定レベルのカテゴリを取得
  static List<Category> getCategoriesByLevel(int level) {
    final List<Category> result = [];
    
    for (final mainCategory in mainCategories) {
      _collectCategoriesByLevel(mainCategory, level, result);
    }
    
    return result;
  }

  static void _collectCategoriesByLevel(Category category, int targetLevel, List<Category> result) {
    if (category.level == targetLevel) {
      result.add(category);
    }
    
    for (final subcategory in category.subcategories) {
      _collectCategoriesByLevel(subcategory, targetLevel, result);
    }
  }

  // 親カテゴリから子カテゴリを取得
  static List<Category> getSubcategories(String parentId) {
    final parent = findCategoryById(parentId);
    return parent?.subcategories ?? [];
  }

  // ブレッドクラムのパスを取得
  static List<Category> getBreadcrumbPath(String categoryId) {
    final List<Category> path = [];
    Category? current = findCategoryById(categoryId);
    
    while (current != null) {
      path.insert(0, current);
      current = current.parentId != null ? findCategoryById(current.parentId!) : null;
    }
    
    return path;
  }
}

// 人気のカテゴリ（ショートカット用）
class PopularCategories {
  static final List<Category> popular = [
    Category(id: 'women_coat', name: 'レディースコート', level: 4),
    Category(id: 'men_sneakers', name: 'メンズスニーカー', level: 3),
    Category(id: 'handbag', name: 'ハンドバッグ', level: 3),
    Category(id: 'women_jeans', name: 'レディースジーンズ', level: 4),
    Category(id: 'men_jacket', name: 'メンズジャケット', level: 4),
    Category(id: 'women_boots', name: 'レディースブーツ', level: 3),
  ];
} 
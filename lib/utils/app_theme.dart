import 'package:flutter/material.dart';

class AppTheme {
  // ミニマル & プレミアムカラーパレット（参考デザインより）
  static const Color primaryBeige = Color(0xFFF5F1EB); // ライトベージュ
  static const Color secondaryBeige = Color(0xFFE8E2D5); // ミディアムベージュ
  static const Color darkCharcoal = Color(0xFF2C2C2C); // ダークチャコール
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color accentYellow = Color(0xFFE6D83D); // アクセントイエロー
  static const Color softGray = Color(0xFF8A8A8A); // ソフトグレー
  static const Color lightGray = Color(0xFFF8F8F8); // ライトグレー
  static const Color borderGray = Color(0xFFE0E0E0); // ボーダーグレー
  
  // 愛のエッセイ専用カラー
  static const Color loveRed = Color(0xFFD4A574); // 温かみのあるゴールドローズ
  static const Color empathyPink = Color(0xFFE8C4B0); // やわらかなピンクベージュ

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // カラースキーム
      colorScheme: ColorScheme.light(
        primary: darkCharcoal,
        secondary: accentYellow,
        surface: pureWhite,
        onSurface: darkCharcoal,
        onPrimary: pureWhite,
        onSecondary: darkCharcoal,
        outline: borderGray,
      ),
      
      // 背景色
      scaffoldBackgroundColor: lightGray,
      
      // AppBar テーマ
      appBarTheme: AppBarTheme(
        backgroundColor: pureWhite,
        foregroundColor: darkCharcoal,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: darkCharcoal,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      
      // カードテーマ
      cardTheme: CardThemeData(
        color: pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderGray, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // テキストテーマ
      textTheme: TextTheme(
        // 大見出し
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w300,
          color: darkCharcoal,
          letterSpacing: -0.5,
        ),
        
        // 中見出し
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: darkCharcoal,
          letterSpacing: 0,
        ),
        
        // タイトル
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkCharcoal,
          letterSpacing: 0.1,
        ),
        
        // ボディテキスト
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkCharcoal,
          height: 1.6,
        ),
        
        // 小さなテキスト
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: softGray,
          height: 1.4,
        ),
        
        // ラベル
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: softGray,
          letterSpacing: 0.5,
        ),
      ),
      
      // ボタンテーマ
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkCharcoal,
          foregroundColor: pureWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      // FloatingActionButton テーマ
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentYellow,
        foregroundColor: darkCharcoal,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // BottomNavigationBar テーマ
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: pureWhite,
        selectedItemColor: darkCharcoal,
        unselectedItemColor: softGray,
        type: BottomNavigationBarType.fixed,
        elevation: 1,
        selectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Divider テーマ
      dividerTheme: DividerThemeData(
        color: borderGray,
        thickness: 0.5,
        space: 1,
      ),
    );
  }

  // グラデーション定義
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBeige, secondaryBeige],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkCharcoal, Color(0xFF1A1A1A)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentYellow, Color(0xFFF2E55C)],
  );

  // シャドウ定義
  static List<BoxShadow> get subtleShadow => [
    BoxShadow(
      color: darkCharcoal.withValues(alpha: 0.04),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: darkCharcoal.withValues(alpha: 0.08),
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
} 
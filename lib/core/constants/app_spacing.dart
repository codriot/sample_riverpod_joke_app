/// Uygulama genelinde kullanılan spacing değerleri
/// 8dp grid system'e uygun (Material Design)
class AppSpacing {
  AppSpacing._(); // Private constructor

  // Base spacing unit
  static const double unit = 8.0;

  // Spacing scale (8dp grid system)
  static const double xxxs = unit * 0.25; // 2
  static const double xxs = unit * 0.5; // 4
  static const double xs = unit * 0.75; // 6
  static const double sm = unit; // 8
  static const double md = unit * 1.5; // 12
  static const double lg = unit * 2; // 16
  static const double xl = unit * 3; // 24
  static const double xxl = unit * 4; // 32
  static const double xxxl = unit * 6; // 48
  static const double huge = unit * 8; // 64

  // Semantic spacing (kullanım amacına göre)
  static const double padding = lg; // 16
  static const double paddingSmall = md; // 12
  static const double paddingLarge = xl; // 24
  static const double paddingHuge = xxl; // 32

  static const double margin = lg; // 16
  static const double marginSmall = md; // 12
  static const double marginLarge = xl; // 24
  static const double marginHuge = xxl; // 32

  static const double gap = sm; // 8
  static const double gapSmall = xxs; // 4
  static const double gapLarge = md; // 12

  // Border radius
  static const double radiusXs = xxs; // 4
  static const double radiusSm = xs; // 6
  static const double radiusMd = sm; // 8
  static const double radiusLg = md; // 12
  static const double radiusXl = lg; // 16
  static const double radiusXxl = xl; // 24
  static const double radiusCircle = 999; // Circular

  // Icon sizes
  static const double iconXs = lg; // 16
  static const double iconSm = xl; // 24
  static const double iconMd = xxl; // 32
  static const double iconLg = xxxl; // 48
  static const double iconXl = huge; // 64

  // Button sizes
  static const double buttonHeightSmall = xxxl; // 48
  static const double buttonHeightMedium = 56.0;
  static const double buttonHeightLarge = huge; // 64

  // App bar
  static const double appBarHeight = 56.0;
  static const double toolbarHeight = 56.0;

  // Bottom navigation
  static const double bottomNavHeight = 80.0;

  // Card
  static const double cardElevation = 2.0;
  static const double cardRadius = radiusLg;

  // Divider
  static const double dividerThickness = 1.0;
  static const double dividerIndent = lg;
}

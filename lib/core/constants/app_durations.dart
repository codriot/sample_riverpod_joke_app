/// Uygulama genelinde kullanılan duration değerleri
/// Animasyonlar ve transition'lar için
/// Material Design Motion System'e uygun
class AppDurations {
  AppDurations._(); // Private constructor

  // Standard duration values
  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 100);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration slower = Duration(milliseconds: 400);
  static const Duration slowest = Duration(milliseconds: 500);

  // Specific use cases
  static const Duration splash = Duration(seconds: 3);
  static const Duration snackbar = Duration(seconds: 4);
  static const Duration toast = Duration(seconds: 2);
  static const Duration tooltipShow = Duration(milliseconds: 200);
  static const Duration tooltipWait = Duration(seconds: 1);

  // Animation durations (Material Design)
  static const Duration fadeIn = Duration(milliseconds: 195);
  static const Duration fadeOut = Duration(milliseconds: 75);
  static const Duration scaleIn = Duration(milliseconds: 200);
  static const Duration scaleOut = Duration(milliseconds: 100);
  static const Duration slideIn = Duration(milliseconds: 250);
  static const Duration slideOut = Duration(milliseconds: 200);

  // Page transitions
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration pageTransitionSlow = Duration(milliseconds: 400);

  // Dialog and modal
  static const Duration dialogShow = Duration(milliseconds: 250);
  static const Duration dialogDismiss = Duration(milliseconds: 200);
  static const Duration bottomSheetShow = Duration(milliseconds: 250);
  static const Duration bottomSheetDismiss = Duration(milliseconds: 200);

  // Loading and shimmer
  static const Duration shimmerPeriod = Duration(milliseconds: 1500);
  static const Duration loadingIndicator = Duration(milliseconds: 300);
  static const Duration pullToRefresh = Duration(milliseconds: 300);

  // Network timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Debounce
  static const Duration debounceShort = Duration(milliseconds: 300);
  static const Duration debounceMedium = Duration(milliseconds: 500);
  static const Duration debounceLong = Duration(milliseconds: 1000);

  // Throttle
  static const Duration throttleShort = Duration(milliseconds: 100);
  static const Duration throttleMedium = Duration(milliseconds: 300);
  static const Duration throttleLong = Duration(milliseconds: 500);

  // Auto-dismiss
  static const Duration autoDismissShort = Duration(seconds: 2);
  static const Duration autoDismissMedium = Duration(seconds: 4);
  static const Duration autoDismissLong = Duration(seconds: 6);
}

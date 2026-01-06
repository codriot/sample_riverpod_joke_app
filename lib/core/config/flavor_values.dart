/// Flavor-specific configuration values
/// Her flavor için farklı değerler barındırır
final class FlavorValues {
  final String baseUrl;
  final bool analyticsEnabled;
  final bool crashlyticsEnabled;
  final int apiTimeout;
  final int connectTimeout;
  final int receiveTimeout;

  const FlavorValues({
    required this.baseUrl,
    this.analyticsEnabled = false,
    this.crashlyticsEnabled = false,
    this.apiTimeout = 30,
    this.connectTimeout = 10,
    this.receiveTimeout = 15,
  });

  /// Development flavor values
  static const development = FlavorValues(
    baseUrl: 'https://official-joke-api.appspot.com',
    analyticsEnabled: false,
    crashlyticsEnabled: false,
    apiTimeout: 30,
    connectTimeout: 10,
    receiveTimeout: 15,
  );

  /// Staging flavor values
  static const staging = FlavorValues(
    baseUrl: 'https://official-joke-api.appspot.com',
    analyticsEnabled: true,
    crashlyticsEnabled: true,
    apiTimeout: 30,
    connectTimeout: 10,
    receiveTimeout: 15,
  );

  /// Production flavor values
  static const production = FlavorValues(
    baseUrl: 'https://official-joke-api.appspot.com',
    analyticsEnabled: true,
    crashlyticsEnabled: true,
    apiTimeout: 30,
    connectTimeout: 10,
    receiveTimeout: 15,
  );
}

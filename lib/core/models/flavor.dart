/// Application flavors (environments)
/// Development, Staging, Production ortamlarını temsil eder
enum Flavor {
  development,
  staging,
  production;

  /// Flavor name for display
  String get name {
    switch (this) {
      case Flavor.development:
        return 'Development';
      case Flavor.staging:
        return 'Staging';
      case Flavor.production:
        return 'Production';
    }
  }

  /// Short name for app title
  String get appTitle {
    switch (this) {
      case Flavor.development:
        return 'Espri [DEV]';
      case Flavor.staging:
        return 'Espri [STG]';
      case Flavor.production:
        return 'Espri';
    }
  }

  /// Is debug mode
  bool get isDebug => this == Flavor.development;

  /// Is production mode
  bool get isProduction => this == Flavor.production;

  /// Is staging mode
  bool get isStaging => this == Flavor.staging;
}

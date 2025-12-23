import '../models/flavor.dart';
import 'flavor_values.dart';

/// Flavor configuration singleton
/// Uygulama genelinde flavor bilgisine erişim sağlar
class FlavorConfig {
  final Flavor flavor;
  final FlavorValues flavorValues;

  static FlavorConfig? _flavorConfig;

  factory FlavorConfig({required Flavor flavor, required FlavorValues flavorValues}) {
    _flavorConfig ??= FlavorConfig._(flavor, flavorValues);
    return _flavorConfig!;
  }

  const FlavorConfig._(this.flavor, this.flavorValues);

  static FlavorConfig get instance {
    assert(_flavorConfig != null, 'FlavorConfig has not been initialized');
    return _flavorConfig!;
  }

  /// Check if instance is initialized
  static bool get isInitialized => _flavorConfig != null;

  /// Initialize with flavor
  static void initialize(Flavor flavor) {
    FlavorValues values;
    switch (flavor) {
      case Flavor.development:
        values = FlavorValues.development;
        break;
      case Flavor.staging:
        values = FlavorValues.staging;
        break;
      case Flavor.production:
        values = FlavorValues.production;
        break;
    }

    FlavorConfig(flavor: flavor, flavorValues: values);
  }

  @override
  String toString() => 'FlavorConfig(flavor: ${flavor.name}, baseUrl: ${flavorValues.baseUrl})';
}

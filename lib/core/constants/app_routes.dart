/// Route path ve name tanımlamaları
/// Hard-coded string'lerden kaçınmak ve type-safety sağlamak için
/// Senior Flutter Developer Best Practice
class AppRoutes {
  // Private constructor - Static class
  AppRoutes._();

  // Route Paths
  static const String splash = '/';
  static const String jokes = '/jokes';

  // Route Names
  static const String splashName = 'splash';
  static const String jokesName = 'jokes';

  /// Tüm route path'leri
  static const List<String> allPaths = [splash, jokes];

  /// Tüm route name'leri
  static const List<String> allNames = [splashName, jokesName];
}

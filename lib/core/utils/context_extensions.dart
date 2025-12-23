import 'package:flutter/material.dart';

/// Context extensions - BuildContext için utility metodlar
extension ContextExtensions on BuildContext {
  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // MediaQuery shortcuts
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  // Screen type checks
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;
  bool get isDesktop => screenWidth >= 900;

  // Orientation
  Orientation get orientation => MediaQuery.of(this).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // Platform brightness
  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;
  bool get isDarkMode => platformBrightness == Brightness.dark;
  bool get isLightMode => platformBrightness == Brightness.light;

  // Keyboard
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  // Safe area
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  // Navigation shortcuts
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Route<T> route) => Navigator.of(this).push(route);
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);
  Future<T?> pushReplacement<T, TO>(Route<T> route, {TO? result}) =>
      Navigator.of(this).pushReplacement(route, result: result);
  void popUntil(bool Function(Route<dynamic>) predicate) => Navigator.of(this).popUntil(predicate);

  // Snackbar
  void showSnackBar(String message, {Duration duration = const Duration(seconds: 4), SnackBarAction? action}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message), duration: duration, action: action));
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: colorScheme.error, duration: const Duration(seconds: 4)),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green, duration: const Duration(seconds: 3)),
    );
  }

  // Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  // Focus
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }

  void unFocus() {
    FocusScope.of(this).unfocus();
  }
}

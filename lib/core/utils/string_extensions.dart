/// String extensions - String için utility metodlar
extension StringExtensions on String {
  // Null/empty checks
  bool get isNullOrEmpty => isEmpty;
  bool get isNotNullOrEmpty => isNotEmpty;

  // Capitalization
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get toTitleCase => capitalizeWords;

  // Case conversions
  String get toCamelCase {
    if (isEmpty) return this;
    final words = split(RegExp(r'[_\s-]+'));
    if (words.isEmpty) return this;
    return words.first.toLowerCase() + words.skip(1).map((w) => w.capitalize).join();
  }

  String get toSnakeCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  String get toKebabCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '-${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^-'), '');
  }

  // Trimming
  String get trimAll => replaceAll(RegExp(r'\s+'), '');
  String get trimExtraSpaces => replaceAll(RegExp(r'\s+'), ' ').trim();

  // Validation
  bool get isEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  bool get isPhone {
    final phoneRegex = RegExp(r'^\+?[\d\s-()]{10,}$');
    return phoneRegex.hasMatch(this);
  }

  bool get isUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  bool get isAlphanumeric {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  // Parsing
  int? get toInt => int.tryParse(this);
  double? get toDouble => double.tryParse(this);

  int get toIntOrZero => int.tryParse(this) ?? 0;
  double get toDoubleOrZero => double.tryParse(this) ?? 0.0;

  // Truncate
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  // Remove
  String removeWhitespace() => replaceAll(RegExp(r'\s+'), '');
  String removeNonNumeric() => replaceAll(RegExp(r'[^0-9]'), '');
  String removeNonAlphabetic() => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  // Count
  int countOccurrences(String substring) {
    int count = 0;
    int index = 0;
    while ((index = indexOf(substring, index)) != -1) {
      count++;
      index += substring.length;
    }
    return count;
  }

  // Reverse
  String get reverse => split('').reversed.join();

  // Contains any
  bool containsAny(List<String> substrings) {
    return substrings.any((substring) => contains(substring));
  }

  // Mask (for sensitive data)
  String mask({int visibleStart = 0, int visibleEnd = 0, String maskChar = '*'}) {
    if (length <= visibleStart + visibleEnd) return this;
    final start = substring(0, visibleStart);
    final end = substring(length - visibleEnd);
    final masked = maskChar * (length - visibleStart - visibleEnd);
    return '$start$masked$end';
  }

  // Turkish character conversion
  String get toEnglishChars {
    const turkish = 'çğıöşüÇĞİÖŞÜ';
    const english = 'cgiosuCGIOSU';
    String result = this;
    for (int i = 0; i < turkish.length; i++) {
      result = result.replaceAll(turkish[i], english[i]);
    }
    return result;
  }
}

/// Nullable string extensions
extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String get orEmpty => this ?? '';
  String orDefault(String defaultValue) => this ?? defaultValue;
}

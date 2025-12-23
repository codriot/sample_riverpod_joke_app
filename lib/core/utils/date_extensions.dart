import 'package:intl/intl.dart';

/// DateTime extensions - DateTime için utility metodlar
extension DateTimeExtensions on DateTime {
  // Formatters
  String format([String pattern = 'dd/MM/yyyy']) {
    return DateFormat(pattern).format(this);
  }

  String get toDateString => format('dd/MM/yyyy');
  String get toTimeString => format('HH:mm');
  String get toDateTimeString => format('dd/MM/yyyy HH:mm');
  String get toFullDateTimeString => format('dd MMMM yyyy HH:mm');

  // Turkish formatters
  String get toTurkishDate => format('dd.MM.yyyy');
  String get toTurkishDateTime => format('dd.MM.yyyy HH:mm');
  String get toTurkishFullDate => format('dd MMMM yyyy, EEEE');

  // Relative time (zaman farkı)
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} saniye önce';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks hafta önce';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ay önce';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years yıl önce';
    }
  }

  // Checks
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return isAfter(weekStart) && isBefore(weekEnd);
  }

  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  bool get isThisYear {
    final now = DateTime.now();
    return year == now.year;
  }

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
  bool get isWeekday => !isWeekend;

  // Manipulations
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));
  DateTime get endOfWeek => add(Duration(days: 7 - weekday));

  DateTime get startOfMonth => DateTime(year, month, 1);
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  DateTime get startOfYear => DateTime(year, 1, 1);
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  // Add/subtract shortcuts
  DateTime addYears(int years) => DateTime(year + years, month, day, hour, minute, second, millisecond, microsecond);

  DateTime addMonths(int months) {
    int newMonth = month + months;
    int newYear = year;
    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }
    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }
    return DateTime(newYear, newMonth, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime addWeeks(int weeks) => add(Duration(days: weeks * 7));

  // Copy with
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  // Age calculation
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  // Days in month
  int get daysInMonth {
    return DateTime(year, month + 1, 0).day;
  }
}

/// Nullable DateTime extensions
extension NullableDateTimeExtensions on DateTime? {
  String format([String pattern = 'dd/MM/yyyy']) {
    if (this == null) return '';
    return DateFormat(pattern).format(this!);
  }

  String get orEmpty => this?.format() ?? '';
  DateTime get orNow => this ?? DateTime.now();
}

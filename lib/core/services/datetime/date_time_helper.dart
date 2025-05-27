import 'package:intl/intl.dart';

class DateHelper {
  /// Default date formats
  static final List<String> _defaultFormats = [
    "yyyy-MM-dd'T'HH:mm:ss'Z'", // ISO-8601
    "yyyy-MM-dd HH:mm:ss",
    "yyyy-MM-dd",
    "MM/dd/yyyy",
    "dd/MM/yyyy",
    "dd-MM-yyyy",
  ];

  /// Parses a date string into a [DateTime] object.
  /// Tries all default formats unless [formats] is provided.
  /// Returns `null` if parsing fails.
  static DateTime? parse(String dateString, {List<String>? formats}) {
    final formatList = formats ?? _defaultFormats;

    for (var format in formatList) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (_) {
        // Continue trying other formats
      }
    }
    return null; // Return null if no format matches
  }

  /// Formats a [DateTime] object into a string based on the provided [outputFormat].
  static String format(DateTime date, {String outputFormat = "yyyy-MM-dd HH:mm:ss"}) {
    try {
      return DateFormat(outputFormat).format(date);
    } catch (_) {
      return ''; // Return empty string on error
    }
  }

  /// Parses a timestamp (milliseconds or seconds since epoch) into a [DateTime] object.
  static DateTime? parseTimestamp(dynamic timestamp, {bool isMilliseconds = true}) {
    try {
      if (timestamp is int) {
        return isMilliseconds
            ? DateTime.fromMillisecondsSinceEpoch(timestamp)
            : DateTime.fromMicrosecondsSinceEpoch(timestamp);
      }
      return null; // Invalid timestamp type
    } catch (_) {
      return null; // Return null on error
    }
  }

  /// Parses a date string and converts it to another format.
  /// Returns `null` if parsing or formatting fails.
  static String? reformatDate(String dateString, {
    required String outputFormat,
    List<String>? inputFormats,
  }) {
    final parsedDate = parse(dateString, formats: inputFormats);
    if (parsedDate != null) {
      return format(parsedDate, outputFormat: outputFormat);
    }
    return null; // Return null if parsing fails
  }

  /// Convert Gregorian to Hijri Date
  String convertToHijri(String hijriDate) {
    DateTime gregorianDate = DateFormat("yyyy-MM-dd").parse(hijriDate);
    // Approximate conversion formula
    const int hijriEpoch = 622; // Year 622 is the base of the Islamic calendar
    const double hijriYearDays = 354.367; // Average Hijri year length

    // Days since Gregorian epoch (adjust for Hijri epoch)
    final int daysSinceEpoch = gregorianDate.difference(DateTime(hijriEpoch)).inDays;

    // Approximate Hijri year
    final double hijriYears = daysSinceEpoch / hijriYearDays;
    final int hijriYear = hijriEpoch + hijriYears.floor();

    // Remaining days to calculate the Hijri month and day
    final double fractionalYear = hijriYears - hijriYears.floor();
    final int daysInHijriYear = (fractionalYear * hijriYearDays).round();

    // Calculate month and day (simple approximation, no leap year handling)
    const List<int> hijriMonthLengths = [30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29];
    int hijriMonth = 0;
    int hijriDay = daysInHijriYear;

    for (int i = 0; i < hijriMonthLengths.length; i++) {
      if (hijriDay <= hijriMonthLengths[i]) {
        hijriMonth = i + 1;
        break;
      }
      hijriDay -= hijriMonthLengths[i];
    }

    return '$hijriYear-$hijriMonth-$hijriDay';
  }

}


import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
// import 'package:mawidak/features/calendar/presentation/ui/widgets/components/item_component_model.dart';

final List<int> gregorianMonthDays = [
  31,
  28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
];

final List<String> gregorianMonths = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر'
];

// final List<String> hijriMonths = [
//   'محرم',
//   'صفر',
//   'ربيع الأول',
//   'ربيع الآخر',
//   'جمادى الأول',
//   'جمادى الآخر',
//   'رجب',
//   'شعبان',
//   'رمضان',
//   'شوال',
//   'ذو القعدة',
//   'ذو الحجة'
// ];

final List<String> hijriWeekDays = [
  'الأحد',
  'الاثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
];


// final List<String> weekDays = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
// final List<String> weekDays = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
final List<String> weekDays = ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة','السبت'];

final List<String> hijriMonths = [
  'محرم',
  'صفر',
  'ربيع الأول',
  'ربيع الثاني',
  'جمادى الأولى',
  'جمادى الثانية',
  'رجب',
  'شعبان',
  'رمضان',
  'شوال',
  'ذو القعدة',
  'ذو الحجة',
];

// List<ItemComponentModel> list = [
//   ItemComponentModel(
//       title: 'اجازه منتصف العام',
//       color: MyCalendarType.colors[CalendarType.halfYearHoliday]),
//   ItemComponentModel(
//       title: 'اجازه العيد',
//       color: MyCalendarType.colors[CalendarType.eidHoliday]),
//   ItemComponentModel(
//       title: 'اجازه نهايه العام',
//       color: MyCalendarType.colors[CalendarType.endYearHoliday]),
//   ItemComponentModel(
//       title: 'فعاليات المعهد',
//       color: MyCalendarType.colors[CalendarType.activitiesInstitues]),
//   ItemComponentModel(
//       title: 'اجازه اليوم الوطني',
//       color: MyCalendarType.colors[CalendarType.nationalDayHoliday]),
// ];


Color getRandomColor(int day, int selectedMonth, int selectedYear,
    Map<Map<String, int>, Color> targetDates) {
  // Convert Hijri dates in targetDates to Gregorian dates
  Map<Map<String, int>, Color> convertedDates = {};
  for (var target in targetDates.keys) {
    int targetYear = target['year'] ?? 0;
    int targetMonth = target['month'] ?? 0;
    int targetDay = target['day'] ?? 0;
    // Convert Hijri date to Gregorian date
    DateTime gregorianDate =
    HijriCalendar().hijriToGregorian(targetYear, targetMonth, targetDay);
    // Add converted Gregorian date to the new map
    convertedDates[{
      'year': gregorianDate.year,
      'month': gregorianDate.month,
      'day': gregorianDate.day
    }] = targetDates[target] ?? Colors.transparent;
  }

  // Loop through the map of converted Gregorian dates and check for matches
  for (var target in convertedDates.keys) {
    if (selectedYear == target['year'] &&
        selectedMonth == target['month'] &&
        day == target['day']) {
      return convertedDates[target] ??
          Colors.transparent; // Return the color if a match is found
    }
  }
  // Return a transparent color if no match is found
  return Colors.transparent;
}
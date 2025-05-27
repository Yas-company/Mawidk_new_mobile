import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mawidak/core/global/global_func.dart';

class ArabicDatePicker extends StatefulWidget {
  final Function(String) onChoose;
  const ArabicDatePicker({super.key, required this.onChoose});

  @override
  State<ArabicDatePicker> createState() => _ArabicDatePickerState();
}

class _ArabicDatePickerState extends State<ArabicDatePicker> {
  DateTime selectedDate = DateTime.now();
  List<String> finalList = [];
  // Arabic month names
  final List<String> arabicMonths = [
    '', // index 0 unused
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
    'ديسمبر',
  ];

  final List<String> englishMonths = [
    '', // index 0 unused
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];


  void goToPreviousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
    });
  }

  void goToNextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    finalList = isArabic()?arabicMonths:englishMonths;
    return Container(
      padding: const EdgeInsets.only(top:10,bottom:16),
      decoration: BoxDecoration(
        color:AppColors.primaryColor550,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 🔼 Custom Header
          Padding(
            padding: const EdgeInsets.only(right:16,left:12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PText(title:'choose_day'.tr(),size:PSize.text14,),
                const SizedBox(height:20,),
                Row(
                  children: [
                    InkWell(
                      onTap: goToPreviousMonth,
                      child: Icon(Icons.chevron_left, color:AppColors.grey200),
                    ),
                    PText(title:
                    '${finalList[selectedDate.month]} ${selectedDate.year}',
                      fontColor:AppColors.grey200,
                    ),
                    InkWell(
                      onTap: goToNextMonth,
                      child: Icon(Icons.chevron_right, color:AppColors.grey200),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 📅 EasyDateTimeLine
          Padding(
            padding: const EdgeInsets.only(top:20,right:10,left:10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: EasyDateTimeLine(
                  key: ValueKey("${selectedDate.year}-${selectedDate.month}"),
                  headerProps: EasyHeaderProps(showHeader: false),
                  initialDate: selectedDate,
                  onDateChange: (date) {
                    setState(() {
                      String formatted = intl.DateFormat('yyyy-MM-dd').format(date);
                      widget.onChoose(formatted);
                      selectedDate = date;
                      // print('selectedDate>>'+selectedDate.toString());
                    });
                  },
                  activeColor: AppColors.primaryColor2200,
                  locale: 'ar_DZ',
                  dayProps: EasyDayProps(height:83,width:60,
                      dayStructure: DayStructure.dayNumDayStr,
                      todayStyle:DayStyle(borderRadius: 8,
                          dayNumStyle:TextStyle(fontSize:16,fontWeight:FontWeight.w700,
                              fontFamily: 'Cairo',color:AppColors.primaryColor),
                          dayStrStyle:TextStyle(fontSize:12,fontWeight:FontWeight.w500,
                              fontFamily: 'Cairo',color:AppColors.grayShade3)),
                      activeDayStyle: DayStyle(borderRadius: 8,
                          dayNumStyle:TextStyle(fontSize:16,fontWeight:FontWeight.w700,
                              fontFamily: 'Cairo',color:AppColors.primaryColor),
                          dayStrStyle:TextStyle(fontSize:12,fontWeight:FontWeight.w500,
                              fontFamily: 'Cairo',color:AppColors.grayShade3)),
                      inactiveDayStyle: DayStyle(borderRadius:8,dayNumStyle:
                      TextStyle(fontSize:16,fontWeight:FontWeight.w700,
                          fontFamily: 'Cairo',color:AppColors.primaryColor),
                          dayStrStyle:TextStyle(fontSize:12,fontWeight:FontWeight.w500,
                              fontFamily: 'Cairo',color:AppColors.grayShade3)),
                      borderColor:AppColors.primaryColor3300
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
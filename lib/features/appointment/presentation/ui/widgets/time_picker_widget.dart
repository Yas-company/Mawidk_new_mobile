import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';


class TimePickerWidget extends StatefulWidget {
  final Function(String) onChoose;
  const TimePickerWidget({super.key,required this.onChoose});

  @override
  State<TimePickerWidget> createState() => TimePickerWidgetState();
}

class TimePickerWidgetState extends State<TimePickerWidget> {
  final Map<String,String> times = {
    '12:00': 'صباحًا',
    '12:30': 'صباحًا',
    '1:00': 'مساءً',
    '2:30': 'مساءً',
    '3:00': 'مساءً',
    '3:30': 'مساءً',
    '4:00': 'مساءً'
  };

  String? selectedTime; // to track selected time

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:20,bottom:16),
      padding: const EdgeInsets.only(top:8,bottom:16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor550,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:16,bottom:20,left:16,right:16),
            child: PText(title:'choose_time'.tr(), size: PSize.text14),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal:14),
            physics: NeverScrollableScrollPhysics(),
            itemCount: times.entries.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final entry = times.entries.elementAt(index);
              final isSelected = entry.key == selectedTime;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTime = entry.key;
                    widget.onChoose(entry.key+' '+(entry.value == 'مساءً'?'PM':'AM'));
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor3300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected ? AppColors.primaryColor2200 : Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PText(
                        title: entry.key,
                        fontColor: isSelected ? AppColors.primaryColor : AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(width:4),
                      PText(
                        title: entry.value,
                        fontColor: isSelected ? AppColors.primaryColor : AppColors.grayShade3,
                        fontWeight: FontWeight.w500,
                        size: PSize.text14,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

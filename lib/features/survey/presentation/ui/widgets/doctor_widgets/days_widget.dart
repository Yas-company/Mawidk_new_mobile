import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/global_func.dart';

class DaysWidget extends StatefulWidget {
  @override
  DaysWidgetState createState() => DaysWidgetState();
}

class DaysWidgetState extends State<DaysWidget> {

  final Set<String> selectedDays = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 0,
      children: arabicDays.map((day) {
        final bool isSelected = selectedDays.contains(day);
        return ChoiceChip(
          showCheckmark:false,
          label:PText(title:day),
          selected: isSelected,padding:EdgeInsets.zero,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side:BorderSide(color:isSelected?AppColors.primaryColor:
            AppColors.whiteColor)
          ),
          selectedColor:AppColors.primaryColor200,
          backgroundColor:AppColors.whiteColor,
          labelStyle: TextStyle(
            color:AppColors.blackColor,
            fontFamily:'cairo'
          ),
          onSelected: (_) {
            setState(() {
              if (isSelected) {
                selectedDays.remove(day);
              } else {
                selectedDays.add(day);
              }
            });
          },
        );
      }).toList(),
    );
  }
}

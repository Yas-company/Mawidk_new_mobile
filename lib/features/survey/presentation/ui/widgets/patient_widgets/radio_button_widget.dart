import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';


class RadioButtonWidget extends StatelessWidget {
  final List<Option> options;
  final String label;
  final dynamic selectedValue;
  // final Function(String) onChanged;
  final Function(Option) onChanged;

  const RadioButtonWidget({
    super.key,
    required this.options,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:14),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            PText(title: label, fontWeight: FontWeight.w500, size: PSize.text16,),
            ...options.map((option) {
              final isSelected = option.optionText == (selectedValue is Option
                  ? (selectedValue as Option).optionText
                  : selectedValue);
              // final isSelected = selectedValue == option.optionText;
              return GestureDetector(
                // onTap: () => onChanged(option.optionText??''),
                onTap: () => onChanged(option),
                child: Container(
                  margin:EdgeInsets.only(top:10),
                  padding: const EdgeInsets.symmetric(vertical:18, horizontal:10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor100 : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Circle radio shape
                      Container(
                        width: 24, height:24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:  AppColors.primary500,
                            width:3,
                          ),
                        ),
                        child: isSelected ? Center(
                          child: Container(
                            width: 14, height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:AppColors.primary500,
                            ),
                          ),
                        )
                            : null,
                      ),
                      SizedBox(width: 12),
                      // Text
                      PText(title:option.optionText??'',fontWeight:FontWeight.w400,
                        size:PSize.text14,
                        fontColor:isSelected ?AppColors.blackColor:AppColors.grey200,),
                    ],
                  ),
                ),
              );
            }),
          ]
      ),
    );
  }
}





class CustomRadioButtonWidget extends StatelessWidget {
  final List<Option> options;
  final String label;
  final dynamic selectedValue;
  final Function(Option) onChanged;

  const CustomRadioButtonWidget({
    super.key,
    required this.options,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:14),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            PText(title: label, fontWeight: FontWeight.w500, size: PSize.text16,),
            ...options.map((option) {
              final isSelected = option.optionText == (selectedValue is Option
                  ? (selectedValue as Option).optionText
                  : selectedValue);
              // final isSelected = selectedValue == option.optionText;
              return GestureDetector(
                // onTap: () => onChanged(option.optionText??''),
                onTap: () => onChanged(option),
                child: Container(
                  margin:EdgeInsets.only(top:6),
                  padding: const EdgeInsets.symmetric(vertical:12, horizontal:10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor1100 : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      // Circle radio shape
                      Container(
                        width: 16, height:16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected?AppColors.primaryColor:AppColors.grey200,
                            width:3,
                          ),
                        ),
                        child:null,
                      ),
                      SizedBox(width: 12),
                      // Text
                      PText(title:option.optionText??'',fontWeight:FontWeight.w400,
                        size:PSize.text14,
                        fontColor:isSelected ?AppColors.blackColor:AppColors.grey200,),
                    ],
                  ),
                ),
              );
            }),
          ]
      ),
    );
  }
}
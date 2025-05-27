import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';


class MultiSelectChoice extends StatelessWidget {
  final String title;
  final List<Option> options;
  // final List<String> options;
  // final List<String>? selectedValues;
  final List<Option>? selectedValues;
  // final ValueChanged<List<String>> onChanged;
  final ValueChanged<List<Option>> onChanged;

  const MultiSelectChoice({
    super.key,
    required this.title,
    required this.options,
    this.selectedValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            title: title,
            size: PSize.text16,
            fontColor: AppColors.fontColor,
          ),
          const SizedBox(height: 5),
          LayoutBuilder(
            builder: (context, constraints) {
              final double spacing = 10;
              final double totalWidth = constraints.maxWidth;
              final double itemWidth = (totalWidth - spacing) / 2;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(options.length, (index) {
                  final item = options[index];
                  final isSelected = selectedValues?.any((e) => e.optionText==item.optionText,)??false;
                  // final isSelected = selectedValues?.contains(item)??false;

                  // Check if last item and odd count -> make full width
                  final bool isLast = index == options.length - 1;
                  final bool isOddCount = options.length % 2 != 0;
                  final bool isSingleInRow = isLast && isOddCount;

                  return SizedBox(
                    width: isSingleInRow ? totalWidth : itemWidth,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        final updatedValues = List<Option>.from(selectedValues??[]);
                        if (isSelected) {
                          // updatedValues.remove(item.optionText);
                          updatedValues.remove(item);
                        } else {
                          // updatedValues.add(item.optionText??'');
                          updatedValues.add(item);
                        }
                        onChanged(updatedValues);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical:24,horizontal:10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor100 : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: PText(
                          title: item.optionText??'',
                          // title: item??'',
                          fontWeight:FontWeight.w400,
                          size: PSize.text14,
                          fontColor: !isSelected ?AppColors.grey200: AppColors.fontColor,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          )

          // Wrap(
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: options.map((item) {
          //     final isSelected = selectedValues.contains(item);
          //     return InkWell(
          //       splashColor: Colors.transparent,
          //       focusColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       hoverColor: Colors.transparent,
          //       onTap: () {
          //         final updatedValues = List<String>.from(selectedValues);
          //         if (isSelected) {
          //           updatedValues.remove(item);
          //         } else {
          //           updatedValues.add(item);
          //         }
          //         onChanged?.call(updatedValues);
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
          //         decoration: BoxDecoration(
          //           color: isSelected ? AppColors.primaryColor100 : AppColors.grey100,
          //           borderRadius: BorderRadius.circular(16),
          //           border: Border.all(
          //             color: isSelected ? AppColors.primaryColor : Colors.transparent,
          //             width: 1.5,
          //           ),
          //         ),
          //         child: PText(
          //           title: item,
          //           size: PSize.text12,
          //           fontColor: AppColors.fontColor,
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}

class MultiSelectChoiceDoctor extends StatelessWidget {
  final String title;
  final List<Option> options;
  final dynamic selectedValue;
  final ValueChanged<Option> onChanged;

  const MultiSelectChoiceDoctor({
    super.key,
    required this.title,
    required this.options,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            title: title,
            size: PSize.text16,
            fontColor: AppColors.fontColor,
          ),
          const SizedBox(height: 5),
          LayoutBuilder(
            builder: (context, constraints) {
              final double spacing = 10;
              final double totalWidth = constraints.maxWidth;
              final double itemWidth = (totalWidth - spacing) / 2;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(options.length, (index) {
                  final item = options[index];
                  final isSelected = item.optionText == (selectedValue is Option
                      ? (selectedValue as Option).optionText
                      : selectedValue);
                  // final isSelected = selectedValues?.contains(item)??false;

                  // Check if last item and odd count -> make full width
                  final bool isLast = index == options.length - 1;
                  final bool isOddCount = options.length % 2 != 0;
                  final bool isSingleInRow = isLast && isOddCount;

                  return SizedBox(
                    width: isSingleInRow ? totalWidth : itemWidth,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        // final updatedValues = List<Option>.from(selectedValues??[]);
                        // if (isSelected) {
                        //   // updatedValues.remove(item.optionText);
                        //   updatedValues.remove(item);
                        // } else {
                        //   // updatedValues.add(item.optionText??'');
                        //   updatedValues.add(item);
                        // }
                        onChanged.call(item);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical:24,horizontal:10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor100 : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: PText(
                          title: item.optionText??'',
                          // title: item??'',
                          fontWeight:FontWeight.w400,
                          size: PSize.text14,
                          fontColor: !isSelected ?AppColors.grey200: AppColors.fontColor,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          )

          // Wrap(
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: options.map((item) {
          //     final isSelected = selectedValues.contains(item);
          //     return InkWell(
          //       splashColor: Colors.transparent,
          //       focusColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       hoverColor: Colors.transparent,
          //       onTap: () {
          //         final updatedValues = List<String>.from(selectedValues);
          //         if (isSelected) {
          //           updatedValues.remove(item);
          //         } else {
          //           updatedValues.add(item);
          //         }
          //         onChanged?.call(updatedValues);
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
          //         decoration: BoxDecoration(
          //           color: isSelected ? AppColors.primaryColor100 : AppColors.grey100,
          //           borderRadius: BorderRadius.circular(16),
          //           border: Border.all(
          //             color: isSelected ? AppColors.primaryColor : Colors.transparent,
          //             width: 1.5,
          //           ),
          //         ),
          //         child: PText(
          //           title: item,
          //           size: PSize.text12,
          //           fontColor: AppColors.fontColor,
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';


class SingleSelectChoice extends StatelessWidget {
  final String title;
  final List<Option> options;
  final String? selectedValues;
  final ValueChanged<Option> onChanged;

  const SingleSelectChoice({
    super.key,
    required this.title,
    required this.options,
    this.selectedValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            title: title, size: PSize.text14,
            fontColor: AppColors.fontColor,
          ),
          const SizedBox(height: 5),
          LayoutBuilder(
            builder: (context, constraints) {
              final double spacing = 10;
              final double totalWidth = constraints.maxWidth;
              final double itemWidth = (totalWidth - spacing) / 3.2;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(options.length, (index) {
                  final item = options[index];
                  final isSelected = item.optionText == (selectedValues is Option
                      ? (selectedValues as Option).optionText
                      : selectedValues);
                  // final isSelected = selectedValues == item;
                  return SizedBox(
                    width: itemWidth,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        // final updatedValues = selectedValues??'';
                        // onChanged(item.optionText??'');
                        onChanged(item);
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
                        child: Center(
                          child: PText(
                            title: item.optionText??'',
                            size: PSize.text12,
                            fontColor: !isSelected ?AppColors.grey200: AppColors.fontColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          )
        ],
      ),
    );
  }
}


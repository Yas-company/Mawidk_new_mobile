import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';

class DropDownWidget extends StatefulWidget {
  final List<Option> options;
  final String title;
  final String hint;
  final bool showCheckbox;
  final List<Option> selectedValues;
  final ValueChanged<List<Option>> onChanged;

  const DropDownWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.options,
    this.showCheckbox=false,
    required this.selectedValues,
    required this.onChanged,
  });

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(
            title: widget.title, size: PSize.text14,
            fontColor: AppColors.fontColor,
          ),
          const SizedBox(height:10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color:AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color:AppColors.whiteColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Option>(
                menuMaxHeight:MediaQuery.sizeOf(context).height*0.45,
                isExpanded: true,dropdownColor: AppColors.whiteColor,
                hint:PText(title:widget.hint),
                value: null,
                onChanged: (Option? newValue) {
                  if (newValue == null) return;
                  setState(() {
                    if (widget.selectedValues.contains(newValue)) {
                      widget.selectedValues.remove(newValue);
                    } else {
                      widget.selectedValues.add(newValue);
                    }
                  });
                  widget.onChanged(widget.selectedValues);
                },
                items: widget.options.map((Option value) {
                  return DropdownMenuItem<Option>(
                    value: value,
                    enabled: !widget.selectedValues.contains(value),
                    child: PText(title:
                      value.optionText ?? '',
                      fontColor:widget.selectedValues.contains(value)
                          ? Colors.grey : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 6,
            children: widget.selectedValues.map((value) {
              return Chip(
                label:PText(title:value.optionText ?? '',
                    fontColor:AppColors.whiteColor,size:PSize.text14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor:AppColors.primaryColor2,
                deleteIcon: const Icon(Icons.close,color:AppColors.whiteColor,),
                onDeleted: () {
                  setState(() {
                    widget.selectedValues.remove(value);
                  });
                  widget.onChanged(widget.selectedValues);
                },
              );
            }).toList(),
          ),
          CheckboxListTile(activeColor:AppColors.primaryColor,
            contentPadding:EdgeInsets.zero,
            title: Row(
              children: [
                PText(title: 'there_is_no_diseases'.tr(),size: PSize.text18,)
              ],
            ),
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading, // checkbox on the left
          )
          // Directionality(textDirection: TextDirection.ltr,
          //   child: CheckboxListTile(contentPadding:EdgeInsets.zero,
          //     // title: PText(title: 'there_is_no_diseases'.tr()),
          //     value: _isChecked,
          //     onChanged: (bool? value) {
          //       setState(() {
          //         _isChecked = value ?? false;
          //       });
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/bloc/static_survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/dynamic_question_widget.dart';

StaticSurveyBloc staticSurveyBloc = StaticSurveyBloc(surveyUseCase: getIt());
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
  bool isEnabled = false;
  List<Option> emptyOptions = [];
  void _setEnabled(bool value) {
    setState(() {
      isEnabled = value;
      if(!isEnabled){
        widget.selectedValues.clear();
      }
      if(!isDoctor()){
      isTrue = isEnabled;
      options = widget.selectedValues;
      staticSurveyBloc.add(ValidateSurveyEvent());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // print('showCheckBoc>>'+widget.showCheckbox.toString());
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(widget.showCheckbox) Row(
            children: [
              Expanded(child: SizedBox(width:MediaQuery.sizeOf(context).width*.80,
                  child: PText(title:'have_diseases'.tr()))),
              Container(width: 40, height: 40,
                decoration:  BoxDecoration(
                  color:(isEnabled ? AppColors.primaryColor100 : AppColors.grey100),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color:(isEnabled ? AppColors.primaryColor : AppColors.grey100)
                  ),
                ),
                child: IconButton(highlightColor:Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () => _setEnabled(true),
                  icon: Icon(Icons.check, color:
                   (isEnabled ? AppColors.primaryColor : AppColors.grey200)),
                  tooltip: 'Yes',
                ),
              ),
              const SizedBox(width: 10),
              Container(width: 40, height: 40,
                decoration: BoxDecoration(
                  color:(!isEnabled ? AppColors.dangerColor100 : AppColors.grey100),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: (!isEnabled ? AppColors.dangerColor : AppColors.grey100)
                  ),
                ),
                child: IconButton(
                  highlightColor:Colors.transparent,
                  onPressed: () => _setEnabled(false),
                  icon: Icon(Icons.clear, color:
                  (!isEnabled ? AppColors.dangerColor : AppColors.grey200)),
                  tooltip: 'No',
                ),
              ),
            ],
          ),
          if(widget.showCheckbox) const SizedBox(height:10,),
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
                  if(widget.showCheckbox){
                    if(!isEnabled){
                      return;
                    }
                  }
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
                items: ((widget.showCheckbox&&!isEnabled)?emptyOptions:widget.options).map((Option value) {
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
            children: (widget.selectedValues).map((value) {
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

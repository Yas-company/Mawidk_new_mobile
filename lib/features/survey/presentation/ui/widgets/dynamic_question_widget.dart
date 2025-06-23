import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/adding_text_filed_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/drop_down_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/multi_select_choice.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/radio_button_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/single_choice.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/single_select_choice.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/text_with_check.dart';

bool isTrue = false;
List<Option> options = [];

Widget buildQuestionWidget(Question q, Function setStateCallback){
  switch (q.type) {
    case 'sate':
      final DateTime? selectedDate = q.answer != null ? DateTime.parse(q.answer!) : null;
      return Padding(
        padding: const EdgeInsets.only(top:14),
        child: InkWell(onTap:() async {
          final DateTime? picked = await showDatePicker(
            context:Get.context!,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != selectedDate) {
            setStateCallback(() {
              q.answer = DateFormat('yyyy-MM-dd').format(picked);
            });
          }
        },child: PTextField(controller:TextEditingController(
          text:selectedDate!=null? q.answer??'' : ''
        ),enabled:false,labelAbove:q.questionText,
          labelAboveFontSize: PSize.text16,
          // hintText:'',
          hintText:q.questionText,
            feedback:(value) {

          },disabledBorderColor:AppColors.whiteColor,
          contentPadding:EdgeInsets.only(left:10,right:10,top:14,bottom:14),
        ),
        ),
      );
    case 'boolean':
      return SwitchListTile(
        title: Text(q.questionText??''),
        value: q.answer == true,
        onChanged: (val) {
          setStateCallback(() {
            q.answer = val;
          });
        },
      );
    case 'number':
      return Padding(
        padding: const EdgeInsets.only(top: 10,bottom:10),
        child: PTextField(labelAboveFontSize: PSize.text16,textInputType:TextInputType.number,
          controller: TextEditingController(text: q.answer)
            ..selection = TextSelection.collapsed(offset: q.answer?.length ?? 0),
          labelAbove: q.questionText,
          hintText: q.hint,
          feedback: (val) {
            setStateCallback(() {
              q.answer = val;
              // print('q.answer>>'+q.answer.toString());
            });
          },
          validator: (value) => null,
        ),
      );
      case 'text':
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: PTextField(labelAboveFontSize: PSize.text16,
          controller: TextEditingController(text: q.answer)
            ..selection = TextSelection.collapsed(offset: q.answer?.length ?? 0),
          labelAbove: q.questionText,
          hintText: q.questionText,
          feedback: (val) {
            setStateCallback(() {
              q.answer = val;
              print('q.answer>>'+q.answer.toString());
            });
          },
          validator: (value) => null,
        ),
      );

    case 'text_with_check':
      return TextWithCheck(isTrue:q.isTrue,
        hint:q.hint??'',
        title: q.questionText??'',
        answer:q.answer,
        onAnswer:(value) {
          setStateCallback(() {
            q.answer = value;
            // q.isTrue = value;
            // print('object>>'+q.isTrue.toString());
          });
        }
      );

      case 'textarea':
      return Padding(
        padding: q.padding ?? const EdgeInsets.only(top: 10,bottom:10),
        child: PTextField(maxLines:q.line ?? 5,
          controller: TextEditingController(text: q.answer)
            ..selection = TextSelection.collapsed(offset: q.answer?.length ?? 0),
          labelAbove: q.questionText,
          hintText: q.questionText,
          feedback: (val) {
            setStateCallback(() {
              q.answer = val;
            });
          },
          validator: (value) => null,
        ),
      );
    case 'radio':
    case 'radio_button':
      return RadioButtonWidget(
        padding:q.padding,
        label: q.questionText??'',
        options: q.options??[],
        selectedValue: q.answer ?? '',
        onChanged: (val) {
          setStateCallback(() {
            q.answer = val;
            // log('q.answer>>'+q.answer.toString());
          });
        },
      );
    case 'yes_no':
      // q.options = [Option(optionText:'Yes'),Option(optionText:'No')];
      return SingleChoice(
        options: q.options??[],
        title: q.questionText??'',
        selectedValue: q.answer,
        onChanged: (val) {
          setStateCallback(() {
            q.answer = (val as Option);
            print('q.answer1>>'+q.answer.toString());
          });
        },
      );
     case 'single_choice_grid':
      return SingleChoice(
        options: q.options??[],
        title: q.questionText??'',
        selectedValue: q.answer,
        onChanged: (val) {
          setStateCallback(() {
            q.answer = val;
          });
        },
      );
    case 'single_choice':
      return SingleChoice(
        options: q.options??[],
        title: q.questionText??'',
        selectedValue: q.answer,
        onChanged: (val) {
          setStateCallback(() {
            // q.answer = (val as Option).optionText;
            q.answer = (val as Option);
            // print('q.answer1>>'+q.answer.toString());
          });
        },
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(q.questionText??''),
          ...q.options!.map((option) => RadioListTile(
              title: Text(option.optionText??''),
              value: option,
              groupValue: q.answer,
              onChanged: (val) {
                setStateCallback(() {
                  q.answer = val;
                });
              },
            ),
          ),
        ],
      );

    case 'multi_select_doctor':
      return MultiSelectChoiceDoctor(
        options: q.options??[],
        title: q.questionText??'',
        selectedValue: q.answer,
        onChanged: (val) {
          setStateCallback(() {
            // q.answer = (val as Option).optionText;
            q.answer = val;
            // print('q.answer1>>'+q.answer.toString());
          });
        },
      );

    case 'multi_select':
      return MultiSelectChoice(
        title: q.questionText??'',
        // options: q.options?.map((option) => option.optionText??'').toList()??[],
        options: q.options??[],
        // selectedValues: (q.answer as List?)?.cast<String>() ?? [],
        selectedValues: (q.answer as List?)?.cast<Option>() ?? [],
        // selectedValues: q.answer ?? [],
        onChanged: (value) {
          setStateCallback(() {
            q.answer ??= [];
            q.answer.clear();
            q.answer.addAll(value);
          });
        },
      );
    case 'single_select':
      return SingleSelectChoice(
        title: q.questionText??'',
        options: q.options??[],
        selectedValues: q.answer ?? '',
        onChanged: (value) {
          setStateCallback(() {
            q.answer = value;
          });
        },
      );
    case 'tag':
    case 'tapped_text_field':
      return TagInputWidget(isTrue:q.isTrue,
        hint:q.hint??'',
        title: q.questionText??'',
        selectedValues: (q.answer as List?)?.cast<String>() ?? [],
        onAnswer:(value) {
          setStateCallback(() {
            q.isTrue = value;
            // print('object>>'+q.isTrue.toString());
          });
        },
        onChanged: (value) {
          setStateCallback(() {
            q.answer = List<String>.from(value);
          });
        },
      );
    case 'drop_down':
      return DropDownWidget(
        isTrue: q.isTrue,
        padding:q.padding,hint:q.hint??'اختر',
        title: q.questionText??'',
        showOtherFiled: q.showOtherFiled??false,
        showCheckbox: q.showCheckBoc??false,
        options: q.options??[],
        selectedValues: (q.answer as List?)?.cast<Option>() ?? [],
        // selectedValues: q.answer ?? [],
        onAnswer:(value) {
          setStateCallback(() {
            q.isTrue = value;
            // print('object>>'+q.isTrue.toString());
          });
        },
        onChanged: (value) {
          setStateCallback(() {
            q.answer = List<Option>.from(value);
            // print('q.answer>>'+q.answer.toString());
            // print('q.answer>>'+q.answer[0].id.toString());
            // print('q.answer>>'+q.answer[1].id.toString());
            // print('q.answer>>'+q.answer[2].id.toString());
            // print('q.answer>>'+q.answer[3].id.toString());
            // q.answer ??= [];
            // q.answer.clear();
            // q.answer.addAll(value);
          });
        },
      );
      // return DropDownWidget(
      //   options: q.options??[],
      //   selectedValues: (q.answer as List?)?.cast<String>() ?? [],
      //   onChanged: (value) {
      //     setStateCallback(() {
      //       q.answer = List<String>.from(value);
      //     });
      //   },
      // );
    default:
      return const SizedBox.shrink();
  }
}



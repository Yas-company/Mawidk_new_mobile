import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/bloc/static_survey_bloc.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_event.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/dynamic_question_widget.dart';

StaticSurveyBloc staticSurveyBloc = StaticSurveyBloc(surveyUseCase: getIt());
// class DropDownWidget extends StatefulWidget {
//   final List<Option> options;
//   final String title;
//   final String hint;
//   final bool showCheckbox;
//   final bool showOtherFiled;
//   final List<Option> selectedValues;
//   final ValueChanged<List<Option>> onChanged;
//
//   const DropDownWidget({
//     super.key,
//     required this.title,
//     required this.hint,
//     required this.options,
//     this.showCheckbox = false,
//     this.showOtherFiled = false,
//     required this.selectedValues,
//     required this.onChanged,
//   });
//
//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState();
// }
//
// class _DropDownWidgetState extends State<DropDownWidget> {
//   bool isEnabled = false;
//   List<Option> emptyOptions = [];
//   final TextEditingController _textController = TextEditingController();
//
//   void _setEnabled(bool value) {
//     setState(() {
//       isEnabled = value;
//       if (!isEnabled) {
//         widget.selectedValues.clear();
//       }
//       // Example: trigger logic if not a doctor
//       // isTrue = isEnabled;
//       // options = widget.selectedValues;
//       // staticSurveyBloc.add(ValidateSurveyEvent());
//     });
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.showCheckbox)
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     width: MediaQuery.sizeOf(context).width * .80,
//                     child: Text('have_diseases'.tr()),
//                   ),
//                 ),
//                 _buildToggleButton(true, Icons.check, 'Yes'),
//                 const SizedBox(width: 10),
//                 _buildToggleButton(false, Icons.clear, 'No'),
//               ],
//             ),
//           if (widget.showCheckbox) const SizedBox(height: 10),
//           Text(widget.title),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.white),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<Option>(
//                 menuMaxHeight: MediaQuery.sizeOf(context).height * 0.45,
//                 isExpanded: true,
//                 dropdownColor: Colors.white,
//                 hint: Text(widget.hint),
//                 value: null,
//                 onChanged: (Option? newValue) {
//                   if (widget.showCheckbox && !isEnabled) return;
//                   if (newValue == null) return;
//                   setState(() {
//                     if (!widget.selectedValues.contains(newValue)) {
//                       widget.selectedValues.add(newValue);
//                     }
//                   });
//                   widget.onChanged(widget.selectedValues);
//                 },
//                 items: ((widget.showCheckbox && !isEnabled)
//                     ? emptyOptions
//                     : widget.options)
//                     .map((Option value) {
//                   return DropdownMenuItem<Option>(
//                     value: value,
//                     enabled: !widget.selectedValues.contains(value),
//                     child: Text(
//                       value.optionText ?? '',
//                       style: TextStyle(
//                         color: widget.selectedValues.contains(value)
//                             ? Colors.grey
//                             : Colors.black,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//
//           /// 👇 Custom TextField + Add button
//           if(widget.showOtherFiled)const SizedBox(height: 10),
//           if(widget.showOtherFiled)Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _textController,
//                   decoration: InputDecoration(
//                     hintText: 'Add custom disease...',
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 10),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue, // Replace with AppColors.primaryColor
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.add, color: Colors.white),
//                   tooltip: 'Add',
//                   onPressed: () {
//                     final input = _textController.text.trim();
//                     if (input.isEmpty) return;
//
//                     bool exists = widget.selectedValues.any((opt) =>
//                     opt.optionText?.toLowerCase() == input.toLowerCase());
//
//                     if (!exists) {
//                       final newOption = Option(
//                         id: DateTime.now().millisecondsSinceEpoch,
//                         optionText: input,
//                         optionTextEn: input,
//                       );
//                       setState(() {
//                         widget.selectedValues.add(newOption);
//                         _textController.clear();
//                       });
//                       widget.onChanged(widget.selectedValues);
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 8,
//             runSpacing: 6,
//             children: widget.selectedValues.map((value) {
//               return Chip(
//                 label: Text(
//                   value.optionText ?? '',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 backgroundColor: Colors.blue.shade400, // AppColors.primaryColor2
//                 deleteIcon: const Icon(Icons.close, color: Colors.white),
//                 onDeleted: () {
//                   setState(() {
//                     widget.selectedValues.remove(value);
//                   });
//                   widget.onChanged(widget.selectedValues);
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 👇 Helper to build toggle buttons for Yes/No
//   Widget _buildToggleButton(bool value, IconData icon, String tooltip) {
//     final isSelected = isEnabled == value;
//     final color = isSelected ? Colors.blue : Colors.grey.shade200;
//     final borderColor = isSelected ? Colors.blue : Colors.grey.shade300;
//     return Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//         border: Border.all(color: borderColor),
//       ),
//       child: IconButton(
//         highlightColor: Colors.transparent,
//         padding: EdgeInsets.zero,
//         onPressed: () => _setEnabled(value),
//         icon: Icon(icon, color: Colors.white),
//         tooltip: tooltip,
//       ),
//     );
//   }
// }





class DropDownWidget extends StatefulWidget {
  final List<Option> options;
  final String title;
  final String hint;
  final bool? isTrue;
  final EdgeInsetsGeometry? padding;
  final bool showCheckbox;
  final bool showOtherFiled;
  final ValueChanged<bool>? onAnswer;
  final List<Option> selectedValues;
  final ValueChanged<List<Option>> onChanged;

  const DropDownWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.options,
    this.showCheckbox = false,
    this.padding,
    this.isTrue,
    this.showOtherFiled = false,
    required this.selectedValues,
    this.onAnswer,
    required this.onChanged,
  });

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
    List<Option> emptyOptions = [];
  final TextEditingController _textController = TextEditingController();
    late bool isEnabled =  widget.isTrue ?? false;
  // bool isEnabled = false;
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
      if(widget.onAnswer!=null){
      widget.onAnswer!(isEnabled);}
    });
  }
  @override
  Widget build(BuildContext context) {
    // print('showCheckBoc>>'+widget.showCheckbox.toString());
    return Padding(
      padding:widget.padding ?? const EdgeInsets.only(top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(widget.showCheckbox) Row(
            children: [
              Expanded(child: SizedBox(width:MediaQuery.sizeOf(context).width*.80,
                  child: PText(title:'have_diseases'.tr()))),
              Container(width: 40, height: 40,
                decoration:BoxDecoration(
                  color:widget.isTrue==null? AppColors.grey100 :(isEnabled ?
                  AppColors.primaryColor100 : AppColors.grey100),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color:widget.isTrue==null? AppColors.grey100 : (isEnabled ? AppColors.primaryColor : AppColors.grey100)
                  ),
                ),
                child: IconButton(highlightColor:Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () => _setEnabled(true),
                  icon:Icon(Icons.check, color:
                  widget.isTrue==null? AppColors.grey200 : (isEnabled ? AppColors.primaryColor : AppColors.grey200)),
                  tooltip: 'Yes',
                ),
              ),
              const SizedBox(width: 10),
              Container(width: 40, height: 40,
                decoration:BoxDecoration(
                  color: widget.isTrue==null? AppColors.grey100 : (!isEnabled ? AppColors.dangerColor100 : AppColors.grey100),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color:widget.isTrue==null? AppColors.grey100 : (!isEnabled ? AppColors.dangerColor : AppColors.grey100)
                  ),
                ),
                child: IconButton(
                  highlightColor:Colors.transparent,
                  onPressed: () => _setEnabled(false),
                  icon: Icon(Icons.clear, color:
                  widget.isTrue==null? AppColors.grey200 : (!isEnabled ? AppColors.dangerColor : AppColors.grey200)),
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

          /// 👇 Custom TextField + Add button
          if(widget.showOtherFiled)const SizedBox(height: 10),
          if(widget.showOtherFiled)Row(
            children: [
              Expanded(child:PTextField(enabled:isEnabled,controller:_textController,hintText:'add_other_disease'.tr(),
                labelAbove:'add_other_disease'.tr(),
                feedback:(value) {

              },disabledBorderColor:Colors.transparent,)),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top:20),
                child: GestureDetector(
                  onTap:() {
                    final input = _textController.text.trim();
                    if (input.isEmpty) return;

                    bool exists = widget.selectedValues.any((opt) =>
                    opt.optionText?.toLowerCase() == input.toLowerCase());

                    if (!exists) {
                      final newOption = Option(
                        id: DateTime.now().millisecondsSinceEpoch,
                        optionText: input,
                        optionTextEn: input,
                      );
                      setState(() {
                        widget.selectedValues.add(newOption);
                        _textController.clear();
                      });
                      widget.onChanged(widget.selectedValues);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),


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
















class DropDownWidgetOne extends StatefulWidget {
  final List<Option> options;
  final String title;
  final String hint;
  final bool showCheckbox;
  final Option? selectedValue;
  final ValueChanged<Option?> onChanged;

  const DropDownWidgetOne({
    super.key,
    required this.title,
    required this.hint,
    required this.options,
    this.showCheckbox = false,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<DropDownWidgetOne> createState() => DropDownWidgetOneState();
}

class DropDownWidgetOneState extends State<DropDownWidgetOne> {
  bool isEnabled = false;
  List<Option> emptyOptions = [];

  void _setEnabled(bool value) {
    setState(() {
      isEnabled = value;
      if (!isEnabled) {
        widget.onChanged(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showCheckbox)
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * .80,
                        child: PText(title: 'have_diseases'.tr()))),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (isEnabled
                        ? AppColors.primaryColor100
                        : AppColors.grey100),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: (isEnabled
                            ? AppColors.primaryColor
                            : AppColors.grey100)),
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () => _setEnabled(true),
                    icon: Icon(Icons.check,
                        color: (isEnabled
                            ? AppColors.primaryColor
                            : AppColors.grey200)),
                    tooltip: 'Yes',
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (!isEnabled
                        ? AppColors.dangerColor100
                        : AppColors.grey100),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: (!isEnabled
                            ? AppColors.dangerColor
                            : AppColors.grey100)),
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    onPressed: () => _setEnabled(false),
                    icon: Icon(Icons.clear,
                        color: (!isEnabled
                            ? AppColors.dangerColor
                            : AppColors.grey200)),
                    tooltip: 'No',
                  ),
                ),
              ],
            ),
          if (widget.showCheckbox) const SizedBox(height: 10),
          PText(
            title: widget.title,
            size: PSize.text14,
            fontColor: AppColors.fontColor,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.whiteColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Option>(
                menuMaxHeight: MediaQuery.sizeOf(context).height * 0.45,
                isExpanded: true,
                icon:Icon(Icons.keyboard_arrow_down,color:AppColors.grey200,),
                dropdownColor: AppColors.whiteColor,
                hint: PText(title: widget.hint,fontColor: AppColors.grey200,),
                value: widget.selectedValue ,
                onChanged: (Option? newValue) {
                  // if (widget.showCheckbox && !isEnabled) return;
                  widget.onChanged(newValue);
                },
                items: ((widget.showCheckbox && !isEnabled)
                    ? emptyOptions
                    : widget.options)
                    .map((Option value) {
                  return DropdownMenuItem<Option>(
                    value: value,
                    child: PText(
                      title: value.optionText ?? '',
                      fontColor: Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

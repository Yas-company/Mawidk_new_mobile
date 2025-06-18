import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';


class TextWithCheck extends StatefulWidget {
  final String hint;
  final String title;
  bool? isTrue;
  String? answer;
  final ValueChanged<String> onAnswer;

   TextWithCheck({
    super.key,this.answer,
    required this.title,
    required this.hint,
    required this.isTrue,
    required this.onAnswer,
  });

  @override
  State<TextWithCheck> createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TextWithCheck> {
  late final TextEditingController _controller = TextEditingController(text:widget.answer??'');
  List<String> items = [];
  late bool isEnabled =  false;

  @override
  void initState() {
    super.initState();
  }

  void _setEnabled(bool value) {
    setState(() {
      isEnabled = value;
      widget.isTrue = isEnabled;
      if (!isEnabled) {
        items.clear();
        _controller.clear();
      }
      widget.onAnswer(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: SizedBox(width:MediaQuery.sizeOf(context).width*.80,
                  child: PText(title: widget.title))),
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
                      color:(!isEnabled ? AppColors.dangerColor : AppColors.grey100)
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(top:0),
            child: PTextField(enabled:isEnabled,
              disabledBorderColor:Colors.transparent,
              enabledInputBorder:OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor,),
                borderRadius: BorderRadius.all(Radius.circular(8),),
              ),
              errorBorderColor:AppColors.primaryColor,
              controller: TextEditingController(text: widget.answer)
                ..selection = TextSelection.collapsed(offset: widget.answer?.length ?? 0),
              hintText:widget.title,
              feedback: (val) {
                setState(() {
                  widget.answer = val;
                  print('q.answer>>'+widget.answer.toString());
                });
              },
              validator: (value) => null,
            ),
          ),
        ],
      ),
    );
  }
}

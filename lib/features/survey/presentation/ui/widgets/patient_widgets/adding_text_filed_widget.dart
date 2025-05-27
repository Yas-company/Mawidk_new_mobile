import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';


class TagInputWidget extends StatefulWidget {
  final String hint;
  final String title;
  final bool? isTrue;
  final List<String>? selectedValues;
  final ValueChanged<List<String>> onChanged;
  final ValueChanged<bool> onAnswer;

  const TagInputWidget({
    super.key,this.selectedValues,
    required this.title,
    required this.hint,
    required this.onChanged,
    required this.isTrue,
    required this.onAnswer,
  });

  @override
  State<TagInputWidget> createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInputWidget> {
  final TextEditingController _controller = TextEditingController();
  List<String> items = [];
  // late bool isEnabled =  (widget.selectedValues??[]).isNotEmpty;
  late bool isEnabled =  widget.isTrue ?? false;

  @override
  void initState() {
    super.initState();
    print('object>>'+widget.isTrue.toString());
    items = List<String>.from(widget.selectedValues ?? []);
  }

  void _addItem() {
    String text = _controller.text.trim();
    if (text.isNotEmpty && !items.contains(text)) {
      setState(() {
        items.add(text);
        _controller.clear();
        widget.onChanged(items); // notify parent
      });
    }
  }

  void _removeItem(String item) {
    setState(() {
      items.remove(item);
      widget.onChanged(items); // notify parent
    });
  }

  void _setEnabled(bool value) {
    setState(() {
      isEnabled = value;
      if (!isEnabled) {
        items.clear();
        _controller.clear();
        widget.onChanged(items);
      }
      widget.onAnswer(isEnabled);
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
                  color:widget.isTrue==null? AppColors.grey100 :(isEnabled ? AppColors.primaryColor100 : AppColors.grey100),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color:widget.isTrue==null? AppColors.grey100 : (isEnabled ? AppColors.primaryColor : AppColors.grey100)
                  ),
                ),
                child: IconButton(highlightColor:Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () => _setEnabled(true),
                  icon: Icon(Icons.check, color:
                  widget.isTrue==null? AppColors.grey200 : (isEnabled ? AppColors.primaryColor : AppColors.grey200)),
                  tooltip: 'Yes',
                ),
              ),
              const SizedBox(width: 10),
              Container(width: 40, height: 40,
                decoration: BoxDecoration(
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
          const SizedBox(height: 12),
          PTextField(enabled:isEnabled,controller:_controller,hintText:widget.hint, feedback:(value) {

          }, validator:(value) => null,onFieldSubmitted:(value) {
            _addItem();
          },suffixIcon:InkWell(onTap:() {
              _addItem();
            },child: Container(
                margin:EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  color:(isEnabled ? AppColors.primaryColor : AppColors.grey200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add,size:18,color:
                 (isEnabled ? AppColors.whiteBackground : AppColors.whiteColor),),
              ),
            ),borderRadius:12,disabledBorderColor:AppColors.grey100,
            errorBorderColor:AppColors.primaryColor,
            enabledInputBorder:OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor,),
              borderRadius: BorderRadius.all(Radius.circular(8),),
            ),
          ),
          const SizedBox(height:8),
          if (items.isNotEmpty)
            Wrap(
              spacing: 8, runSpacing: 8,
              children: items.map((item) {
                return Chip(backgroundColor:AppColors.primaryColor2,
                  padding:EdgeInsets.zero,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  label:PText(title:item,fontColor:AppColors.whiteColor,size:PSize.text14,
                  ),
                  deleteIcon: const Icon(Icons.close,color:AppColors.whiteColor,),
                  onDeleted: () => _removeItem(item),
                );
              }).toList(),
            ),
          Divider(color:AppColors.grey100,)
        ],
      ),
    );
  }
}

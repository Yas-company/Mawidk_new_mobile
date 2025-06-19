import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import '../../data/constants/app_colors.dart';
import '../text/p_text.dart';

class PDropDown extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final TextEditingController? controller;
  final Map<String, dynamic>? initialValue;
  final String? label;
  final String? keyValue;
  final String? dropdownLabel;
  final String? hintText;
  final Color? dropdownLabelColor;
  final Color? borderColor ;
  final Color? fillColor ;
  final bool? isOptional;
  final bool isSpecializations;
  final bool enableSearch;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isEnabled;
  final ValueChanged<Map<String, dynamic>?>? onChange;
  final FocusNode? focusNode;
  final bool translate;
  final Map<String, dynamic>? defaultResetOption;

  const PDropDown({
    super.key,
    required this.options,
    this.controller,
    this.fillColor,
    this.initialValue,
    this.borderRadius,
    this.borderColor,
    this.isSpecializations = false,
    this.dropdownLabel,
    this.dropdownLabelColor,
    this.hintText,
    this.onChange,
    this.label,
    this.keyValue,
    this.width,
    this.isEnabled = true,
    this.height,
    this.isOptional = false,
    this.enableSearch = false,
    this.focusNode,
    this.translate = false,
    this.defaultResetOption,
  });

  @override
  State<PDropDown> createState() => _MyCustomDropDownState();
}

class _MyCustomDropDownState extends State<PDropDown> {
  late final TextEditingController _controller;
  final List<Map<String, dynamic>> options = [];

  @override
  void initState() {
    if (widget.defaultResetOption != null) {
      options.add(widget.defaultResetOption!);
    }
    options.addAll(widget.options);
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.isSpecializations ?
      widget.initialValue![widget.keyValue]:widget.initialValue!["label"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                PText(
                  title: widget.label!.tr(),
                  size: PSize.text14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(width: 10),
                if (widget.isOptional!)
                  Text("(optional)".tr(),
                      style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              color:widget.fillColor ?? AppColors.whiteColor,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              border:Border.all(color: widget.borderColor ??  Colors.transparent),
            ),
            child: DropdownButtonFormField<Map<String, dynamic>>(
              value:widget.initialValue,style:TextStyle(fontFamily:'Cairo',
            color:AppColors.blackColor),
              // value: options.firstWhere(
              //       (option) => option["value"] == _controller.text,
              //   orElse: () => widget.initialValue ?? options.first,
              // ),
              isExpanded: true,iconEnabledColor: AppColors.grey200,
              decoration: InputDecoration(labelStyle: TextStyle(fontFamily:'Cairo'),
                hintText: widget.hintText?.tr() ?? 'select'.tr(),
                hintStyle:TextStyle(fontFamily:'Cairo'),
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide:BorderSide(
                    color: AppColors.whiteColor, width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: AppColors.whiteColor, width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.whiteColor, width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.only(left:12,right:12,top:10,bottom:22),
              ),
              menuMaxHeight:MediaQuery.sizeOf(context).height*0.45,
              dropdownColor: AppColors.whiteBackground,
              icon:Icon(Icons.keyboard_arrow_down_rounded,color:widget.borderColor!=null?Colors.black:null),
              selectedItemBuilder: (context) {
                return options.map((option) {
                  final title = widget.translate
                      ? option["label"].toString().tr()
                      : widget.isSpecializations
                      ? option[widget.keyValue].toString()
                      : option["label"].toString();
                  return PText(title: title);
                }).toList();
              },
              items: options.map((option) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: option,
                  child: PText(title:
                    widget.translate ? option["label"].toString().tr() :
                    widget.isSpecializations?option[widget.keyValue].toString():option["label"].toString(),
                    fontColor:_controller.text == option[widget.keyValue]?
                    AppColors.blackColor:AppColors.grey200,
                  ),
                );
              }).toList(),
              onChanged: widget.isEnabled ? (value) {
                setState(() {
                  _controller.text = widget.isSpecializations?(value?[widget.keyValue]):(value?["label"]);
                });
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
              }
                  : null,
            )


          ),
        ),
      ],
    );
  }
}

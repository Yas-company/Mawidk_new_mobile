import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class SearchWidget extends StatelessWidget {
  final bool hasFilter;
  final bool isEnabled;
  final String? hint;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final void Function(String?)? onFieldSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onTapFilter;
  final Function(String)? onChanged;
  const SearchWidget({super.key,this.hasFilter=true,this.hint,this.onTap,this.isEnabled=true,
    this.controller,this.onChanged,this.textInputAction,this.onFieldSubmitted,this.onTapFilter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap,
      child: PTextField(controller:controller,enabled: isEnabled,
        onFieldSubmitted:onFieldSubmitted,
        borderRadius:20,textInputAction:textInputAction,
        contentPadding:EdgeInsets.symmetric(vertical:15),
        prefixIcon:PImage(source:AppSvgIcons.icSearch,height:10,width:10,fit:BoxFit.scaleDown ),
        suffixIcon:hasFilter?InkWell(onTap:onTapFilter,
          child: Padding(
            padding: const EdgeInsets.only(left:12,top:4,bottom:4),
            child: Container(padding:EdgeInsets.symmetric(horizontal:10),
                decoration:BoxDecoration(
                  color:AppColors.background,
                  borderRadius:BorderRadius.circular(16)
                ),
                child: PImage(source:AppSvgIcons.icFilter,height:24,width:20,fit:BoxFit.contain,)),
          ),
        ):null,
        fillColor:Colors.white,hintText:hint ?? 'search_by_name'.tr(), feedback:(value) {
        if(onChanged!=null){onChanged!(value??'');}
      },),
    );
  }
}
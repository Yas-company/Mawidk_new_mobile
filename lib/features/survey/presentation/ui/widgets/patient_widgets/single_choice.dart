import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';


class SingleChoice extends StatelessWidget {
  final String title;
  final List<Option> options;
  final dynamic selectedValue;
  final ValueChanged<dynamic>? onChanged;
  const SingleChoice({super.key,required this.options,required this.title,this.onChanged,
    this.selectedValue,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:14),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
        PText(title:title,size:PSize.text14,fontColor:AppColors.fontColor,),
        const SizedBox(height:8,),
        (options.first.optionText=='انثي'||options.first.optionText.toString().contains('أنثى')
            ||options.first.optionText=='ذكر')?
        Wrap(
          spacing: 10, runSpacing: 10,
          children: options.map((item) {
            final isSelected = item.optionText == (selectedValue is Option
                ? (selectedValue as Option).optionText
                : selectedValue);
            // final isSelected = item.optionText == (selectedValue as Option).optionText;
            return InkWell(splashColor:Colors.transparent,
              focusColor:Colors.transparent,
              highlightColor:Colors.transparent,
              hoverColor:Colors.transparent,
              onTap: () {
                onChanged?.call(item);
              },child: Container(
                padding: const EdgeInsets.symmetric(vertical:10, horizontal:28),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor100 : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    if(item.optionText=='ذكر')Padding(
                      padding: const EdgeInsets.only(bottom:4),
                      child: PImage(source:AppIcons.male,),
                    ),
                    if(item.optionText=='انثي'||item.optionText.toString().contains('أنثى'))Padding(
                      padding: const EdgeInsets.only(bottom:4),
                      child: PImage(source:AppIcons.female,),
                    ),
                    PText(
                      title: item.optionText??'',
                      size: PSize.text14,
                      fontWeight:(item.optionText=='انثي'||item.optionText.toString().contains('أنثى')
                          ||item.optionText=='ذكر')?FontWeight.w600:FontWeight.w400,
                      fontColor:(item.optionText=='انثي'||item.optionText.toString().contains('أنثى')
                          ||item.optionText=='ذكر')?
                      AppColors.fontColor:
                      (isSelected? AppColors.fontColor:AppColors.grey200),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ):GridView.count(
          crossAxisCount: 3,padding: EdgeInsets.only(top:2),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          mainAxisSpacing: 12,
          crossAxisSpacing: 14,
          childAspectRatio: 2,
          children: options.map((item) {
            final isSelected = item.optionText == (selectedValue is Option
                ? (selectedValue as Option).optionText
                : selectedValue);

            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                onChanged?.call(item);
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor100
                      : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.optionText == 'ذكر')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: PImage(source: AppIcons.male),
                      ),
                    if (item.optionText == 'انثي' ||
                        item.optionText.toString().contains('أنثى'))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: PImage(source: AppIcons.female),
                      ),
                    PText(
                      title: item.optionText ?? '',
                      size: PSize.text14,
                      fontWeight: (item.optionText == 'انثي' ||
                          item.optionText.toString().contains('أنثى') ||
                          item.optionText == 'ذكر')
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontColor: (item.optionText == 'انثي' ||
                          item.optionText.toString().contains('أنثى') ||
                          item.optionText == 'ذكر')
                          ? AppColors.fontColor
                          : (isSelected
                          ? AppColors.fontColor
                          : AppColors.grey200),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        // GridView.count(
        //   crossAxisCount: 2, // Number of columns
        //   physics:NeverScrollableScrollPhysics(),
        //   padding: const EdgeInsets.all(10),
        //   crossAxisSpacing: 10, shrinkWrap: true,
        //   mainAxisSpacing: 10,
        //   children: options.map((item) {
        //     return InkWell(onTap:() {
        //       onChanged!(item);
        //     },child: Container(
        //         decoration: BoxDecoration(
        //           color:AppColors.grey100,
        //           borderRadius: BorderRadius.circular(16),
        //         ),
        //         alignment: Alignment.center,
        //         child:PText(title:item,size:PSize.text12,fontColor:AppColors.fontColor,)
        //       ),
        //     );
        //   }).toList(),
        // )
      ],),
    );
  }
}




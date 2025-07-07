import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class ManageServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ManageServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:EdgeInsets.symmetric(vertical:7),
      color:AppColors.primaryColor550,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.primaryColor3300),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:12,vertical:18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 21,
              backgroundColor:AppColors.primaryColor3300,
              child: PImage(source: icon,color:AppColors.primaryColor,),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText(title:title,fontWeight:FontWeight.w500,size:PSize.text14,fontColor:AppColors.grayShade3,),
                  const SizedBox(height: 4),
                  PText(title:description,fontWeight:FontWeight.w500,size:PSize.text12,fontColor:AppColors.grey200,),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SmallCustomSwitch(
              value: isActive,
              onChanged: onChanged,
            ),
            const SizedBox(width:12),
            PImage(source:AppSvgIcons.icArrow,color: AppColors.primaryColor,)
          ],
        ),
      ),
    );
  }
}


class SmallCustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SmallCustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 35, // smaller width
        height:19, // smaller height
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: value ? AppColors.whiteBackground : AppColors.primaryColor,
            border:Border.all(color:!value?AppColors.primaryColor:AppColors.primaryColor,
            width: 1.5)
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(margin:EdgeInsets.symmetric(horizontal:4),
            width: 12, height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? AppColors.whiteColor : AppColors.whiteBackground,
              border:Border.all(color:!value?AppColors.whiteBackground:AppColors.primaryColor,
                  width: 1.5)
            ),
          ),
        ),
      ),
    );
  }
}

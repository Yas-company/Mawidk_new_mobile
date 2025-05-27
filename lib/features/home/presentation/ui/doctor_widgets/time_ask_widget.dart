import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class TimeAskCard extends StatelessWidget {
  final String title;
  final String image;
  final int value;
  final bool isActive;
  final VoidCallback onTap;

  const TimeAskCard({
    super.key,
    required this.title,
    this.isActive= true,
    required this.image,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color:isActive? AppColors.primaryColor550:AppColors.primaryColor550UnActive,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.primaryColor3300),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor:isActive?AppColors.primaryColor3300:AppColors.primaryColor3300.withOpacity(0.3),
                child: PImage(source: image, color:isActive? AppColors.primaryColor:AppColors.primaryColor.withOpacity(0.3)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                child: PText(title: title.tr(), fontWeight: FontWeight.w500, size: PSize.text14,
                fontColor:isActive?AppColors.blackColor:AppColors.grey200,),
              ),
              if(isActive)Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: PText(
                  title: value.toString(),
                  fontWeight: FontWeight.w700,
                  size: PSize.text18,
                  fontColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

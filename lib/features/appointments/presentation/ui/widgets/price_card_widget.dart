import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class PriceCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final int value;
  final VoidCallback onTap;
  final bool isSelected;

  const PriceCardWidget({
    super.key,
    required this.title,
    required this.image,
    required this.value,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? AppColors.primaryColor3300 : AppColors.primaryColor550,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: isSelected
                  ? AppColors.primaryColor3300
                  : AppColors.primaryColor3300),
        ),
        elevation: isSelected ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PImage(source: image, color: AppColors.primaryColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                child: PText(
                  title: title.tr(),
                  fontWeight: FontWeight.w500,
                  size: PSize.text14,
                  fontColor: AppColors.grayShade3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    PText(
                      title: value == 0 ? 'free'.tr() : value.toString(),
                      fontWeight: FontWeight.w700,
                      size: PSize.text18,
                      fontColor: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: PText(
                        title: value == 0
                            ? 'for_three_days'.tr()
                            : 'sar'.tr(),
                        size: PSize.text9,
                        fontColor:AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


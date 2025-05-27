import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class PatientsStatisticsCard extends StatelessWidget {
  final String title;
  final String image;
  final String value;
  final VoidCallback onTap;

  const PatientsStatisticsCard({
    super.key,
    required this.title,
    required this.image,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryColor1100,
              child: PImage(source: image, color: AppColors.primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: PText(
                title: title,
                fontColor: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            PText(
              title: value,
              fontColor: AppColors.grey200,
              fontWeight: FontWeight.w400,
              size: PSize.text12,
            ),
          ],
        ),
      ),
    );
  }
}

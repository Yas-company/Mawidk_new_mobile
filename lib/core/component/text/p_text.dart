import 'package:flutter/material.dart';
import 'package:mawidak/core/data/app_dimensions/app_dimensions.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class PText extends StatelessWidget {
  final String title;
  final PSize? size;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignText;
  final TextDirection? textDirection;
  const PText({
    super.key,
    required this.title,
    this.size,
    this.fontColor,
    this.fontWeight = FontWeight.w600,
    this.overflow,
    this.maxLines,
    this.decoration = TextDecoration.none,
    this.alignText,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            title,
            textDirection: textDirection,
            textAlign: alignText ?? TextAlign.start,
            style: TextStyle(
              fontWeight: fontWeight,
              color: fontColor,
              decorationColor:AppColors.blackColor,
              decorationThickness: 2.0,     // Optional
              height: 1.3,fontFamily:'cairo',
              fontSize: textSize,
              letterSpacing: -0.02,
              decoration: decoration,
              overflow: overflow,
            ),
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }

  double get textSize {
    switch (size) {
      case PSize.text9:
        return AppDimensions.text9;
      case PSize.text12:
        return AppDimensions.text12;
      case PSize.text13:
        return AppDimensions.text13;
      case PSize.text14:
        return AppDimensions.text14;
      case PSize.text16:
        return AppDimensions.text16;
      case PSize.text17:
        return AppDimensions.text17;
      case PSize.text18:
        return AppDimensions.text18;
      case PSize.text20:
        return AppDimensions.text20;
      case PSize.text24:
        return AppDimensions.text24;
      case PSize.text28:
        return AppDimensions.text28;
      case PSize.text30:
        return AppDimensions.text30;
      default:
        return AppDimensions.text16;
    }
  }
}

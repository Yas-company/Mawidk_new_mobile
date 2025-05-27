import 'package:flutter/material.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';

Widget customLoader({double? size}) {
  return  CustomLoader(
    loadingShape: LoadingShape.fadingCircle,
    color:AppColors.primaryColor,
    // color: isDark?AppColors.whiteColor:AppColors.primaryColor,
    size: 50,
  );
}

Decoration commonDecoration({
  Color? color,
  Gradient? gradient,
  Color shadowColor = Colors.transparent,
  double spreadRadius = 5,
  double blurRadius = 0,
  Offset offset = const Offset(0, 4),
  Color? borderColor,
  double borderRadius = 4.0,
}) {
  return BoxDecoration(
    color:
        color ?? (isDark ? Colors.white : Colors.white),
    gradient:gradient,
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: offset,
      ),
    ],
    border: Border.all(
        color: borderColor ??
            (isDark ? Colors.white : AppColors.grayColor200)),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

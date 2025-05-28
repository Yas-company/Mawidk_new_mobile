import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/core/services/log/app_log.dart';
import 'package:skeletonizer/skeletonizer.dart';

AppBar appBar({
  String? text,
  String? description,
  String? avatarUrl,
  Color? backgroundColor,
  double? horizontalPadding,
  double? height,
  bool isCenter = false,
  bool hasBloc = false,
  bool backBtn = true,
  required BuildContext context,
  List<Widget>? actions,
  // UserHeaderBloc? userHeaderBloc,
  refreshCheck = true,
  double? elevation,
  // Widget? titleWidget,
}) {
  // UserHeaderBloc userHeaderBloc = UserHeaderBloc(homeUseCase: getIt());
  return AppBar(
    centerTitle: isCenter,
    titleSpacing: 0,
    scrolledUnderElevation:0,
    bottomOpacity: 0,
    toolbarHeight: height ?? 90,
    backgroundColor:backgroundColor ?? AppColors.whiteBackground,
    shadowColor: backgroundColor ?? AppColors.whiteBackground,
    elevation: elevation ?? 0,
    title: Padding(
      padding: EdgeInsets.only(
        top: 16.0, left: 60,
        right: horizontalPadding ?? 10,
      ),
      // padding: EdgeInsets.symmetric(horizontal:horizontalPadding??16),
      child:Row(mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: isCenter?MainAxisAlignment.center:MainAxisAlignment.start,
        children: [
          if((actions??[]).isNotEmpty)const SizedBox(width:40,),
          if (!hasBloc) ...[
            if (avatarUrl != null)
              PImage(
                source: avatarUrl,
                height: 40,
                width: 40,
                isCircle: true,
              ),
            if (avatarUrl != null)
              const SizedBox(width: 10,),
            if (text != null)
              Flexible(
                child: PText(
                      title: text,
                      size: PSize.text18,
                      // fontColor: AppColors.titleColor,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
          ]
        ],
      ),
    ),
    // leadingWidth: 50,
    leading: backBtn ? InkWell(hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,onTap:() {
            if (Navigator.canPop(context)) {
              // Navigator.pop(context, refreshCheck);
              Navigator.pop(context);
            } else {
              AppLog.logValue('No pages left to pop.');
            }
    },child: Container(margin:EdgeInsets.only(top:20,right:isArabic()?10:0,left:!isArabic()?10:0),
          width:40,height: 40,
          child:Center(
            child: PImage(source:isArabic()?AppSvgIcons.icBack:AppSvgIcons.icNotification,
            color:AppColors.grayShade3),
          )),
    ):null,
    //     ? Padding(
    //   padding: const EdgeInsets.only(right: 10),
    //   child: GestureDetector(
    //     onTap: () {
    //       if (Navigator.canPop(context)) {
    //         // Navigator.pop(context, refreshCheck);
    //         Navigator.pop(context);
    //       } else {
    //         AppLog.logValue('No pages left to pop.');
    //       }
    //     },
    //     child: Container(
    //       margin: const EdgeInsets.only(right: 0, top: 20),
    //       child: Center(
    //           child:PImage(source:isArabic()?AppSvgIcons.icBack:AppSvgIcons.icNotification,
    //             color:AppColors.grayShade3,)),
    //     ),
    //   ),
    // ) : null,
    // backBtn
    //     ? Padding(
    //       padding: const EdgeInsets.only(top:20,right:10),
    //       child: IconButton(splashColor:Colors.transparent,
    //           // padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16),
    //           onPressed: () {
    //             if (Navigator.canPop(context)) {
    //               Navigator.pop(context, refreshCheck);
    //             } else {
    //               AppLog.logValue('No pages left to pop.');
    //             }
    //           },
    //           icon: const Icon(Icons.arrow_back_sharp, color: AppColors.titleColor)),
    //     )
    //     : null,
    actions: actions,
  );
}

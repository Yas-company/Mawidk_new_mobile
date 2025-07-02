import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/localization/app_localization.dart';
import 'dart:ui' as direction;

void showLanguageBottomSheet(BuildContext context) {
  Locale locale = context.locale;
  showModalBottomSheet(
    context:context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return StatefulBuilder(builder:(context, setState) {
        return Directionality(textDirection:isArabic()?direction.TextDirection.ltr:direction.TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PText(title:'choose_language'.tr(),size:PSize.text14,fontColor:AppColors.grey200,),
                const SizedBox(height: 20),
                Directionality(textDirection:direction.TextDirection.rtl,
                  child:Column(mainAxisSize: MainAxisSize.min,children: [
                    InkWell(splashColor:Colors.transparent,
                      focusColor:Colors.transparent,
                      highlightColor:Colors.transparent,
                      hoverColor:Colors.transparent,onTap:() {
                      setState(() {
                        locale = AppLocalization.getSupportedLocales[1];
                      });
                    },child: Row(children: [
                      Container(
                          width:21, height:21,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:locale==AppLocalization.getSupportedLocales[1]
                                  ?AppColors.primaryColor:AppColors.grey200,
                              width:locale==AppLocalization.getSupportedLocales[1]?5:2,),)
                      ),
                      const SizedBox(width:10,),
                      PText(title:'اللغة العربية',fontColor:locale==AppLocalization.getSupportedLocales[1]?
                      AppColors.blackColor:AppColors.grey200),
                      Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top:6),
                          child: Text(
                            '🇸🇦',
                            style: TextStyle(fontSize:40),
                          ),
                        )
                        // PText(title:'🇸🇦',size:PSize.text30,),
                      // PImage(source:AppIcons.arabic)
                    ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10),
                      child: Divider(color:AppColors.grey100,),
                    ),
                    InkWell(splashColor:Colors.transparent,
                      focusColor:Colors.transparent,
                      highlightColor:Colors.transparent,
                      hoverColor:Colors.transparent,onTap:() {
                      setState(() {
                        locale = AppLocalization.getSupportedLocales[0];
                      });
                    },child: Row(children: [
                      Container(
                          width:21, height:21,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:locale==AppLocalization.getSupportedLocales[0]
                                  ?AppColors.primaryColor:AppColors.grey200,
                              width:locale==AppLocalization.getSupportedLocales[0]?5:3,),)
                      ),
                      const SizedBox(width:10,),
                      PText(title:'English',fontColor:locale==AppLocalization.getSupportedLocales[0] ?
                      AppColors.blackColor:AppColors.grey200,),
                      Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top:6),
                          child: Text(
                            '🇺🇸',
                            style: TextStyle(fontSize:40),
                          ),
                        )
                        // PText(title:'🇺🇸',size:PSize.text30,),
                      // PImage(source:AppIcons.english)
                    ],),
                    ),
                  ],),
                ),
                const SizedBox(height:24,),
                PButton(onPressed:() async {
                  Navigator.pop(context);
                  await context.setLocale(locale);
                },title:'save'.tr(),hasBloc:false,isFitWidth:true,)
              ],
            ),
          ),
        );
      },);
    },
  );
}
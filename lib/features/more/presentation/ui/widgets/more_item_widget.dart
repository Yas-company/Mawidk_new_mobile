import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';

class MoreItemWidget extends StatelessWidget {
  final String title;
  final String  leftIcon;
  final String  rightIcon;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final bool isNotification;
  final double? height;
  final Color? rightIconColor;
  const MoreItemWidget({super.key,required this.title,required this.rightIcon,required this.leftIcon,
  this.onTap,this.width,this.height,this.rightIconColor,this.padding,this.isNotification=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,onTap: onTap,
      child: Container(padding:EdgeInsets.only(top:4,bottom:4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
          Padding(
            padding:padding??EdgeInsets.zero,
            child: PImage(source:rightIcon,width:width,height:height,color:
            rightIconColor ?? AppColors.primaryColor,),
          ),
          const SizedBox(width:12,),
          PText(title: title,fontWeight:FontWeight.w400,),
          Spacer(),
          isNotification ? Transform.scale(
            scale: 0.6,
            alignment: Alignment.centerLeft,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                height: 24,
                child: Switch(
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: SharedPreferenceService()
                      .getBool(SharPrefConstants.isNotificationOnline),
                  onChanged: (value) async {
                    await SharedPreferenceService().setBool(
                        SharPrefConstants.isNotificationOnline,
                        !SharedPreferenceService()
                            .getBool(SharPrefConstants.isNotificationOnline));
                    onTap!();
                  },
                  inactiveThumbColor: AppColors.primaryColor,
                  inactiveTrackColor: AppColors.primaryColor3300,
                  activeColor: AppColors.whiteColor,
                  trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                    return Colors.transparent;
                  }),
                  activeTrackColor: AppColors.grey200,
                ),
              ),
            ),
          ): (isArabic()?Padding(
            padding: const EdgeInsets.only(left:3),
            child: PImage(source:leftIcon,width:9,height:17,),
          ):
          Icon(Icons.arrow_forward_ios_sharp,color:AppColors.grey200,))
        ],),
      ),
    );
  }
}

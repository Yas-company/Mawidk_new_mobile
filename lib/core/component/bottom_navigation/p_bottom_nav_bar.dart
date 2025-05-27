import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/bottom_navigation/bottom_nav_item.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/data/app_dimensions/app_dimensions.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/global_func.dart';

class PBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: SizedBox(height:80,
        child: BottomNavigationBar(backgroundColor:Colors.white,
          currentIndex: currentIndex,
          // backgroundColor: Colors.white,
          elevation: 6,
          onTap: (value) => onTap(value),
          type: BottomNavigationBarType.fixed,
          mouseCursor: SystemMouseCursors.click,
          enableFeedback: false,
          selectedItemColor: isDarkContext(context)
              ? AppColors.primaryColor
              : AppColors.blackColor,
          selectedLabelStyle: TextStyle(
            fontSize: AppDimensions.text13,
            fontFamily: 'Cairo',fontWeight: FontWeight.w600,
            color: isDarkContext(context)
                ? AppColors.primaryColor
                : AppColors.primaryColor,
            height: 1.4,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: AppDimensions.text13,
            fontFamily: 'Cairo',color:AppColors.grey200,
            height: 1.4,
          ),

          items: items.mapIndexed((index, item) {
            return BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: (index == currentIndex && index == 2)?
                  PImage(
                    source:isDoctor()?AppSvgIcons.icPatientsColored:AppSvgIcons.coloredHeart,
                    width: 20, height: 20,
                    color:AppColors.primaryColor,
                  ):PImage(
                    source: item.icon,
                    width: 22, height: 22,
                    color: index == currentIndex
                        ? (isDarkContext(context)
                        ? AppColors.primaryColor
                        : AppColors.primaryColor)
                        : AppColors.grey200,
                  ),
                ),
                label: item.label.tr());
          }).toList(),
        ),
      ),
    );
    // final screenWidth = MediaQuery.of(context).size.width;
    // return Stack(
    //   children: [
    //
    //     // AnimatedPositioned(
    //     //   duration: const Duration(milliseconds: 100),
    //     //   curve: Curves.easeInOut,
    //     //   left: context.locale.languageCode == 'en'
    //     //       ? currentIndex * (screenWidth / 4)
    //     //       : null,
    //     //   right: context.locale.languageCode == 'ar'
    //     //       ? currentIndex * (screenWidth / 4)
    //     //       : null,
    //     //   child: Container(
    //     //       width: screenWidth / 3,
    //     //       height: 1.4,
    //     //       color: isDarkContext(context)
    //     //           ? AppColors.primaryColor
    //     //           : AppColors.primaryColor),
    //     // ),
    //   ],
    // );
  }
}

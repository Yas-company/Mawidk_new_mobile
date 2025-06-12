import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/bottom_navigation/bottom_nav_item.dart';
import 'package:mawidak/core/component/bottom_navigation/p_bottom_nav_bar.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/parent_screen/parent_screen.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  final StatefulNavigationShell navigationShell;
  CustomBottomNavigation(
      {super.key, required this.index, required this.navigationShell});
  final List<BottomNavItem> _navItems = [
    const BottomNavItem(
      icon: AppSvgIcons.icHome,
      redirect: AppRouter.homePatient,
      label: 'home',
    ),
    const BottomNavItem(
      icon: AppSvgIcons.icCalendar,
      redirect: AppRouter.appointments,
      label: 'times',
    ),

    if(isDoctor())const BottomNavItem(
        icon: AppSvgIcons.icPatients,
        redirect: AppRouter.patients,
        label: 'patients'),

    if(!isDoctor())const BottomNavItem(
      icon: AppSvgIcons.fav_heart,
      redirect: AppRouter.more,
      label: 'favourite',
    ),

    const BottomNavItem(
        icon: AppSvgIcons.icProfile,
        redirect: AppRouter.profile,
        label: 'profile'),
    // const BottomNavItem(
    //   icon: AppSvgIcons.icMore,
    //   redirect: AppRouter.more,
    //   label: 'more',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return PBottomNavBar(
      items: _navItems,
      currentIndex: indexNotifier.value,
      onTap: (value) {
        moveTo(context, value);
      },
    );
  }

  void moveTo(BuildContext context, int index) {
    print('index>>'+index.toString());
    indexNotifier.value = index;
    if(isDoctor()){
      if(index ==0){
        navigationShell.goBranch(0);
      }else if(index ==1){
        navigationShell.goBranch(2);
      }else if(index == 2){
        navigationShell.goBranch(3);
      }else if(index == 3){
        navigationShell.goBranch(5);
      }
    }else{
      if(index ==0){
        navigationShell.goBranch(1);
      }else if(index ==1){
        navigationShell.goBranch(6);
      }else if(index == 2){
        navigationShell.goBranch(4);
      }else if(index == 3){
        navigationShell.goBranch(5);
      }
    }
    // navigationShell.goBranch(index);
    // indexNotifier.value = index;
    // context.go(_navItems[index].redirect);
  }
}

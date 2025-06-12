import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/features/home/presentation/ui/page/home_screen_doctor.dart';
import 'package:mawidak/features/parent_screen/parent_bottom_nav.dart';

ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
ValueNotifier<int> notificationCountNotifier = ValueNotifier<int>(0);

class ParentScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final int? index;
  const ParentScreen({super.key, this.index, required this.navigationShell});

  @override
  State<ParentScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<ParentScreen>
    with WidgetsBindingObserver {
  bool isInit = false;

  @override
  void initState() {
    indexNotifier.value = 0;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  bool _wasInactive = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (!isPickFile) {
    //   if (state == AppLifecycleState.hidden ||
    //       state == AppLifecycleState.paused) {
    //     _wasInactive = true;
    //   }
    //   if (state == AppLifecycleState.resumed) {
    //     if (_wasInactive) {
    //       getNotificationCount();
    //     }
    //     _wasInactive = false;
    //   }
    // }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexNotifier,
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor:AppColors.background,
            appBar:(value==3||value==2||value==1)?null:
            (isDoctor()&& !isProfileDoctorIsActive)?null:appBar(
                backgroundColor:AppColors.background,context: context,backBtn:false,actions:[
              Row(
                children: [
                  if(isDoctor())
                    (SharedPreferenceService().getString(SharPrefConstants.image)).isEmpty?Padding(
                      padding: const EdgeInsets.only(right:14),
                      child: CircleAvatar(radius:29,
                        backgroundColor: AppColors.whiteColor,
                        child:Icon(Icons.person),),
                    ):
                    Padding(
                    padding: const EdgeInsets.only(right:14),
                    child: PImage(source:SharedPreferenceService().getString(SharPrefConstants.image),
                      width:60,height:60,isCircle:true,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:14),
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                        PText(title: 'hello'.tr(),fontColor:AppColors.grey200,),
                        PText(title:SharedPreferenceService().getString(SharPrefConstants.userName),
                        fontWeight: FontWeight.w700,size:PSize.text20,),
                      ],
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(onTap:() {
                context.push(AppRouter.notificationScreen);
              },child: Padding(
                  padding: const EdgeInsets.only(bottom:10),
                  child: Container(margin:EdgeInsets.symmetric(horizontal:12),
                      padding:EdgeInsets.all(10),decoration:BoxDecoration(
                          shape:BoxShape.circle,color:Colors.white
                      ),child:PImage(source:AppSvgIcons.icNotification,width:20,height:20,)),
                ),
              ),
            ]),
            // appBar: indexNotifier.value == 0 || indexNotifier.value == 2
            //     ? appBar(backgroundColor:AppColors.background,
            //   horizontalPadding: indexNotifier.value == 0 ? 16 : 10,
            //   context: context, backBtn: false,
            //   hasBloc:
            //   indexNotifier.value == 0 || indexNotifier.value == 2,
            // ) : null,
            bottomNavigationBar: CustomBottomNavigation(
              index: widget.navigationShell.currentIndex,
              navigationShell: widget.navigationShell,
            ),
            body: widget.navigationShell
        );
      },
    );
  }
}

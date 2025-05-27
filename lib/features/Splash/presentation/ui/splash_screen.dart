import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import '../../../../core/data/constants/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  double _opacity1 = 0.0;
  double _opacity2 = 0.0;
  double _opacity3 = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimations();
    _delayedNavigation();
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _opacity1 = 1.0);
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _opacity2 = 1.0);
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _opacity3 = 1.0);
    });
  }

  void _delayedNavigation() {
    Future.delayed(Duration(seconds:isDoctor()?2:4), () async {
      // context.push(AppRouter.home);
      // context.push(AppRouter.doctorOrPatientScreen);
      // context.push(AppRouter.login);
      // context.push(AppRouter.survey);
      String userType = SharedPreferenceService().getString(SharPrefConstants.userType);
      print('userType>>'+userType.toString());
      if (!mounted) return;
      if(userType.isEmpty){
        context.push(AppRouter.doctorOrPatientScreen);
      }else{
        bool isLoginKey = SharedPreferenceService().getBool(SharPrefConstants.isLoginKey);
        print('isLoginKey>>'+isLoginKey.toString());
        if (!mounted) return;
        if (isLoginKey) {
          bool surveyStatus = SharedPreferenceService().getBool(SharPrefConstants.surveyStatus);
          print('surveyStatus>>'+surveyStatus.toString());
          if(surveyStatus){
            context.goNamed(userType=='doctor'?AppRouter.doctorSurvey:AppRouter.patientSurvey);
          }else{
            if(isDoctor()){
              await getDoctorProfileStatus();
            }
            context.goNamed(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
          }
        } else {
          context.goNamed(AppRouter.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _opacity2,
              child: Container(
                width: screenWidth,
                height: 430,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:Color(0xffF4F7FA),
                  // color: AppColors.primaryColor50,
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _opacity1,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: AppColors.primaryColor100,
                  color:Color(0xffEBF0F5),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _opacity3,
              child: Container(
                // width: 240,
                // height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: AppColors.primaryColor100,
                  color:Colors.transparent,
                ),
                child: Image.asset(
                  AppIcons.appSplashLogo,
                  width: 135,
                  height: 158,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

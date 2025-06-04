import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _circleController;
  late final Animation<double> _outerCircleScale;
  late final Animation<double> _innerCircleScale;

  late final AnimationController _logoController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _outerCircleScale = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOutCubic),
    );
    _innerCircleScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOutBack),
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutExpo),
    );

    _circleController.forward();
    Future.delayed(const Duration(milliseconds: 600), () => _logoController.forward());

    _delayedNavigation();
  }

  void _delayedNavigation() {
    Future.delayed(const Duration(seconds: 3), () async {
      String userType = SharedPreferenceService().getString(SharPrefConstants.userType);
      if (!mounted) return;

      if (userType.isEmpty) {
        context.push(AppRouter.doctorOrPatientScreen);
      } else {
        bool isLoginKey = SharedPreferenceService().getBool(SharPrefConstants.isLoginKey);
        if (!mounted) return;

        if (isLoginKey) {
          bool surveyStatus = SharedPreferenceService().getBool(SharPrefConstants.surveyStatus);
          if (surveyStatus) {
            context.goNamed(userType == 'doctor' ? AppRouter.doctorSurvey : AppRouter.patientSurvey);
          } else {
            context.goNamed(userType == 'doctor' ? AppRouter.homeDoctor : AppRouter.homePatient);
          }
        } else {
          context.goNamed(AppRouter.login);
        }
      }
    });
  }

  @override
  void dispose() {
    _circleController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      body: AnimatedBuilder(
        animation: Listenable.merge([_circleController, _logoController]),
        builder: (context, child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer ripple
                Transform.scale(
                  scale: _outerCircleScale.value,
                  child: Container(
                    width:MediaQuery.sizeOf(context).width*0.82,
                    height:MediaQuery.sizeOf(context).width*0.82,
                    decoration: const BoxDecoration(
                      color: Color(0xffF4F7FA),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Inner ripple
                Transform.scale(
                  scale: _innerCircleScale.value,
                  child: Container(
                    width: (MediaQuery.sizeOf(context).width*0.64),
                    height: (MediaQuery.sizeOf(context).width*0.64),
                    decoration: const BoxDecoration(
                      color: Color(0xffEBF0F5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Logo in center with layered scale + fade
                Transform.scale(
                  scale: _outerCircleScale.value, // Optional: can be a separate logo pulse value
                  child: FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Image.asset(
                        // AppIcons.appSplashLogo,
                        AppIcons.splashIconEmpty,
                        width: 135,
                        height: 138,
                      ),
                    ),
                  ),
                ),

                // Logo in center
                // FadeTransition(
                //   opacity: _logoFade,
                //   child: ScaleTransition(
                //     scale: _logoScale,
                //     child: Image.asset(
                //       AppIcons.appSplashLogo,
                //       width: 135,
                //       height: 158,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}









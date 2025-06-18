import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import '../core/data/constants/shared_preferences_constants.dart';

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({super.key});

  void _selectLanguage(BuildContext context, String langCode) async {
    Locale selectedLocale = langCode == 'ar'
        ? const Locale('ar', 'DZ')
        : const Locale('en', 'US');

    await context.setLocale(selectedLocale);
    if (!context.mounted) return;
    navigation(context);
  }

  void navigation(BuildContext context) {
      String userType = SharedPreferenceService().getString(SharPrefConstants.userType);
      if (userType.isEmpty) {
        context.push(AppRouter.doctorOrPatientScreen);
      } else {
        bool isLoginKey = SharedPreferenceService().getBool(SharPrefConstants.isLoginKey);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Center(
            child: Icon(Icons.language, size: 100, color:AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
          const PText(title:'Select Your Language',
            size:PSize.text28,fontWeight:FontWeight.w700,),
          const SizedBox(height: 10),
          const PText(title:'يرجى اختيار لغتك المفضلة',
            size:PSize.text20,fontWeight:FontWeight.w500,),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(color: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation:1,
              child: Column(
                children: [
                  _buildLangTile(
                    context,
                    'English',
                    '🇺🇸',
                    'en',
                  ),
                  const Divider(height: 1),
                  _buildLangTile(
                    context,
                    'العربية',
                    '🇸🇦',
                    'ar',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangTile(
      BuildContext context,
      String title,
      String flag,
      String code,
      ) {
    return ListTile(
      leading: PText(title:flag,size:PSize.text28,),
      title: PText(title:title,size: PSize.text20,),
      onTap: () => _selectLanguage(context, code),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
    );
  }
}

// Dummy HomeScreen for navigation
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Home Screen")),
    );
  }
}

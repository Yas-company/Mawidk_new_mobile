import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int allSteps;
  const StepIndicator({super.key, required this.currentStep,required this.allSteps});

  @override
  Widget build(BuildContext context) {
    final int totalSteps = allSteps;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,children: [
                    PText(title: '${currentStep+1} من $allSteps'),
                  if(!SharedPreferenceService().getBool(SharPrefConstants.isDoctor))InkWell(onTap:() async {
                    await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,false);
                    await SharedPreferenceService().setBool(SharPrefConstants.isSKippedSurvey,true);
                    Get.context!.go(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
                  },child: Padding(
                    padding: const EdgeInsets.only(bottom:0),
                    child: PText(title: 'تخطي',fontColor: AppColors.grey200,),
                  ))
                  ],
                ),
                const SizedBox(height:20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalSteps, (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height:6,
                        decoration: BoxDecoration(
                          color: index <= currentStep
                              ? AppColors.primaryColor
                              : AppColors.grey100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          // if(!SharedPreferenceService().getBool(SharPrefConstants.isDoctor))const SizedBox(width:14,),

        ],
      ),
    );
  }
}
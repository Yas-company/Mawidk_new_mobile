import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';

class SuccessfulBookingBottomWidget extends StatelessWidget {
  final double? height;
  const SuccessfulBookingBottomWidget({super.key,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.only(top:0,bottom:1,
        left:20,right:20),decoration:BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(width: 3, color:Colors.white),
    ),child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:CrossAxisAlignment.center,children: [
        PImage(source:AppIcons.successfulPayment,height:160,width:200,),
      Padding(
        padding: const EdgeInsets.only(top:20,bottom:4),
        child: PText(title:'  شكراً لك ${SharedPreferenceService().getString(SharPrefConstants.userName)}',
          fontWeight:FontWeight.w700,size:PSize.text18,),
      ),

      PText(title:'سوف يصلك اشعار تأكيد الحجز', fontColor:AppColors.primaryColor2,
      fontWeight: FontWeight.w700,size:PSize.text14,),
      const SizedBox(height:8,),
      Padding(
        padding: const EdgeInsets.only(top:16,bottom:0),
        child: PButton(onPressed:() {
          Navigator.of(context).popUntil((route) => route.isFirst);
          // Navigator.pop(context);
          // Get.context!.go(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
        },title:'الانتقال للصفحة الرئيسية',isFitWidth:true,hasBloc:false,fontWeight:FontWeight.w700,
          textColor:AppColors.whiteColor,),
      )
    ],),
    );
  }
}


void showSuccessfulBookingBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,isDismissible:false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        // height: 300,
        child:SuccessfulBookingBottomWidget()
      ),
    ),
  );
}
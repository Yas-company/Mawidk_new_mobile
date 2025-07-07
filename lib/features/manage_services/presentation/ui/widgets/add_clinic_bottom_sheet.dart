import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class AddClinicBottomSheet extends StatelessWidget {
  const AddClinicBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.only(top:0,bottom:1),decoration:BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(width: 3, color:Colors.white),
    ),child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:CrossAxisAlignment.center,children: [
      PText(title:'did_not_add_any_clinic'.tr(), fontWeight: FontWeight.w700,size:PSize.text20,),
      const SizedBox(height:8,),
      PText(title:'add_your_clinic'.tr(),size:PSize.text14,fontColor:AppColors.grey200,fontWeight:FontWeight.w400,),
      const SizedBox(height:16,),
      PButton(size: PSize.text16,isFitWidth:true,
        title: 'add_clinic'.tr(),
        onPressed: () {
        Navigator.pop(context);
        context.push(AppRouter.locationScreen);
        },hasBloc: false,
      )
    ],),
    );
  }
}


void showReviewAddClinicBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context, isScrollControlled: true,
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
          child:AddClinicBottomSheet()
      ),
    ),
  );
}
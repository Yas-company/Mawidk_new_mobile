import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/home/data/model/doctor_profile_status_response_model.dart';

class ReviewStatusBottomSheet extends StatelessWidget {
  final DoctorProfileStatusModel model;
  const ReviewStatusBottomSheet({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.only(top:0,bottom:1),decoration:BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(width: 3, color:Colors.white),
    ),child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:CrossAxisAlignment.start,children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PText(title:'review_status'.tr(), fontWeight: FontWeight.w700,size:PSize.text18,),
          InkWell(onTap:() {
            Navigator.pop(context);
          }, child:Icon(Icons.close,color:AppColors.grey200,))
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom:4,top:10),
        child: Divider(color:AppColors.grey100,),
      ),
      const SizedBox(height:8,),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          PText(title:'request_date'.tr(), fontWeight: FontWeight.w500,),
          PText(title:model.dateOfApplication??'', fontWeight: FontWeight.w600,),
        ],
      ),
      const SizedBox(height:6,),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          PText(title:'review_status2'.tr(), fontWeight: FontWeight.w500,),
          PText(title:(model.isActive??0)==0?'in_review'.tr():'',
            fontWeight: FontWeight.w600,fontColor:AppColors.reviewDescColor,),
        ],
      ),
      const SizedBox(height:30,),
      Container(
        padding:EdgeInsets.symmetric(horizontal:10,vertical:10),
        color:AppColors.whiteColor,child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        PText(title:'remaining_steps'.tr(), fontWeight: FontWeight.w700,size:PSize.text18,),
          const SizedBox(height:10,),
        Row(children: [
          // Icon(Icons.access_time_outlined),
          PImage(source:AppSvgIcons.checkCircle),const SizedBox(width:10,),
          PText(title:'document_verified'.tr(),size:PSize.text14,fontColor:AppColors.grayShade3,),
        ],),
          const SizedBox(height:6,),
        Row(children: [
          Icon(Icons.access_time_outlined,size:18.4,color:AppColors.reviewDescColor,),const SizedBox(width:10,),
          PText(title:'academic_qualification_verified'.tr(),size:PSize.text14,fontColor:AppColors.grayShade3,),
        ],),
          const SizedBox(height:6,),
        Row(children: [
          Icon(Icons.access_time_outlined,size:18.4,color:AppColors.reviewDescColor,),const SizedBox(width:10,),
          PText(title:'license_verified'.tr(),size:PSize.text14,fontColor:AppColors.grayShade3,),
        ],)
      ],),)
    ],),
    );
  }
}


void showReviewStatusBottomSheet(BuildContext context,DoctorProfileStatusModel model) {
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
          child:ReviewStatusBottomSheet(model:model,)
      ),
    ),
  );
}
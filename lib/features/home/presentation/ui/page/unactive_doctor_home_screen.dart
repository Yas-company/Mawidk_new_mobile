import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/home/data/model/doctor_profile_status_response_model.dart';
import 'package:mawidak/features/home/domain/use_case/home_patient_use_case.dart';
import 'package:mawidak/features/home/presentation/ui/doctor_widgets/review_status_bottom_sheet.dart';
import 'package:mawidak/features/home/presentation/ui/doctor_widgets/time_ask_widget.dart';

class UnActiveDoctorHomeScreen extends StatelessWidget {
  const UnActiveDoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal:0),
        child: Column(children:[

          Card(color:AppColors.reviewCardColor,
            margin:EdgeInsets.only(top:80),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,child:Padding(
              padding: const EdgeInsets.symmetric(vertical:34),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Icon(Icons.access_time_rounded,color:AppColors.reviewDescColor,size:18,),
                  const SizedBox(width:10),
                  PText(title: 'in_review'.tr(),fontColor:AppColors.reviewTextColor,fontWeight:FontWeight.w500,
                  size:PSize.text14,)
                ],),
                  const SizedBox(height:16,),
                  PText(title:'in_review_desc'.tr(),fontColor:AppColors.reviewDescColor,fontWeight:FontWeight.w400,
                    size:PSize.text12,)
                ],),
            )),
          const SizedBox(height:16,),

          Expanded(
            child: SingleChildScrollView(child:Column(children: [
              Card(color:Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical:40),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        (SharedPreferenceService().getString(SharPrefConstants.image)).isEmpty?
                        CircleAvatar(radius:35,
                          backgroundColor: AppColors.whiteColor,
                          child:Icon(Icons.person),):PImage(source:
                        SharedPreferenceService().getString(SharPrefConstants.image),
                          isCircle: true,width:80,height:80,),
                        const SizedBox(height:20,),
                        PText(title: 'good_morning'.tr(),fontColor:AppColors.grey200),
                        const SizedBox(height:5,),
                        PText(title: 'doctor.'.tr() +
                            SharedPreferenceService().getString(SharPrefConstants.userName)
                          ,size:PSize.text20,),
                        const SizedBox(height:24,),
                        PText(title: 'review'.tr(),fontColor:AppColors.grey200),
                      ],),
                    ],
                  ),
                ),),
              const SizedBox(height:10,),
            
            
              InkWell(onTap:() async {
                HomePatientUseCase homePatientUseCase =HomePatientUseCase(homePatientRepository:getIt());
                loadDialog();
                var response = await homePatientUseCase.getDoctorProfileStatus();
                response.fold((l) {hideLoadingDialog();},(r) {
                  hideLoadingDialog();
                  DoctorProfileStatusModel model =
                  (((r).model as DoctorProfileStatusResponseModel).model??DoctorProfileStatusModel());
                  showReviewStatusBottomSheet(navigatorKey.currentState?.context??context, model);
                },);
              },child: Card(color:Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical:14),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye,color:AppColors.primaryColor,),
                      const SizedBox(width:14,),
                      PText(title: 'follow_review'.tr(),fontColor:AppColors.primaryColor),
                    ],
                  ),
                ),),
              ),
            
              Padding(
                padding: EdgeInsets.only(top:10,bottom:14),
                child: Column(
                  children: [
                    Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      mainAxisSize:MainAxisSize.max,children: [
                        Expanded(
                            child:SizedBox(height:104,
                              child: Stack(fit: StackFit.expand,
                                children: [
                                  TimeAskCard(isActive:false,title:'home_visit', image:AppSvgIcons.icHomeVisit, value:8,
                                    onTap:() {
            
                                    },),
                                  Center(child: Icon(Icons.lock,color:AppColors.grey200,)),
                                ],
                              ),
                            )
                        ),
                        const SizedBox(width:3,),
                        Expanded(
                            child:SizedBox(height:104,
                              child: Stack(fit: StackFit.expand,
                                children: [
                                  TimeAskCard(isActive:false,title:'book_online', image:AppSvgIcons.icBookOnline, value:10,
                                    onTap:() {
            
                                    },),
                                  Center(child: Icon(Icons.lock,color:AppColors.grey200,)),
                                ],
                              ),
                            )
                        ),
                      ],),
                    const SizedBox(height:3,),
                    Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      mainAxisSize:MainAxisSize.max,children: [
                        Expanded(
                            child:SizedBox(height:104,
                              child: Stack(fit: StackFit.expand,
                                children: [
                                  TimeAskCard(isActive:false,title:'attendance', image:AppSvgIcons.icAttendance, value:7,
                                    onTap:() {
            
                                    },),
                                  Center(child: Icon(Icons.lock,color:AppColors.grey200,)),
                                ],
                              ),
                            )
                        ),
                        const SizedBox(width:3,),
                        Expanded(
                            child:SizedBox(height:104,
                              child: Stack(fit: StackFit.expand,
                                children: [
                                  TimeAskCard(isActive:false,title:'follow', image:AppSvgIcons.icFollow, value:5,
                                    onTap:() {
            
                                    },),
                                  Center(child: Icon(Icons.lock,color:AppColors.grey200,)),
                                ],
                              ),
                            )
                        ),
                      ],),
                  ],
                ),
              ),
            
            
              Card(color:Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                child:Padding(
                    padding: const EdgeInsets.symmetric(vertical:14,horizontal:16),
                    child: Row(
                      children: [
                        Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                          const SizedBox(height:6,),
                          PText(title: 'complete_register'.tr(),size:PSize.text18,),
                          const SizedBox(height:13,),
                          PText(title: 'personal_info'.tr(),size:PSize.text14,fontColor:AppColors.green,),
                          const SizedBox(height:13,),
                          PText(title: 'attachments_uploaded'.tr(),size:PSize.text14,fontColor:AppColors.green,),
                          const SizedBox(height:13,),
                          PText(title: 'review_account'.tr(),size:PSize.text14,fontColor:AppColors.reviewDescColor,),
                          const SizedBox(height:13,),
                          PText(title: 'account_activation'.tr(),size:PSize.text14,fontColor:AppColors.grey200,),
                          const SizedBox(height:13),
                        ],),
                      ],
                    )
                ),),
            
            
              Card(color:Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                child:Padding(
                    padding: const EdgeInsets.symmetric(vertical:14,horizontal:16),
                    child: Row(
                      children: [
                        Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                          const SizedBox(height:6,),
                          PText(title: 'important_info'.tr(),size:PSize.text18,fontWeight:FontWeight.w700,),
                          const SizedBox(height:13,),
                          PText(title: 'account_review'.tr(),size:PSize.text14,fontColor:AppColors.grey200,),
                          const SizedBox(height:10),
                          PText(title: 'ensure_attachments'.tr(),size:PSize.text14,fontColor:AppColors.grey200,),
                          const SizedBox(height:13),
                        ],),
                      ],
                    )
                ),),
              const SizedBox(height:13),
            ],),),
          )

        ],)
    );
  }
}

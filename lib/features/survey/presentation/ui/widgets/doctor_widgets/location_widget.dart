import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/dashed_border/dashed_border_container.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/doctor_work_hours_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/doctor_widgets/days_widget.dart';

class LocationWidgetScreen extends StatelessWidget {

  const LocationWidgetScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:AppColors.whiteBackground,
      // appBar:appBar(context: context,text:'إضافة عيادة جديدة',isCenter:true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Column(mainAxisSize:MainAxisSize.max,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical:14),
                child: Row(children: [
                  GestureDetector(
                      onTap:() {
                        Navigator.pop(context);
                      },child: PImage(source:AppSvgIcons.icBack,color:Colors.black,)),Spacer(),
                  const SizedBox(width:4,),
                  // PText(title: 'إضافة عيادة جديدة',size:PSize.text18,fontColor:Colors.black,),Spacer(),
                  PText(title: 'receive_clinic'.tr(),size:PSize.text18,fontColor:Colors.black,),Spacer(),
                ],),
              ),
              // Padding(padding: const EdgeInsets.symmetric(horizontal:4),
              //   child: Divider(color:AppColors.grey100,),
              // ),
             Expanded(
               child: SingleChildScrollView(
                 child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                   const SizedBox(height:14,),
                   // Container(
                   //   width: 400, color:Color(0xffF1F8FF),
                   //   padding: const EdgeInsets.only(
                   //     left: 20, right: 20, top: 20, bottom: 20,),
                   //   margin:EdgeInsets.only(bottom:20,top:10),
                   //   child: Column(
                   //     crossAxisAlignment: CrossAxisAlignment.start,
                   //     children: [
                   //       PText(title:'معلومات العيادة', size: PSize.text20,),
                   //       PText(title:'ادخل تفاصيل العيادة من فضلك ', size: PSize.text20,
                   //         fontColor: AppColors.grey200, fontWeight: FontWeight.w400,),
                   //       const SizedBox(height:0),
                   //     ],
                   //   ),
                   // ),
                   DashedBorderContainer(
                     dashedBorderColor:Colors.transparent,
                     // dashedBorderColor: AppColors.shade4,
                     child: Container(
                       margin: const EdgeInsets.all(1),
                       width: MediaQuery.sizeOf(context).width,
                       padding: const EdgeInsets.only(
                           top: 20, bottom:10, left: 20, right: 20),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(16),
                         // color: AppColors.primaryColor10,
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           PImage(source: AppSvgIcons.location,),
                           const SizedBox(height: 12),
                           PText(title: 'identify_clinic'.tr(), size: PSize.text16,),
                           Padding(
                             padding: const EdgeInsets.only(left:20,right:20,top:10,bottom:20),
                             child: PText(title:'identify_clinic_easily'.tr(),
                               fontColor:AppColors.grey200,size:PSize.text13,
                               alignText:TextAlign.center,),
                           ),
                           PButton(isFitWidth:true,title:'locate_clinic_location'.tr(),hasBloc:false,
                             onPressed:() {
                               context.push(AppRouter.pickupLocationScreen);
                             },)
                         ],
                       ),
                     ),
                   ),

                   Padding(
                     padding: const EdgeInsets.only(top:18,bottom:14),
                     child: PTextField(hintText:'enter_detailed_address'.tr(),
                       labelAbove: 'detailed_address'.tr(),labelAboveFontWeight: FontWeight.w600,feedback:(value) {

                       },),
                   ),

                   Padding(
                     padding: const EdgeInsets.only(top:4,bottom:14),
                     child: PTextField(hintText:'enter_clinic_name'.tr(),
                       labelAbove: 'clinic_name'.tr(),labelAboveFontWeight: FontWeight.w600,feedback:(value) {

                       },),
                   ),

                   DoctorWorkHoursPicker(),

                   Padding(
                     padding: const EdgeInsets.only(left:0,right:0,top:20,bottom:10),
                     child: PText(title:'work_days'.tr(),size:  PSize.text14,),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right:0,left:50,bottom:14),
                     child: DaysWidget(),
                   ),
                   Row(children:[
                     Expanded(
                       child: PTextField(hintText:'',
                         labelAbove: 'consultation_fees'.tr(),labelAboveFontWeight: FontWeight.w600,feedback:(value) {

                         },),
                     ),const SizedBox(width:10,),
                     Padding(
                       padding: const EdgeInsets.only(top:20,),
                       child: PText(title: 'sar'.tr()),
                     )
                   ],
                   ),
                   const SizedBox(height:14,),
                   Row(children:[
                     Expanded(
                       child: PTextField(hintText:'',
                         labelAbove: 'waiting_duration'.tr(),labelAboveFontWeight: FontWeight.w600,feedback:(value) {

                         },),
                     ),const SizedBox(width:10,),
                     Padding(
                       padding: const EdgeInsets.only(top:20,),
                       child: PText(title: 'minute'.tr()),
                     )
                   ],
                   ),

                   const SizedBox(height:24,),
                   PButton(isFitWidth: true,onPressed:() {

                   },title:'save'.tr(),hasBloc:false,fillColor:AppColors.primaryColor,),
                   const SizedBox(height:24,),
                 ],),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}

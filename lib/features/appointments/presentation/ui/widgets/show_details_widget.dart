import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';

class ShowDetailsWidget extends StatelessWidget {
  final DoctorAppointmentsData model;
  const ShowDetailsWidget({super.key,required this.model});

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
          PText(title:'appointment_details'.tr(), fontWeight: FontWeight.w700,size:PSize.text18,),
          InkWell(onTap:() {
            Navigator.pop(context);
          }, child:Icon(Icons.close,color:AppColors.grey200,))
        ],
      ),
      const SizedBox(height:30,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (model.patientPhoto??'').isEmpty ?
          CircleAvatar(
            radius:35,
            backgroundColor: AppColors.whiteColor,
            child: Icon(Icons.person),
          ) : PImage(source:ApiEndpointsConstants.baseImageUrl+(model.patientPhoto??''), isCircle: true, height: 60, width: 60),
          const SizedBox(width: 16),

          // Doctor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                PText(title: model.clinicName??''),
                const SizedBox(height: 10),
                Row(
                  children: [
                    PImage(source:AppSvgIcons.icOnline),
                    const SizedBox(width: 4),
                    Flexible(child: PText(title: model.status??'', fontColor: AppColors.grey200)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom:4,top:10),
        child: Divider(color:AppColors.grey100,),
      ),
      const SizedBox(height:8,),
      detailsInfo('date'.tr(), model.appointmentDate??'', Icons.calendar_month_rounded),
      const SizedBox(height:10,),
      detailsInfo('time'.tr(), model.appointmentTime??'', Icons.access_time),
      const SizedBox(height:10,),
      detailsInfo('location'.tr(),'عنوان العيادة', Icons.my_location),
    ],),
    );
  }
}

Widget detailsInfo(String title,String value,IconData icon){
  return Row(children: [
    Icon(icon,color:AppColors.primaryColor,),
    const SizedBox(width:14,),
    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      PText(title:title,fontColor:AppColors.grayShade3,),
      const SizedBox(height:4,),
      PText(title:value),
    ],)
  ],);
}

void showDetailsWidgetBottomSheet(DoctorAppointmentsData model) {
  showModalBottomSheet(
    context: navigatorKey.currentState!.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding:EdgeInsets.zero,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          // height: 300,
          child:ShowDetailsWidget(model:model,)
      ),
    ),
  );
}
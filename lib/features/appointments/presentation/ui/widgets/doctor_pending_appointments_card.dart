import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/appointments/presentation/ui/widgets/cancel_appointment_widget.dart';
import 'package:mawidak/features/appointments/presentation/ui/widgets/show_details_widget.dart';


class DoctorPendingAppointmentsCard extends StatelessWidget {
  final DoctorAppointmentsData model;
  final Function(CancelAppointmentRequestModel? value) onCancel;
  final VoidCallback onAccept;

  const DoctorPendingAppointmentsCard({
    required this.model,
    required this.onCancel,
    required this.onAccept,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:onAccept,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Card(color:AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation:0.0,
        margin:EdgeInsets.only(bottom:20),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left content with image and text
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor Image
                        (model.patientPhoto??'').isEmpty
                            ? CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.whiteBackground,
                          child: Icon(Icons.person),
                        )
                            : PImage(source:ApiEndpointsConstants.baseImageUrl+(model.patientPhoto??''),
                            isCircle: true, height: 60, width: 60),
                        const SizedBox(width: 16),

                        // Doctor Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              PText(title: model.clinicName??''),
                              const SizedBox(height: 5),
                              Container(
                                padding:EdgeInsets.symmetric(horizontal:8,vertical:4),
                                decoration:BoxDecoration(
                                color:AppColors.primaryColor1100,
                                borderRadius:BorderRadius.circular(5)
                              ),child: Row(mainAxisSize:MainAxisSize.min,
                                  children: [
                                    PImage(source:AppSvgIcons.icOnline,color:AppColors.primaryColor,),
                                    const SizedBox(width: 4),
                                    Flexible(child: PText(title: model.status??'', fontColor: AppColors.grey200)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:4),
                child: PText(title: '${'time'.tr()} : ${model.appointmentTime??''}',fontColor:AppColors.grey200,),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:4),
                child: PText(title: '${'notes'.tr()} : ${model.status??''}',fontColor:AppColors.grey200,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4),
                child: Divider(color:AppColors.grey100,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:7),
                child: Row(
                  children: [
                    Expanded(
                      child: PButton(onPressed:onAccept,
                        fillColor:AppColors.primaryColor,
                        textColor:AppColors.whiteColor,
                        borderColor:AppColors.primaryColor,borderRadius:16,
                        title:'accept'.tr(),hasBloc:false,size:PSize.text16,
                        fontWeight:FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width:10,),
                    Expanded(
                      child: PButton(borderRadius:16,onPressed:() {
                        cancelAppointmentWidgetBottomSheet(onCancel);
                      },title:'refuse'.tr(),fillColor:AppColors.danger,
                        hasBloc:false,size:PSize.text16,
                        padding:EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

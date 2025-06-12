import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/patient_appointments/data/model/patient_appointments_response_model.dart';


class PatientAppointmentsCardWidget extends StatelessWidget {
  final AppointmentData model;
  final VoidCallback onAccept;
  final VoidCallback onCancel;

  const PatientAppointmentsCardWidget({
    required this.model,
    required this.onAccept,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16),
      child: InkWell(onTap:onAccept,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Card(color:AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation:0.0,
          margin:EdgeInsets.only(bottom:15,top:5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Doctor Image
                          (model.doctorAvatar??'').isEmpty
                              ? CircleAvatar(
                            radius: 35,
                            backgroundColor: AppColors.whiteBackground,
                            child: Icon(Icons.person),
                          )
                              : PImage(source:ApiEndpointsConstants.baseImageUrl+(model.doctorAvatar??''),
                              isCircle: true, height: 60, width: 60),
                          const SizedBox(width: 16),

                          // Doctor Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height:3),
                                PText(title: model.doctorName??''),
                                const SizedBox(height:3),
                                PText(title:model.doctorSpeciality??'',
                                  fontColor: AppColors.grey200,size:PSize.text14,),
                                const SizedBox(height:8),
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

          GestureDetector(
            onTapDown: (details) async {
              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
              await showMenu(
                context: context,menuPadding: EdgeInsets.symmetric(horizontal:30),
                position: RelativeRect.fromRect(
                  details.globalPosition & const Size(40, 40),
                  Offset.zero & overlay.size,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                color: AppColors.whiteColor,
                elevation: 5,
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    value: 1,
                    child: Row(
                      children: [
                        const SizedBox(width: 0),
                        PImage(source: AppSvgIcons.icChange),
                        const SizedBox(width: 10),
                        PText(title: 'change_appointment'.tr()),
                      ],
                    ),
                  ),
                  if((model.canCancel??false))const PopupMenuDivider(height: 1,),
                  if((model.canCancel??false))PopupMenuItem(
                    padding: EdgeInsets.zero,
                    value: 2,
                    child: Row(
                      children: [
                        const SizedBox(width: 0),
                        PImage(source: AppSvgIcons.icCancel),
                        const SizedBox(width: 10),
                        PText(
                          title: 'cancel_appointment'.tr(),
                          fontColor: AppColors.danger,
                        ),
                      ],
                    ),
                  ),
                ],
              ).then((value) {
                if (value == 1) {
                  // Handle change
                } else if (value == 2) {
                  onCancel();
                }
              });
            },
            child: const Icon(Icons.more_vert, color: Colors.grey),
          )

          ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(top:4,bottom:3),
                  child: Divider(color:AppColors.grey100,),
                ),
                Row(children: [
                  PImage(source:AppSvgIcons.icDate,width:14,height:14,),const SizedBox(width:5),
                  PText(title:model.appointmentTime??'',fontColor: AppColors.grey200,size:PSize.text14,),
                  Spacer(),
                  PImage(source:AppSvgIcons.icTime,width:15,height:15),const SizedBox(width:5),
                  PText(title:model.appointmentTime??'',fontColor: AppColors.grey200,size:PSize.text14,),
                  Spacer(),
                ],),

                Padding(
                  padding: const EdgeInsets.only(top:12,bottom:6),
                  child: PButton(onPressed:(model.canCancel??false)?onAccept:null,
                    isFitWidth:true,
                    fillColor:(model.canCancel??false)?AppColors.primaryColor
                        :AppColors.primaryColor.withOpacity(0.3),
                    textColor:AppColors.whiteColor,
                    borderColor:(model.canCancel??false)?AppColors.primaryColor
                        :null,borderRadius:16,
                    title:'start_calll'.tr(),hasBloc:false,size:PSize.text16,
                    fontWeight:FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

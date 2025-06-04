import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';

class PatientItemCardWidget extends StatelessWidget {
  final PatientData patientData;
  final VoidCallback? onTap;
  final VoidCallback? onCardClick;

  const PatientItemCardWidget({
    super.key,
    required this.patientData,
    this.onTap,
    this.onCardClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:onCardClick,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom:6,left:16,right:16,top:6),
        child: Card(color:AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation:0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Doctor Image
                    (patientData.photo??'').isEmpty?CircleAvatar(radius:33,
                      backgroundColor: AppColors.whiteBackground,
                      child:Icon(Icons.person),):
                    PImage(source:ApiEndpointsConstants.baseImageUrl+(patientData.photo??''),
                      isCircle:true,height:60,width:60,),
                    const SizedBox(width: 16),

                    // Doctor Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PText(title:patientData.name??''),

                          const SizedBox(height: 11),

                          // Rating
                        PText(title:'last_visit'.tr() + (patientData.lastAppointmentDate??''),
                          fontColor:AppColors.grey200,),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:4),
                  child: Divider(color:AppColors.grey100,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:4),
                  child: PButton(
                    // onPressed:onTap,
                    onPressed:() {
                      context.push(AppRouter.showFileScreen,extra:patientData);
                    },
                    title:'show_file'.tr(),hasBloc:false,isFitWidth:true,size:PSize.text16,
                    fontWeight:FontWeight.w700,fillColor:AppColors.primaryColor,
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

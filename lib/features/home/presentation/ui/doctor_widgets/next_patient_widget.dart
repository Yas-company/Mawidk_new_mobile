import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class NextPatientCard extends StatelessWidget {
  final String name;
  final String title;
  final String image;
  final String date;
  final VoidCallback onCall;

  const NextPatientCard({
    super.key,
    required this.name,
    required this.title,
    required this.image,
    required this.date,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF316599),Color(0xFF51A8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PText(title:'دكتور محمد الحسيني',fontColor:Colors.black,),const SizedBox(height:2,),
                      PText(title:'استشارة طبية اونلاين', fontColor:AppColors.grey100,size:PSize.text14,),
                    ],
                  ),
                ),
                // Phone icon
                PImage(source:'https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg',
                  width:60,height:60,isCircle:true,),
              ],
            ),

            const SizedBox(height:30),

            /// Date and Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    PText(title: '١٠:٣٠ - ١١ صباحا', fontColor:AppColors.whiteColor,size:PSize.text14,),
                  ],
                ),
                SizedBox(height:40,
                  child: PButton(title: 'start_call'.tr(),hasBloc:false,onPressed:() {

                  },fillColor:AppColors.grey100.withOpacity(0.5),textColor:Colors.black.withOpacity(0.5),
                    borderColor:Colors.transparent,padding:EdgeInsets.symmetric(horizontal:7),
                    borderRadius: 8,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

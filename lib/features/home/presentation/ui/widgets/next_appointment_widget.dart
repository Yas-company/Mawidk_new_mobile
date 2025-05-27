import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class NextAppointmentWidget extends StatelessWidget {
  const NextAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: 340,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // Name & Hospital
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PText(title:'دكتور محمد الحسيني', fontColor:AppColors.whiteColor,),
                      PText(title:'Cairo Medical Hospital', fontColor:AppColors.whiteColor,),
                    ],
                  ),
                ),

                // Phone icon
                Container(decoration:BoxDecoration(
                  shape:BoxShape.circle,
                    color:AppColors.primaryColor
                ),padding:EdgeInsets.all(8),child: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height:30),

            /// Date and Time
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    PText(title:'٣ ابريل ٢٠٢٥', fontColor:AppColors.whiteColor,size:PSize.text14,),
                  ],
                ),
                SizedBox(width: 40),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    PText(title: '١٠:٣٠ - ١١ صباحا', fontColor:AppColors.whiteColor,size:PSize.text14,),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

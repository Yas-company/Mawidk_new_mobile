import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class TopRatedDoctorCard extends StatelessWidget {
  final String imageUrl;
  final String doctorName;
  final String specialization;
  final double rating;
  final String location;
  final VoidCallback? onTap;
  final bool showRating;

  const TopRatedDoctorCard({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.rating,
    required this.location,
    required this.specialization,
    this.onTap,
    this.showRating=false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(color:Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation:0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              PImage(source:imageUrl,height:50,width:50,isCircle:true,),
              Padding(
                padding: const EdgeInsets.only(top:8,bottom:5),
                child: PText(title:doctorName),
              ),
              if(specialization.isNotEmpty)PText(title:specialization,fontColor:AppColors.grey200,),
              // Row(
              //   children: [
              //     if(showRating)const Icon(Icons.star, color: Color(0xffD8B881), size: 18),
              //     const SizedBox(width: 4),
              //     if(showRating)PText(title:'$rating - ',fontColor:AppColors.grey200,),
              //     PText(title:specialization,fontColor:AppColors.grey200,)
              //   ],
              // ),
              const SizedBox(height: 4),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(showRating)const Icon(Icons.star, color: Color(0xffD8B881), size: 18),
                  const SizedBox(width: 4),
                  if(showRating)PText(title:'$rating',fontColor:AppColors.grey200,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom:0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(color:Colors.white,
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
                    PImage(source: imageUrl,isCircle:true,height:60,width:60,),
                    const SizedBox(width: 16),

                    // Doctor Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PText(title:doctorName),

                          const SizedBox(height: 8),

                          // Rating
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              PText(title:rating.toString(),fontColor:AppColors.grey200,),
                              PText(title:' - $specialization',fontColor:AppColors.grey200,)
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(color:AppColors.grey200.withOpacity(0.3),),
                Row(
                  children: [
                    const Icon(Icons.my_location, size: 20, color:AppColors.primaryColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child:PText(title:location,fontColor:AppColors.grayShade3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: PButton(onPressed:() {

                  },title:'حجز موعد',hasBloc:false,isFitWidth:true,size:PSize.text16,
                    icon:PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,),
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

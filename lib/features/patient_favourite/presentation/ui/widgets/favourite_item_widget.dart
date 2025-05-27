import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class FavouriteItemWidget extends StatelessWidget {
  final String imageUrl;
  final String doctorName;
  final String specialization;
  final double rating;
  final String location;
  final VoidCallback? onTap;
  final VoidCallback? onCardClick;
  final bool showRating;

  const FavouriteItemWidget({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.rating,
    required this.location,
    required this.specialization,
    this.onTap,
    this.onCardClick,
    this.showRating=false,
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
                    imageUrl.isEmpty?CircleAvatar(radius:40,
                      backgroundColor: AppColors.whiteBackground,
                      child:Icon(Icons.person),):
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
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: PButton(onPressed:onTap,
                    title:'حجز موعد',hasBloc:false,isFitWidth:true,size:PSize.text16,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class DoctorsListWidget extends StatelessWidget {
  final String imageUrl;
  final String doctorName;
  final String specialization;
  final String doctorType;
  final double rating;
  final String location;
  final bool showRate;
  final String salary;
  final num averageRating;
  final Color? backgroundColor;
  final Color? imageColor;
  final VoidCallback? onTap;
  final VoidCallback? onClickCard;

  const DoctorsListWidget({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.doctorType,
    this.salary='0',
    this.backgroundColor,
    this.averageRating = 0,
    this.imageColor,
    required this.onClickCard,
    required this.rating,
    required this.location,
    required this.specialization,
    this.onTap,this.showRate=true
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,onTap: onClickCard,
      child: Padding(
        padding: const EdgeInsets.only(bottom:0),
        child: Card(color: backgroundColor ?? AppColors.whiteColor,
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
                    imageUrl.isEmpty?CircleAvatar(radius:31,
                      backgroundColor: imageColor ?? AppColors.whiteBackground,
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
                              PText(title:'$averageRating - ',fontColor:AppColors.grey200,),
                              PText(title:specialization,fontColor:AppColors.grey200,)
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
                    const Icon(Icons.person, size: 20, color:AppColors.primaryColor),
                    const SizedBox(width: 4),
                    Expanded(
                        child:PText(title:doctorType,fontColor:AppColors.grayShade3,
                          overflow: TextOverflow.ellipsis,
                        )
                    ),
                  ],
                ),
                const SizedBox(height:10,),
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
                const SizedBox(height:10,),
                Row(
                  children: [
                    const PImage(source:AppSvgIcons.icMoney,width:14,height:14,),
                    const SizedBox(width: 4),
                    Expanded(
                        child:PText(title:'يبدأ من '+salary+' ريال ',fontColor:AppColors.grayShade3,
                          overflow: TextOverflow.ellipsis,
                        )
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: PButton(onPressed:onTap,
                    title:'book_appointment'.tr(),hasBloc:false,isFitWidth:true,size:PSize.text16,
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

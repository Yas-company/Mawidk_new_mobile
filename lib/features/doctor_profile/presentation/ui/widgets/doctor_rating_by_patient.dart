import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/doctor_profile/data/model/doctor_profile_response_model.dart';
import 'package:mawidak/features/doctor_ratings/presentation/ui/widgets/star_rating_widget.dart';

class DoctorRatingByPatient extends StatelessWidget {
  final Ratings ratings;
  const DoctorRatingByPatient({super.key,required this.ratings});

  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.symmetric(horizontal:12,vertical:12),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius:BorderRadius.all(Radius.circular(16))
      ),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start, // Add this
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (ratings.patient?.photo??'').isEmpty?
                    CircleAvatar(radius:25,
                      backgroundColor: AppColors.whiteBackground,
                      child:Icon(Icons.person),):
                    PImage(
                      // source:ratings.patient?.photo??'',
                      source: ApiEndpointsConstants.baseImageUrl+(ratings.patient?.photo??''),
                      isCircle: true, width: 48, height: 48,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top:3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                          children: [
                            PText(
                              title:ratings.patient?.name??'',
                              size: PSize.text14,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, // <--- Handle overflow
                            ),
                            const SizedBox(height: 8),
                            PText(
                              title:ratings.createdAt??'',
                              fontColor: AppColors.grey200,
                              size: PSize.text14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width:14),
              Padding(
                padding: const EdgeInsets.only(top:2),
                child: StarRating(rating: ratings.rate??0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:6),
            child: PText(title:ratings.comment??'',
              size: PSize.text14,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.grayShade3,
            ),
          ),
        ],
      ),
    )
    ;
  }
}

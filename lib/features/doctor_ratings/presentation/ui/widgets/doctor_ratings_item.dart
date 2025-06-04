import 'package:flutter/material.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/doctor_ratings/data/model/doctor_ratings_response_model.dart';
import 'package:mawidak/features/doctor_ratings/presentation/ui/widgets/star_rating_widget.dart';

class DoctorRatingsItem extends StatelessWidget {
  final DoctorRating doctorRating;
  final bool showRating;
  const DoctorRatingsItem({super.key,required this.doctorRating,this.showRating=true});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  (doctorRating.patient?.photo??'').isEmpty?CircleAvatar(radius:28,
                    backgroundColor: AppColors.whiteColor,
                    child:Icon(Icons.person),):PImage(
                    source:ApiEndpointsConstants.baseImageUrl+(doctorRating.patient?.photo??''),
                    isCircle: true,
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                        children: [
                          PText(
                            title:doctorRating.patient?.name??'',
                            size: PSize.text14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // <--- Handle overflow
                          ),
                          const SizedBox(height: 8),
                          PText(
                            title:doctorRating.createdAt??'',
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
           if(showRating) Padding(
              padding: const EdgeInsets.only(top:2),
              child: StarRating(rating:(doctorRating.rating??0)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:6),
          child: PText(
            title:doctorRating.comment??'',
            size: PSize.text14,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.grayShade3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Divider(color: AppColors.grey100),
        ),
      ],
    )
    ;
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String phoneNumber;
  final VoidCallback onTap;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.phoneNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return isDoctor()? Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imageUrl.isEmpty?CircleAvatar(radius:40,
          backgroundColor: AppColors.whiteColor,
          child:Icon(Icons.person),):
        CircleAvatar(
          radius: 40,backgroundColor:Colors.transparent,
          backgroundImage: NetworkImage(imageUrl,),
        ),
        PText(title: userName),
        PText(title: phoneNumber,size:PSize.text14,fontColor:AppColors.grey200),
        const SizedBox(height:6),
        GestureDetector(onTap:() {
          context.push(AppRouter.doctorProfileDetailsScreen,
              extra:SharedPreferenceService().getInt(SharPrefConstants.userId));
        },child: Container(padding:EdgeInsets.symmetric(horizontal:8,vertical:2),decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(25),
            border:Border.all(color:AppColors.primaryColor),
            color:AppColors.shade3.withOpacity(0.6)
          ),child:PText(title:'profile'.tr(),fontColor:AppColors.grayShade3,size:PSize.text13,),),
        )
      ],
    ): Row(
      children: [
        Stack(
          children: [
            imageUrl.isEmpty?CircleAvatar(radius:40,
            backgroundColor: AppColors.whiteColor,
            child:Icon(Icons.person),):
            CircleAvatar(
              radius: 40,backgroundColor:Colors.transparent,
              backgroundImage: NetworkImage(imageUrl,),
            ),
            isArabic()?Positioned(
              bottom: 4, left: 2,
              child: GestureDetector(onTap:onTap,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color:AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit, size: 12,
                    color:Colors.white,
                  ),
                ),
              ),
            ):
            Positioned(
              bottom: 4, right: 2,
              child: GestureDetector(onTap:onTap,child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color:AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit, size: 12,
                    color:Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width:12),
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          PText(title: userName),
          PText(title: phoneNumber,size:PSize.text14,fontColor:AppColors.grey200),
        ],)
      ],
    );
  }
}

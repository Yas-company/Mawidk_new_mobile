import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';

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
    return Row(
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

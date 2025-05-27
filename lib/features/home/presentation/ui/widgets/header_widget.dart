import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key,
         this.icon,
        required this.title,
        this.onClickFavourite,
        this.onClickMore,
        this.hasMore = true,
        this.subTitle});
  final String? icon;
  final String title;
  final String? subTitle;
  final bool hasMore;
  final VoidCallback? onClickFavourite;
  final VoidCallback? onClickMore;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // PImage(source:icon,height:18,),const SizedBox(width:6,),
        PText(
          title: title.tr(),
          size: PSize.text16,
          // fontColor: AppColors.titleColor,
          fontWeight: FontWeight.w700,
        ),
        // if (isFavourite && (isServiceExist(MyServicesEnum.favourite.index+1)))
        if (hasMore)
          InkWell(hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onClickMore,
            child: Container(padding:EdgeInsets.symmetric(horizontal:14,vertical:7),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color:Colors.white),
              child:PText(title: 'more'.tr(),fontColor: AppColors.grey200,
              size:PSize.text14,)
            ),
          ),
      ],
    );
  }
}

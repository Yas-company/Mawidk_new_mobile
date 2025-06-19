import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';


void showDeleteDrugOrNoteBottomSheet({required final VoidCallback onTap,required String name,
bool isDrug = true}) {
  showModalBottomSheet(
    context:navigatorKey.currentState!.context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PText(title:'confirm_delete'.tr(), fontWeight: FontWeight.w700,size:PSize.text16,),
                InkWell(onTap:() {
                  Navigator.pop(context);
                }, child:Icon(Icons.close,color:AppColors.grey200,))
              ],
            ),
            const SizedBox(height: 10),
            isDrug?
            PText(title:'${'delete_drug_question'.tr()}"$name"${isArabic()?'  ؟  ':'  ?  '}',size:PSize.text14,
              fontColor:AppColors.grayShade3,):
            PText(title:'${'confirm_deletion'.tr()}"$name"${isArabic()?'  ؟  ':'  ?  '}',size:PSize.text14,
              fontColor:AppColors.grayShade3,),
            const SizedBox(height: 20),
            Directionality(textDirection:isArabic()?TextDirection.rtl:TextDirection.ltr,
              child: Container(
                  padding:EdgeInsets.symmetric(horizontal:24,vertical:3),
                  decoration:BoxDecoration(borderRadius:BorderRadius.circular(4),
                    color:AppColors.primaryColor200,),
                  child: Row(mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration:BoxDecoration(
                          shape:BoxShape.circle,
                          color:AppColors.primaryColor,
                        ),padding:EdgeInsets.all(8),child:PText(title: '!',fontColor:AppColors.whiteColor,),),
                      const SizedBox(width:10,),
                      PText(title:'not_review'.tr(), size:PSize.text13,),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child:PButton(onPressed:() {
                    Navigator.pop(context);
                    onTap();
                  },title:'confirm_delete'.tr(),fillColor:AppColors.danger,hasBloc:false,),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:PButton(onPressed:() {
                    Navigator.pop(context);
                  },title:'cancel'.tr(),fillColor:AppColors.secondary,hasBloc:false,),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}





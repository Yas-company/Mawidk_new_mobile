import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';

class InformationCompletedWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? image;
  final double? height;
  final Color? subTitleColor;
  const InformationCompletedWidget({super.key, this.title, this.subTitle, this.image,
  this.subTitleColor,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(padding:EdgeInsets.only(top:40,bottom:20,
    left:20,right:20),decoration:BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(width: 3, color:Colors.white),
    ),child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:CrossAxisAlignment.center,children: [
        // PImage(source:AppSvgIcons.successIcon),
        PImage(source:image ?? AppSvgIcons.successIcon,height:height??170,width:height??170,),
        Padding(
          padding: const EdgeInsets.only(top:20,bottom:4),
          child: PText(title:title??'',fontWeight:FontWeight.w700,size:PSize.text18,),
        ),
        // PText(title:'شكراً لك!  سنراجع بياناتك ونقوم بإبلاغك قريباً.', fontColor:AppColors.grey200,),
        if(subTitle==null)PText(title:'تم استكمال بياناتك بنجاح', fontColor:AppColors.primaryColor2,),
        const SizedBox(height:8,),
        Directionality(textDirection: TextDirection.rtl,
          child: Center(
            child: PText(title:subTitle??'معلوماتك تساعدنا في تقييم حالتك الصحية والجسدية بدقة، لنقدّم لك تجربة طبية أكثر تخصيصًا وفعالية داخل التطبيق.”',
              fontColor:AppColors.grey200,size:subTitle!=null?PSize.text16:PSize.text14,
            textDirection:TextDirection.rtl,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:24,bottom:14),
          child: PButton(onPressed:() async {
            Navigator.pop(context);
            if(isDoctor()){
              await getDoctorProfileStatus();
            }
            Get.context!.go(isDoctor()?AppRouter.homeDoctor:AppRouter.homePatient);
          },title:'الانتقال للصفحة الرئيسية',isFitWidth:true,hasBloc:false,fontWeight:FontWeight.w700,
          textColor:AppColors.whiteColor,),
        )
      ],),
    );
  }
}

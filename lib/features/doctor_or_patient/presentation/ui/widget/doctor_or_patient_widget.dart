import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class DoctorOrPatientWidget extends StatelessWidget {
  final String title;
  final String image;
  final void Function()? onChange;
  final Color? color;
  const DoctorOrPatientWidget({super.key,required this.title,required this.image,this.onChange,
  this.color});

  @override
  Widget build(BuildContext context) {
    return Container(width:MediaQuery.sizeOf(context).width*0.26,
      // height:1,
      child: GestureDetector(onTap:() {
        onChange!();
      },child: Container(padding:EdgeInsets.only(bottom:14,top:14),decoration:BoxDecoration(
            color:color!=null?color!:AppColors.whiteColor,
            border:Border.all(color:color!=null?AppColors.primaryColor:Colors.transparent,width:1),
            borderRadius:const BorderRadius.all(Radius.circular(8)),
        ),child:Column(
          children: [
            PImage(source:image,height:48,width:48,),const SizedBox(height:8,),
            PText(title: title,fontColor:AppColors.blackColor,fontWeight:FontWeight.w600,)
          ],
        ),),
      ),
    );
  }
}



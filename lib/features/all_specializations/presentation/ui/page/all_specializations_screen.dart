import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';

class AllSpecializationsScreen extends StatelessWidget {
  const AllSpecializationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(context:context,removeTop:true,
      child: Scaffold(
        backgroundColor: AppColors.whiteBackground,
        appBar: PreferredSize(preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(top:24),
            child: appBar(context: context,backBtn: true,isCenter:true,
              text: 'all_specializations'.tr()),
          ),
        ),
      body:GridView.count(
        crossAxisCount: 4,childAspectRatio:0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: specializations.map((option) {
          return InkWell(onTap:() {
            context.push(AppRouter.doctorsOfSpeciality,extra:{
              'id':option.id??0,
              'specializationName':option.optionText??''
            });
          },child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius:25,
                    backgroundColor:AppColors.primaryColor200,
                    child: PImage(source:option.image??'',width:17, height: 17,
                      color:AppColors.primaryColor,)
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: PText(title:option.optionText??'',
                    size:PSize.text12,alignText:TextAlign.center,),
                ),
              ],
            ),
          );
        }).toList(),
      ),),
    );
  }
}

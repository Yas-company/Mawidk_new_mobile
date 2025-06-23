import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/change_password/data/model/change_password_request_model.dart';
import 'package:mawidak/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:mawidak/features/change_password/presentation/bloc/change_password_event.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordBloc changePasswordBloc = ChangePasswordBloc(changePasswordUseCase:getIt());
    return Scaffold(backgroundColor: AppColors.whiteBackground,
      appBar: appBar(context: context,text: 'change_password'.tr(),backBtn:true,height:50,
      isCenter: true),
      body: BlocProvider(create: (context) => changePasswordBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:24,vertical:16),
          child: Column(mainAxisSize:MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Column(children: [
              const SizedBox(height:20,),
              PTextField(controller:changePasswordBloc.currentPass,labelAbove:'كلمة المرور الحالية',isPassword:true,
                prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor,),
                hintText: 'كلمة المرور', feedback:(value) {
                  changePasswordBloc.add(ApplyValidationEvent());
                }, validator:(value) {
                  if((value??'').isNotEmpty&&value!.length>=6){
                    return null;
                  }
                  return 'يجب أن تتكون كلمة المرور من 6 خانات على الأقل.';
                },),
              const SizedBox(height:16,),
              PTextField(controller:changePasswordBloc.newPass,labelAbove:'new_password'.tr(),isPassword:true,
                prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor,),
                hintText: 'password'.tr(), feedback:(value) {
                  changePasswordBloc.add(ApplyValidationEvent());
                }, validator:(value) {
                  if((value??'').isNotEmpty&&value!.length>=6){
                    return null;
                  }
                  return 'password_error'.tr();
                },),
              const SizedBox(height:16,),
              PTextField(controller:changePasswordBloc.confirmNewPass,labelAbove:'confirm_password'.tr(),isPassword:true,
                prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor,),
                hintText: 'password'.tr(), feedback:(value) {
                  changePasswordBloc.add(ApplyValidationEvent());
                }, validator:(value) {
                  if((value??'').isNotEmpty&&value!.length>=6){
                    if(changePasswordBloc.newPass.text == changePasswordBloc.confirmNewPass.text){
                      return null;
                    }else{
                      return 'password_equal'.tr();
                    }
                  }
                  return 'password_error'.tr();
                },),
            ],),

            Align(alignment:Alignment.bottomCenter,
              child: PButton<ChangePasswordBloc,BaseState>(onPressed:() {
                changePasswordBloc.add(ApplyChangePasswordEvent(model:ChangePasswordRequestModel(
                  currentPassword:changePasswordBloc.currentPass.text,
                  newPassword:changePasswordBloc.newPass.text,
                  newPasswordConfirmation:changePasswordBloc.confirmNewPass.text,
                )));
              },title:'save_changes'.tr(),isFitWidth:true,isFirstButton: true,hasBloc:true,
                isButtonAlwaysExist: false,),
            )
          ],),
        ),
      ),);
  }
}

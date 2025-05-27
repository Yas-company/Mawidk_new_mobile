import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/component/white_background_with_image.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/confirm_password/data/model/confirm_password_request_model.dart';
import 'package:mawidak/features/confirm_password/presentation/bloc/confirm_password_bloc.dart';
import 'package:mawidak/features/confirm_password/presentation/bloc/confirm_password_event.dart';


class ConfirmPasswordScreen extends StatefulWidget {
  final String phone;
  const ConfirmPasswordScreen({super.key,required this.phone});
  @override
  ConfirmPasswordScreenState createState() => ConfirmPasswordScreenState();
}

class ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  ConfirmPasswordBloc confirmPasswordBloc = ConfirmPasswordBloc(confirmPasswordUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => confirmPasswordBloc,
      child: Scaffold(
        backgroundColor:AppColors.whiteBackground,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: WhiteBackgroundWithImage(child:SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                  Align(alignment: Alignment.bottomLeft,
                    child: InkWell(onTap:() {
                      Navigator.pop(context);
                    }, child: Container(padding:EdgeInsets.all(3),
                      child:PImage(source:AppSvgIcons.icNext,color:AppColors.primaryColor,)
                      // Icon(Icons.arrow_forward,color:AppColors.primaryColor,),
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:60),
                    child: PText(title:'تسجيل الدخول',fontColor:AppColors.primaryColor,
                    size:PSize.text28,fontWeight:FontWeight.w700,),
                  ),
                  PText(title:'من فضلك قم بتسجيل الدخول', size:PSize.text16,fontColor: AppColors.grayShade3),
                  // OtpInputScreen(),
                  const SizedBox(height:60,),
                  PTextField(textInputType: TextInputType.text,controller:confirmPasswordBloc.password,labelAbove:'كلمة المرور',
                    isPassword:true,
                    // prefixIcon: Icon(size:20,Icons.lock,color:AppColors.primaryColor,),
                    prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,),
                    hintText: 'كلمة المرور', feedback:(value) {
                      confirmPasswordBloc.add(ValidationEvent());
                    }, validator:(value) {
                      if((value??'').isNotEmpty&&value!.length>=6){
                        return null;
                      }
                      return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
                    },),
                  const SizedBox(height:14,),
                  PTextField(textInputType: TextInputType.text,controller:confirmPasswordBloc.confirmPassword,
                    labelAbove:'تأكيد كلمة المرور',
                    isPassword:true,
                    // prefixIcon: Icon(size:20,Icons.lock,color:AppColors.primaryColor,),
                    prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,),
                    hintText: 'كلمة المرور', feedback:(value) {
                      confirmPasswordBloc.add(ValidationEvent());
                    }, validator:(value) {
                      if((value??'').isNotEmpty&&value!.length>=6){
                        if(confirmPasswordBloc.password.text == confirmPasswordBloc.confirmPassword.text){
                          return null;
                        }else{
                          return 'يجب أن تساوي كلمة المرور تأكيد كلمة المرور';
                        }
                      }
                      return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
                    },),
                  Padding(
                    padding: const EdgeInsets.only(top:14,bottom:10),
                    child: PButton<ConfirmPasswordBloc,BaseState>(onPressed:() {
                      confirmPasswordBloc.add(ApplyConfirmPasswordEvent(confirmPasswordRequestModel:
                      ConfirmPasswordRequestModel(phone:widget.phone,
                        confirmPassword:confirmPasswordBloc.confirmPassword.text,
                          password:confirmPasswordBloc.password.text,)));
                    },title:'حفظ',isFitWidth:true,size:PSize.text16,
                    // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
                      icon:PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,),
                      fontWeight:FontWeight.w700,
                      isFirstButton: true,hasBloc:true,
                      isButtonAlwaysExist: false,),
                  ),
                ],),
              ),
            ),
          ),),
        )
      ),
    );
  }
}




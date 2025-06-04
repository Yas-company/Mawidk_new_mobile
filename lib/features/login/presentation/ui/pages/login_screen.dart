import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/component/white_background_with_image.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/login/data/model/login_request_model.dart';
import 'package:mawidak/features/login/presentation/bloc/login_bloc.dart';
import 'package:mawidak/features/login/presentation/bloc/login_event.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc(loginUseCase: getIt());
  SurveyBloc surveyBloc = SurveyBloc(surveyUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => surveyBloc,
      child: BlocProvider(create:(context) => loginBloc,
        child: Scaffold(
          backgroundColor:AppColors.whiteBackground,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: WhiteBackgroundWithImage(child:SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top:20,left:20,right:20),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                    Padding(
                      padding: const EdgeInsets.only(top:80),
                      child: PText(title:'تسجيل الدخول',fontColor:AppColors.primaryColor,
                      size:PSize.text28,fontWeight:FontWeight.w700,),
                    ),
                    PText(title:'من فضلك قم بتسجيل الدخول', size:PSize.text16,
                    fontColor: AppColors.grayShade3,),
                    // OtpInputScreen(),
                    const SizedBox(height:60,),
                    PTextField(textInputType: TextInputType.number,controller:loginBloc.phone,labelAbove:'رقم الجوال',
                      // prefixIcon: Icon(Icons.phone_in_talk_rounded,color:AppColors.primaryColor,size:20,),
                      prefixIcon:PImage(source:AppSvgIcons.call,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'رقم الجوال', feedback:(value) {
                        loginBloc.add(LoginValidationEvent());
                      }, validator:(value) {
                        final saudiPhoneRegex = RegExp(r'^(009665|9665|\+9665|05)[0-9]{8}$');
                        if (value == null || value.isEmpty) {
                          return 'enter_phone_number'.tr();
                        } else if (!saudiPhoneRegex.hasMatch(value)) {
                          return 'valid_saudi_phone'.tr();
                        }
                        return null;
                      },),
                    const SizedBox(height:14,),
                    PTextField(textInputType: TextInputType.text,
                      controller:loginBloc.password,labelAbove:'كلمة المرور',
                      isPassword:true,
                      // prefixIcon: Icon(Icons.lock,color:AppColors.primaryColor,size:20),
                      prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor,),
                      hintText: 'كلمة المرور', feedback:(value) {
                        loginBloc.add(LoginValidationEvent());
                      }, validator:(value) {
                        if((value??'').isNotEmpty&&value!.length>=6){
                          return null;
                        }
                        return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
                      },),

                    Align(alignment:isArabic()?Alignment.centerLeft:Alignment.centerRight,
                      child: InkWell(onTap:() {
                        Get.context?.push(AppRouter.forgetPassword);
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: PText(title:'نسيت كلمة المرور',fontColor:
                          AppColors.danger,fontWeight:FontWeight.w700,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:14,bottom:10),
                      child: PButton<LoginBloc,BaseState>(onPressed:() {
                        loginBloc.add(NormalLoginEvent(loginRequestModel:
                        LoginRequestModel(phone:loginBloc.phone.text,
                            password:loginBloc.password.text,),
                        // surveyBloc:surveyBloc
                        ));
                      },title:'تسجيل الدخول',hasBloc:true,isFitWidth:true,size:PSize.text16,
                      // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
                        icon:PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,),
                        fontWeight:FontWeight.w700,
                        isFirstButton: true,
                        isButtonAlwaysExist: false,),
                    ),
                    Row(mainAxisSize: MainAxisSize.min,children: [
                      PText(title:'ليس لديك حساب ؟ ',),
                        GestureDetector(
                          onTap: () {
                            Get.context?.push(AppRouter.register);
                            // Get.context?.push(AppRouter.doctorOrPatientScreen);
                          },child:Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                              child: PText(
                                title:'إنشاء حساب',fontColor:AppColors.primaryColor,
                              ),
                            ),
                            Positioned(
                              bottom:5, left: 0,
                              right: 0,
                              child: Container(
                                height: 1,
                                color:AppColors.primaryColor,
                              ),
                            ),
                          ],
                        )

                          // PText(
                          //   title:'إنشاء حساب',fontColor:AppColors.primaryColor,
                          //   decoration: TextDecoration.underline,
                          // ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,)
                  ],),
                ),
              ),
            ),),
          )
        ),
      ),
    );
  }
}




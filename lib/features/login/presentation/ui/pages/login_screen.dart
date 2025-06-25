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
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
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
    loginBloc.allowLocation();
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
                      child: PText(title:'login'.tr(),fontColor:AppColors.primaryColor,
                      size:PSize.text28,fontWeight:FontWeight.w700,),
                    ),
                    PText(title:'please_login'.tr(), size:PSize.text16,
                    fontColor: AppColors.grayShade3,),
                    // OtpInputScreen(),
                    const SizedBox(height:60,),
                    PTextField(isHasSpecialCharcters:true,
                      textInputType: TextInputType.number,controller:loginBloc.phone,
                      labelAbove: 'phone_number'.tr(),
                      // prefixIcon: Icon(Icons.phone_in_talk_rounded,color:AppColors.primaryColor,size:20,),
                      prefixIcon:PImage(source:AppSvgIcons.call,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'phone_number'.tr(), feedback:(value) {
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
                      controller:loginBloc.password,labelAbove:'password'.tr(),
                      isPassword:true,
                      // prefixIcon: Icon(Icons.lock,color:AppColors.primaryColor,size:20),
                      prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor,),
                      hintText:'password'.tr(), feedback:(value) async {
                        await SharedPreferenceService().setString(SharPrefConstants.passwordKey,value??'');
                        loginBloc.add(LoginValidationEvent());
                      }, validator:(value) {
                        if((value??'').isNotEmpty&&value!.length>=6){
                          return null;
                        }
                        return 'password_error'.tr();
                      },),

                    Align(alignment:isArabic()?Alignment.centerLeft:Alignment.centerRight,
                      child: InkWell(onTap:() {
                        Get.context?.push(AppRouter.forgetPassword);
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: PText(title:'password_question'.tr(),fontColor:
                          AppColors.danger,fontWeight:FontWeight.w700,),
                        ),
                      ),
                    ),
                    CustomCheckboxWithText(
                      isChecked: loginBloc.isChecked,
                      onChanged: (value) {
                        setState(() {
                          loginBloc.isChecked = value!;
                        });
                        loginBloc.add(LoginValidationEvent());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:14,bottom:10),
                      child: PButton<LoginBloc,BaseState>(onPressed:() {
                        loginBloc.add(NormalLoginEvent(loginRequestModel:
                        LoginRequestModel(phone:loginBloc.phone.text,
                            password:loginBloc.password.text,),
                        // surveyBloc:surveyBloc
                        ));
                      },title:'login'.tr(),hasBloc:true,isFitWidth:true,size:PSize.text16,
                      // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
                        icon:PImage(source:isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,height:14,fit:BoxFit.scaleDown,),
                        fontWeight:FontWeight.w700,
                        isFirstButton: true,
                        isButtonAlwaysExist: false,),
                    ),
                    Row(mainAxisSize: MainAxisSize.min,children: [
                      PText(title:'have_account'.tr(),),
                        GestureDetector(
                          onTap: () {
                            Get.context?.push(AppRouter.register);
                            // Get.context?.push(AppRouter.doctorOrPatientScreen);
                          },child:Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                              child: PText(
                                title:'create_account'.tr(),fontColor:AppColors.primaryColor,
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top:20),
                    //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    //     TextButton(onPressed:() {
                    //       context.push(AppRouter.privacyPolicyScreen,extra:1);
                    //     }, child:PText(title:'privacy'.tr())),
                    //     TextButton(onPressed:() {
                    //       context.push(AppRouter.privacyPolicyScreen,extra:2);
                    //     }, child:PText(title:'usage_conditions'.tr()))
                    //   ],),
                    // ),
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






class CustomCheckboxWithText extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxWithText({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10,),
      child: ListTileTheme(horizontalTitleGap: 4.0,
        child: CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: isChecked,
          activeColor: AppColors.primaryColor,
          onChanged: onChanged,
          title: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _plainText('usage'.tr()),
              _linkText('usage1'.tr(), onTap: () => Get.context?.push(AppRouter.privacyPolicyScreen,extra:1)),
              _plainText('usage2'.tr()),
              _linkText('usage3'.tr(), onTap: () => Get.context?.push(AppRouter.privacyPolicyScreen,extra:2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _plainText(String text) {
    return PText(title: text,size:PSize.text16,);
  }

  Widget _linkText(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child:Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
            child: PText(
              title:text,fontColor:AppColors.primaryColor,
              size:PSize.text16,
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
    );
  }
}





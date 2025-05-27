import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/component/white_background_with_image.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/register/data/model/register_request_model.dart';
import 'package:mawidak/features/register/presentation/bloc/register_bloc.dart';
import 'package:mawidak/features/register/presentation/bloc/register_event.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc registerBloc = RegisterBloc(registerUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => registerBloc,
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
                    Align(alignment: Alignment.bottomLeft,
                      child: InkWell(onTap:() {
                        Navigator.pop(context);
                      }, child: Container(padding:EdgeInsets.all(3),
                        child:PImage(source:AppSvgIcons.icNext,color:AppColors.primaryColor,)
                        // child:Icon(Icons.arrow_forward,color:AppColors.primaryColor,)
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:60),
                      child: PText(title:'انشاء حساب',fontColor:AppColors.primaryColor,
                        size:PSize.text28,fontWeight:FontWeight.w700,),
                    ),
                    PText(title:'من فضلك قم بانشاء حساب', size:PSize.text16,fontColor: AppColors.grayShade3),
                    const SizedBox(height:60,),
                    PTextField(textInputAction:TextInputAction.next,controller:registerBloc.phone,
                      labelAbove:'رقم الجوال',textInputType: TextInputType.number,
                      prefixIcon:PImage(source:AppSvgIcons.call,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      // prefixIcon: Icon(size:20,Icons.phone_in_talk_rounded,color:AppColors.primaryColor,),
                      hintText: '05XXXXXXX', feedback:(value) {
                        registerBloc.add(ValidationEvent());
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
                    PTextField(textInputAction:TextInputAction.next,textInputType: TextInputType.text,controller:registerBloc.name,
                      labelAbove:'اسم المستخدم',
                      prefixIcon:PImage(source:AppSvgIcons.user,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      // prefixIcon: Icon(size:20,Icons.person,color:AppColors.primaryColor,),
                      hintText: 'اسم المستخدم', feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) => null,),
                    const SizedBox(height:14,),
                    PTextField(textInputAction:TextInputAction.next,isEmail:true,isOptional:true,textInputType: TextInputType.emailAddress,controller:registerBloc.email,
                      labelAbove:'البريد الالكتروني',
                      prefixIcon:PImage(source:AppSvgIcons.mail,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      // prefixIcon: Icon(Icons.email_rounded,size:20,color:AppColors.primaryColor,),
                      hintText: 'Example@mail.com', feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) {
                        if (value == null || value.trim().isEmpty) return null; // OK if empty
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'valid_email'.tr();
                        }
                        return null;
                      },),
                    const SizedBox(height:14,),
                    PTextField(textInputAction:TextInputAction.next,textInputType: TextInputType.text,controller:registerBloc.password,labelAbove:'كلمة المرور',
                      isPassword:true,
                      // prefixIcon:PImage(source:AppIcons.icLock,width:20,height:20,fit:BoxFit.scaleDown,),
                      // prefixIcon: Icon(size:20,Icons.lock,color:AppColors.primaryColor,),
                      prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'كلمة المرور', feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) {
                        if((value??'').isNotEmpty&&value!.length>=6){
                          return null;
                        }
                        return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
                      },),
                    const SizedBox(height:14,),
                    PTextField(textInputType: TextInputType.text,controller:registerBloc.confirmPassword,
                      labelAbove:'تأكيد كلمة المرور',
                      isPassword:true,
                      // prefixIcon: Icon(size:20,Icons.lock,color:AppColors.primaryColor,),
                      prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'كلمة المرور', feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) {
                        if((value??'').isNotEmpty&&value!.length>=6){
                          if(registerBloc.password.text == registerBloc.confirmPassword.text){
                            return null;
                          }else{
                            return 'يجب أن تساوي كلمة المرور تأكيد كلمة المرور';
                          }
                        }
                        return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';
                      },),
                    const SizedBox(height:14,),
                    Padding(
                      padding: const EdgeInsets.only(top:14,bottom:10),
                      child: PButton<RegisterBloc,BaseState>(onPressed:() {
                        registerBloc.add(AddRegisterEvent(registerRequestModel:
                        RegisterRequestModel(name:registerBloc.name.text,
                            phone:registerBloc.phone.text,
                            password:registerBloc.password.text,
                            type:3,countryCode:'+20')));
                      },title:'انشاء حساب',hasBloc:true,isFitWidth:true,size:PSize.text16,
                        // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
                        icon:PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,),
                        fontWeight:FontWeight.w700,
                        isFirstButton: true,
                        isButtonAlwaysExist: false,),
                    ),
                    Row(children: [
                      PText(title:'لديك حساب ؟ ',),
                      GestureDetector(
                        onTap: () {
                          Get.context?.push(AppRouter.login);
                        },child:
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                            child: PText(
                              title:'تسجيل الدخول',fontColor:AppColors.primaryColor,
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
                      //   title:'تسجيل الدخول',fontColor:AppColors.primaryColor,
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
    );
  }
}




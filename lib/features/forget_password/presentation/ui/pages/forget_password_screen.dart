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
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/forget_password/data/model/forget_password_request_model.dart';
import 'package:mawidak/features/forget_password/presentation/bloc/forget_password_bloc.dart';
import 'package:mawidak/features/forget_password/presentation/bloc/forget_password_event.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordBloc forgetPasswordBloc = ForgetPasswordBloc(forgetPasswordUseCase:getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => forgetPasswordBloc,
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
                        // Icon(Icons.arrow_forward,color:AppColors.primaryColor,)
                        ,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:60),
                      child: PText(title:'هل نسيت كلمة المرور؟',fontColor:AppColors.primaryColor,
                        size:PSize.text28,fontWeight:FontWeight.w700,),
                    ),
                    PText(title:'من فضلك قم بادخال رقم الهاتف لاعادة تعيين كلمة المرور', size:PSize.text16,
                        fontColor: AppColors.grayShade3),
                    const SizedBox(height:60,),
                    PTextField(textInputType:TextInputType.number,controller:forgetPasswordBloc.phone,labelAbove:'رقم الجوال',
                      // prefixIcon: Icon(size:20,Icons.phone_in_talk_rounded,color:AppColors.primaryColor,),
                      prefixIcon:PImage(source:AppSvgIcons.call,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'رقم الجوال', feedback:(value) {
                        forgetPasswordBloc.add(ValidationEvent());
                      }, validator:(value) => null,),
                    const SizedBox(height:14,),

                    Padding(
                      padding: const EdgeInsets.only(top:14,bottom:10),
                      child: PButton<ForgetPasswordBloc,BaseState>(onPressed:() {
                        forgetPasswordBloc.add(ApplyForgetPasswordEvent(forgetPasswordRequestModel:
                        ForgetPasswordRequestModel(phone:forgetPasswordBloc.phone.text)));
                      },title:'التالي',isFitWidth:true,size:PSize.text16,
                        icon:PImage(source:AppSvgIcons.icNext,height:14,fit:BoxFit.scaleDown,),
                        fontWeight:FontWeight.w700,
                        // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
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




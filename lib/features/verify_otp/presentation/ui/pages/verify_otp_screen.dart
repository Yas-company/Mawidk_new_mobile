import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/p_otp.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/white_background_with_image.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/login/data/model/login_request_model.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:mawidak/features/verify_otp/data/model/verify_otp_request_model.dart';
import 'package:mawidak/features/verify_otp/presentation/bloc/verify_otp_bloc.dart';
import 'package:mawidak/features/verify_otp/presentation/bloc/verify_otp_event.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;
  final bool isLogin;
  const VerifyOtpScreen({super.key,required this.phone,required this.isLogin});

  @override
  VerifyOtpScreenState createState() => VerifyOtpScreenState();
}

class VerifyOtpScreenState extends State<VerifyOtpScreen> {
  VerifyOtpBloc verifyOtpBloc = VerifyOtpBloc(verifyOtpUseCase:getIt());
  SurveyBloc surveyBloc = SurveyBloc(surveyUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => surveyBloc,
      child: BlocProvider(create:(context) => verifyOtpBloc,
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
                        child: PText(title:'enter_otp'.tr(),fontColor:AppColors.primaryColor,
                          size:PSize.text28,fontWeight:FontWeight.w700,),
                      ),
                      PText(title:'otp_please'.tr(), size:PSize.text16,
                          fontColor: AppColors.grayShade3),
                      // OtpInputScreen(),
                      const SizedBox(height:60,),
                      PText(title:'second_password'.tr(), size:PSize.text14),

                      const SizedBox(height:14,),
                      OtpTextField(
                        autoFocus:true,
                        numberOfFields:4,textStyle:
                        TextStyle(fontSize:18,fontWeight:FontWeight.w600,
                            fontFamily:'cairo'),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {
                          verifyOtpBloc.add(ValidationEvent(code:code));
                        }, onSubmit: (String verificationCode){
                          verifyOtpBloc.add(ValidationEvent(code:verificationCode));
                        }, // end onSubmit
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:14,bottom:10),
                        child: PButton<VerifyOtpBloc,BaseState>(onPressed:() {
                          verifyOtpBloc.add(ApplyVerifyOtpEvent(verifyOtpRequestModel:VerifyOtpRequestModel(
                            phone:widget.phone,otp:verifyOtpBloc.otp.text),
                          isLogin:widget.isLogin,
                          // surveyBloc: surveyBloc
                          ));
                        },title:'',hasBloc:true,isFitWidth:true,size:PSize.text16,
                          // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
                          icon:PImage(source:isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,height:14,fit:BoxFit.scaleDown,),
                          fontWeight:FontWeight.w700,
                          isFirstButton: true,
                          isButtonAlwaysExist: false,),
                      ),
                      Row(children: [
                        PText(title:'msg_not_sent'.tr(),),
                        BlocListener<VerifyOtpBloc,BaseState>(listener: (context, state) {
                          if(state is LoadingState){
                            loadDialog();
                          }else if(state is LoadedState){
                            hideLoadingDialog();
                            SafeToast.show(message:'resent_success'.tr());
                          }else if(state is ErrorState){
                            hideLoadingDialog();
                          }
                        },child:GestureDetector(
                            onTap: () {
                              verifyOtpBloc.add(ReSendOtpEvent(loginRequestModel:LoginRequestModel(
                                  type:isDoctor()?UserType.doctor.index :UserType.patient.index,
                                  phone:widget.phone,
                                  password:SharedPreferenceService().getString(SharPrefConstants.passwordKey)
                              )));
                            },child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                              child: PText(
                                title:'resend'.tr(),fontColor:AppColors.primaryColor,
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
                          //   title:'اعادة ارسال',fontColor:AppColors.primaryColor,
                          //   decoration: TextDecoration.underline,
                          // ),
                        ),),
                      ],
                      )
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

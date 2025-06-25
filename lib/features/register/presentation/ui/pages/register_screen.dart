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
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/login/presentation/ui/pages/login_screen.dart';
import 'package:mawidak/features/register/data/model/register_request_model.dart';
import 'package:mawidak/features/register/presentation/bloc/register_bloc.dart';
import 'package:mawidak/features/register/presentation/bloc/register_event.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';

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
                      child: PText(title:'create_account'.tr(),fontColor:AppColors.primaryColor,
                        size:PSize.text28,fontWeight:FontWeight.w700,),
                    ),
                    PText(title:'please_create_account'.tr(), size:PSize.text16,fontColor: AppColors.grayShade3),
                    const SizedBox(height:20,),

                    GenderSelection(
                      selectedValue:registerBloc.selectedOption,
                      options:[
                      Option(id:1,optionText:'male'.tr()),Option(id:2,optionText:'female'.tr())],
                    onChanged:(gender) {
                        setState(() {
                          registerBloc.selectedOption = gender;
                        });
                      registerBloc.sex = (gender as Option).optionText??'';
                      registerBloc.add(ValidationEvent());
                    },),

                    const SizedBox(height:20,),
                    PTextField(isHasSpecialCharcters:true,
                      textInputAction:TextInputAction.next,controller:registerBloc.phone,
                      labelAbove:'phone_number'.tr(),textInputType: TextInputType.number,
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
                    PTextField(
                      isHasSpecialCharcters:true,
                      textInputAction:TextInputAction.next,textInputType: TextInputType.text,controller:registerBloc.name,
                      labelAbove:'user_name'.tr(),
                      prefixIcon:PImage(source:AppSvgIcons.user,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      // prefixIcon: Icon(size:20,Icons.person,color:AppColors.primaryColor,),
                      hintText: 'user_name'.tr(), feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) => null,),
                    const SizedBox(height:14,),
                    PTextField( isHasSpecialCharcters:true,textInputAction:TextInputAction.next,isEmail:true,
                      isOptional:true,textInputType: TextInputType.emailAddress,controller:registerBloc.email,
                      labelAbove:'email'.tr(),
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
                    PTextField(textInputAction:TextInputAction.next,textInputType: TextInputType.text,
                      controller:registerBloc.password,labelAbove:'password'.tr(),
                      isPassword:true,
                      // prefixIcon:PImage(source:AppIcons.icLock,width:20,height:20,fit:BoxFit.scaleDown,),
                      // prefixIcon: Icon(size:20,Icons.lock,color:AppColors.primaryColor,),
                      prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'password'.tr(), feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) {
                        if((value??'').isNotEmpty&&value!.length>=6){
                          return null;
                        }
                        return 'password_error'.tr();
                      },),
                    const SizedBox(height:14,),
                    PTextField(textInputType: TextInputType.text,controller:registerBloc.confirmPassword,
                      labelAbove:'confirm_password'.tr(),
                      isPassword:true,
                      // prefixIcon: Icon(size:20,Icons.lock,color:AppColors.primaryColor,),
                      prefixIcon:PImage(source:AppSvgIcons.lock,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                      hintText: 'password'.tr(), feedback:(value) {
                        registerBloc.add(ValidationEvent());
                      }, validator:(value) {
                        if((value??'').isNotEmpty&&value!.length>=6){
                          if(registerBloc.password.text == registerBloc.confirmPassword.text){
                            return null;
                          }else{
                            return 'password_equal'.tr();
                          }
                        }
                        return 'password_error'.tr();
                      },),
                    const SizedBox(height:14,),
                    CustomCheckboxWithText(
                      isChecked: registerBloc.isChecked,
                      onChanged: (value) {
                        setState(() {
                          registerBloc.isChecked = value!;
                        });
                        registerBloc.add(ValidationEvent());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:14,bottom:10),
                      child: PButton<RegisterBloc,BaseState>(onPressed:() {
                        registerBloc.add(AddRegisterEvent(registerRequestModel:
                        RegisterRequestModel(name:registerBloc.name.text,
                            phone:registerBloc.phone.text,
                            password:registerBloc.password.text,
                            type:3,countryCode:'+20')));
                      },title:'create_account'.tr(),hasBloc:true,isFitWidth:true,size:PSize.text16,
                        // icon:Icon(Icons.arrow_forward,color:AppColors.whiteColor,),
                        icon:PImage(source:isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,height:14,fit:BoxFit.scaleDown,),
                        fontWeight:FontWeight.w700,
                        isFirstButton: true,
                        isButtonAlwaysExist: false,),
                    ),
                    Row(children: [
                      PText(title:'have_account2'.tr(),),
                      GestureDetector(
                        onTap: () {
                          Get.context?.push(AppRouter.login);
                        },child:
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                            child: PText(
                              title:'login'.tr(),fontColor:AppColors.primaryColor,
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
    );
  }
}


//
// class GenderSelection extends StatefulWidget {
//   final void Function(String gender)? onChanged;
//   const GenderSelection({super.key, this.onChanged});
//
//   @override
//   State<GenderSelection> createState() => _GenderSelectionState();
// }
//
// class _GenderSelectionState extends State<GenderSelection> {
//   String? selectedGender;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         PText(title: 'select_gender'.tr(),),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             _buildGenderOption(
//               icon: Icons.male,
//               label: 'male'.tr(),
//               gender: 'male',
//             ),
//             const SizedBox(width: 12),
//             _buildGenderOption(
//               icon: Icons.female,
//               label: 'female'.tr(),
//               gender: 'female',
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildGenderOption({
//     required IconData icon,
//     required String label,
//     required String gender,
//   }) {
//     final isSelected = selectedGender == gender;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => _selectGender(gender),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             children: [
//               Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 32),
//               const SizedBox(height: 4),
//               PText(title: label)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _selectGender(String gender) {
//     setState(() {
//       selectedGender = gender;
//     });
//     widget.onChanged?.call(gender);
//   }
// }



class GenderSelection extends StatelessWidget {
  final List<Option> options;
  final dynamic selectedValue;
  final ValueChanged<dynamic>? onChanged;
  const GenderSelection({super.key,required this.options,this.onChanged,
    this.selectedValue,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:14),
      child:Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PText(title:'gender'.tr(),size:PSize.text14,),
          const SizedBox(height:10,),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: options.map((item) {
              final isSelected = item.optionText == (selectedValue is Option
                  ? (selectedValue as Option).optionText
                  : selectedValue);
              return InkWell(splashColor:Colors.transparent,
                focusColor:Colors.transparent,
                highlightColor:Colors.transparent,
                hoverColor:Colors.transparent,
                onTap: () {
                  onChanged?.call(item);
                },child: Container(
                  padding: const EdgeInsets.symmetric(vertical:14, horizontal:30),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor100 : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryColor : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      if(item.optionText=='male'.tr())Padding(
                        padding: EdgeInsets.only(bottom:4),
                        child: PImage(source:AppIcons.male,fit: BoxFit.scaleDown,
                        width:20,height:20,),
                      ),
                      if(item.optionText=='female'.tr()||item.optionText.toString().contains('female'.tr()))Padding(
                        padding: const EdgeInsets.only(bottom:4),
                        child: PImage(source:AppIcons.female,width:20,height:20,),
                      ),
                      PText(
                        title: item.optionText??'',
                        size: PSize.text14,
                        fontWeight:(item.optionText=='female'.tr()||item.optionText.toString().contains('female'.tr())
                            ||item.optionText=='male'.tr())?FontWeight.w600:FontWeight.w400,
                        fontColor:(item.optionText=='female'.tr()||item.optionText.toString().contains('female'.tr())
                            ||item.optionText=='male'.tr())?
                        AppColors.fontColor:
                        (isSelected? AppColors.fontColor:AppColors.grey200),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      )
    );
  }
}
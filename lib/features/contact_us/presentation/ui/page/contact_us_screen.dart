import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
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
import 'package:mawidak/features/contact_us/presentation/bloc/contact_us_bloc.dart';
import 'package:mawidak/features/contact_us/presentation/bloc/contact_us_event.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  ContactUsScreenState createState() => ContactUsScreenState();
}

class ContactUsScreenState extends State<ContactUsScreen> {
  ContactUsBloc contactUsBloc = ContactUsBloc(contactUsUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => contactUsBloc,
      child: MediaQuery.removePadding(
        context: context, removeTop: true,
        child: Scaffold(extendBodyBehindAppBar:false,
          appBar:PreferredSize(preferredSize:Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.only(top:20),
                child: appBar(context: context,text:'contact_us'.tr(),isCenter:true),
              )),
            backgroundColor:AppColors.whiteBackground,
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top:20,left:20,right:20),
                  child: SingleChildScrollView(
                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                      PTextField(textInputAction:TextInputAction.next,controller:contactUsBloc.phone,labelAbove:'رقم الجوال',
                        prefixIcon:PImage(source:AppSvgIcons.call,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                        // prefixIcon: Icon(size:20,Icons.phone_in_talk_rounded,color:AppColors.primaryColor,),
                        hintText: '05XXXXXXX', feedback:(value) {
                          contactUsBloc.add(ApplyValidationEvent());
                        }, validator:(value) {
                          final saudiPhoneRegex = RegExp(r'^(009665|9665|\+9665|05)[0-9]{8}$');
                          if (value == null || value.isEmpty) {
                            return 'enter_phone_number'.tr();
                          } else if (!saudiPhoneRegex.hasMatch(value)) {
                            return 'valid_saudi_phone'.tr();
                          }
                          contactUsBloc.model.phone = value;
                          return null;
                        },),
                      const SizedBox(height:14,),
                      PTextField(textInputAction:TextInputAction.next,isEmail:true,isOptional:true,
                        textInputType: TextInputType.emailAddress,controller:contactUsBloc.email,
                        labelAbove:'البريد الالكتروني',
                        prefixIcon:PImage(source:AppSvgIcons.mail,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                        // prefixIcon: Icon(Icons.email_rounded,size:20,color:AppColors.primaryColor,),
                        hintText: 'Example@mail.com', feedback:(value) {
                          contactUsBloc.model.email = value;
                          contactUsBloc.add(ApplyValidationEvent());
                        }, validator:(value) {
                          if (value == null || value.trim().isEmpty) return null; // OK if empty
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'valid_email'.tr();
                          }
                          return null;
                        },),
                      const SizedBox(height:14,),
                      PTextField(maxLines:4,labelAbove:'msg'.tr(),
                        controller:contactUsBloc.message,hintText:'type_msg'.tr(), feedback:(value) {
                          contactUsBloc.model.message = value;
                        contactUsBloc.add(ApplyValidationEvent());
                      },)
                    ],),
                  ),
                ),
              ),
            ),
          bottomNavigationBar: SizedBox(height:88,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical:16),
              child: PButton<ContactUsBloc,BaseState>(title:'send'.tr(),onPressed:() {
                print('widget.model>>'+jsonEncode(contactUsBloc.model));
                contactUsBloc.add(ApplyContactUsEvent(model: contactUsBloc.model));
              },isFirstButton: true,hasBloc:true,
                  isButtonAlwaysExist: false,isFitWidth:true,
                  icon:PImage(source:
                  isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,
                    height:14,fit:BoxFit.scaleDown,)),
            ),
          ),
        ),
      ),
    );
  }
}




import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/edit_personal_info/data/model/edit_personal_info_request_model.dart';
import 'package:mawidak/features/edit_personal_info/presentation/bloc/edit_personal_info_bloc.dart';
import 'package:mawidak/features/edit_personal_info/presentation/bloc/edit_personal_info_event.dart';

class EditPersonalInfoScreen extends StatelessWidget {
  final String phone;
  final String name;
  const EditPersonalInfoScreen({super.key,required this.phone,required this.name});

  @override
  Widget build(BuildContext context) {
    EditPersonalInfoBloc editPersonalInfoBloc = EditPersonalInfoBloc(editPersonalInfoUseCase: getIt());
    editPersonalInfoBloc.add(GetProfileEvent());
    // editPersonalInfoBloc.phone.text = phone;
    // editPersonalInfoBloc.name.text = name;
    return BlocProvider(
      create: (_) => editPersonalInfoBloc,
      child:Scaffold(
        backgroundColor: AppColors.whiteBackground,
        appBar: appBar(
          context: context,
          text: 'تعديل البيانات الشخصية',
          backBtn: true,
          height: 50,
          isCenter: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: BlocConsumer<EditPersonalInfoBloc,BaseState>(listener:(context, state) {
            if(state is LoadingState){
              loadDialog();
            }else if(state is LoadedState || state is ErrorState){
              hideLoadingDialog();
            }
          },builder:(context, state) {
            return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    PTextField(
                      controller: editPersonalInfoBloc.name,
                      labelAbove: 'اسم المستخدم ',
                      prefixIcon: PImage(
                        source: AppSvgIcons.user,
                        fit: BoxFit.scaleDown,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'اسم المستخدم',
                      feedback:(value) {
                        editPersonalInfoBloc.name.text = value??'';
                        editPersonalInfoBloc.add(ApplyValidationEvent());
                      },
                      validator: (value) {
                        if ((value ?? '').isNotEmpty && value!.length <= 50) {
                          return null;
                        }
                        return 'يرجي التاكد من الاسم';
                      },
                    ),
                    const SizedBox(height: 16),
                    PTextField(
                      initialText: phone,
                      controller: editPersonalInfoBloc.phone,
                      enabled: false,
                      labelAbove: 'رقم الجوال',
                      textInputType: TextInputType.number,
                      prefixIcon: PImage(
                        source: AppSvgIcons.call,
                        fit: BoxFit.scaleDown,
                        color: AppColors.primaryColor,
                      ),
                      hintText: '05XXXXXXX',
                      feedback:(value) {
                        editPersonalInfoBloc.phone.text = value??'';
                        editPersonalInfoBloc.add(ApplyValidationEvent());
                      },
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 16),
                    PTextField(
                      controller: editPersonalInfoBloc.email,
                      labelAbove: 'البريد الالكتروني ',
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: PImage(
                        source: AppSvgIcons.mail,
                        fit: BoxFit.scaleDown,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'البريد الالكتروني ',
                      feedback:(value) {
                        editPersonalInfoBloc.add(ApplyValidationEvent());
                      },
                      validator:(value) {
                        if (value == null || value.trim().isEmpty) return null; // OK if empty
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'valid_email'.tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child:PButton<EditPersonalInfoBloc,BaseState>(title:'save_changes'.tr(),onPressed:() {
                      editPersonalInfoBloc.add(ApplyEditPersonalInfoEvent(
                        model: EditPersonalInfoRequestModel(
                          name: editPersonalInfoBloc.name.text,
                          email: editPersonalInfoBloc.email.text,
                        ),
                      ));
                    },isFirstButton: true,hasBloc:true,isButtonAlwaysExist: false,isFitWidth:true)
                ),
              ],
            );
          },)
        ),
      )
    );
  }
}


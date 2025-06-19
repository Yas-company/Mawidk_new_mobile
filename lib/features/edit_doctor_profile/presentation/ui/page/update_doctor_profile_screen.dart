import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_drop_down/p_drop_down.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/doctor_profile/data/model/doctor_profile_response_model.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_request_model.dart';
import 'package:mawidak/features/doctor_profile/presentation/bloc/doctor_profile_bloc.dart';
import 'package:mawidak/features/doctor_profile/presentation/bloc/doctor_profile_event.dart';
import 'package:mawidak/features/doctor_profile/presentation/ui/widgets/doctor_rating_by_patient.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/adding_text_filed_widget.dart';

class UpdateDoctorProfileScreen extends StatefulWidget {
  final DoctorModel model;
  const UpdateDoctorProfileScreen({super.key,required this.model});
  @override
  State<UpdateDoctorProfileScreen> createState() => UpdateDoctorProfileScreenState();
}

class UpdateDoctorProfileScreenState extends State<UpdateDoctorProfileScreen> {
  String? location,specialization;
  int? cityId,specializationId;
  late List<Subspeciality> subSpecialities = widget.model.subspecialities??[];
  late List<String> selectedSpecializationValues = subSpecialities.map((e) => e.name).toList();
  late TextEditingController nameController = TextEditingController(text:widget.model.name??'');
  late TextEditingController aboutDoctorController = TextEditingController(text:widget.model.aboutDoctor??'');
  late TextEditingController licenceNumberController = TextEditingController(text:widget.model.aboutDoctor??'');
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context, removeTop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          backgroundColor:AppColors.whiteBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:24),
              child: appBar(context: context,backBtn: true,text:'edit_profile'.tr(),isCenter:true),
            ),
          ),
          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal:24),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                const SizedBox(height:14,),
                PTextField(textInputAction:TextInputAction.next,textInputType:
                TextInputType.text,controller:nameController,
                  labelAbove:'name'.tr(),
                  prefixIcon:PImage(source:AppSvgIcons.user,fit:BoxFit.scaleDown,color:AppColors.primaryColor),
                  hintText: 'name'.tr(), feedback:(value) {
              
                  }, validator:(value) => null,),
                PDropDown(borderColor:AppColors.primaryColor3300,
                  fillColor: Colors.white,borderRadius:8,
                  hintText:isArabic()?'اختر التخصص':'',keyValue:'optionText',
                  label:'specialization'.tr(),isSpecializations:true,options: specializations.map((option) => {
                  'id': option.id,
                  'optionText': option.optionText,
                  'optionTextEn': option.optionTextEn,
                  'image': option.image,
                }).toList(),onChange:(value) {
                  specialization = value?['optionText'];
                  specializationId = value?['id'];
                  setState(() {});
                },),
              
                TagInputWidget(isTrue:true,
                  showTrueFalse: false,
                  showDivider:false,
                  hint:'accurate_special'.tr(),
                  title:'accurate_special'.tr(),
                  selectedValues: selectedSpecializationValues,
                  onAnswer:(value) {},
                  onChanged: (value) {
                    setState(() {
                      selectedSpecializationValues = List<String>.from(value);
                    });
                  },
                ),

                Container(width:MediaQuery.sizeOf(context).width*0.50,
                  margin:EdgeInsets.only(top:10),
                  child: PTextField(controller:licenceNumberController,labelAbove:'enter_licence_number'.tr(),
                    hintText:'licence_number'.tr(),feedback:(value) {

                  },),
                ),

                PTextField(controller:aboutDoctorController,hintText:'about_doctor'.tr(),labelAbove:'about_doctor'.tr(),
                    maxLines:4,
                    feedback: (value) {

                    },),
                const SizedBox(height:500,)
                ],
              ),
            ),
          ),
        floatingActionButton:Padding(
          padding: const EdgeInsets.only(left:24,right:24,bottom:24),
          child: PButton(isFitWidth:true,onPressed:() {

          },title:'save'.tr(),hasBloc:false,),
        ),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/drop_down_widget.dart';
import 'package:mawidak/features/survey/presentation/ui/widgets/patient_widgets/radio_button_widget.dart';

class CompletePatientProfileScreen extends StatefulWidget {
  const CompletePatientProfileScreen({super.key});

  @override
  State<CompletePatientProfileScreen> createState() => CompletePatientProfileScreenState();
}
class CompletePatientProfileScreenState extends State<CompletePatientProfileScreen> {
  TextEditingController birthDateController = TextEditingController();
  Option? medicalAnswer;
  Option? companyAnswer;
  final List<Option> insuranceCompanies = [
    Option(id: 1, optionText: 'بوبا العربية'),
    Option(id: 2, optionText: 'التعاونية للتأمين'),
    Option(id: 3, optionText: 'شركة ملاذ للتأمين'),
    Option(id: 4, optionText: 'شركة ميدغلف للتأمين'),
    Option(id: 5, optionText: 'شركة الجزيرة تكافل'),
    Option(id: 6, optionText: 'شركة الصقر للتأمين'),
    Option(id: 7, optionText: 'شركة وفا للتأمين'),
    Option(id: 8, optionText: 'شركة أليانز السعودي الفرنسي'),
    Option(id: 9, optionText: 'شركة سوليدرتي السعودية'),
    Option(id: 10, optionText: 'شركة أمانة للتأمين'),
    Option(id: 11, optionText: 'شركة سلامة للتأمين'),
    Option(id: 12, optionText: 'شركة بروج للتأمين'),
  ];
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,removeTop: true,
      child: Scaffold(
          backgroundColor:AppColors.whiteBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:24),
              child: appBar(context: context,backBtn: true,
                  text:'complete_info'.tr(),isCenter:true),
            ),
          ),
          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal:24),
            child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              PTextField(textInputAction:TextInputAction.next,isEmail:true,
                textInputType: TextInputType.emailAddress,
                labelAbove:'email'.tr(),
                hintText: 'Example@mail.com', feedback:(value) {
                  // registerBloc.add(ValidationEvent());
                }, validator:(value) {
                  if (value == null || value.trim().isEmpty) return null; // OK if empty
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'valid_email'.tr();
                  }
                  return null;
                },),

              const SizedBox(height:16),

              InkWell(onTap:() async {
                DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );
                if (date != null) {
                  // birthDateController.text = '${date.year}-${date.month}-${date.day}';
                  birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
                  setState(() {});
                }
              },child: PTextField(controller:birthDateController,enabled:false,
                  labelAbove:'birth_date'.tr(),hintText:'hint_date'.tr(),
                feedback:(value) {

                },disabledBorderColor:Colors.transparent),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8,top:10),
                child: Divider(color:AppColors.grey100,),
              ),

              PText(title:'medical_insurance'.tr(),fontColor:AppColors.primaryColor,fontWeight:FontWeight.w700,),
              CustomRadioButtonWidget(
                label:'have_medical_insurance'.tr(),
                options:[Option(id:0,optionText:'yes'.tr()),Option(id:0,optionText:'no'.tr())],
                selectedValue: medicalAnswer ?? '',
                onChanged: (val) {
                  setState(() {
                    medicalAnswer = val;
                  });
                },
              ),

              DropDownWidgetOne(hint:'please_choose_insurance_company'.tr(),
                title:'insurance_company'.tr(),
                showCheckbox:false,
                options:insuranceCompanies,
                selectedValue : companyAnswer,
                onChanged: (value) {
                  setState(() {
                    companyAnswer = value;
                    // q.answer ??= [];
                    // q.answer.clear();
                    // q.answer.addAll(value);
                  });
                },
              ),
              const SizedBox(height:16),
              PTextField(
                fillColor: AppColors.grey100,
                textInputAction:TextInputAction.next,isEmail:true,
                textInputType: TextInputType.emailAddress,
                labelAbove:'insurance_number'.tr(),
                hintText: 'hint_insurance_number'.tr(), feedback:(value) {
                  // registerBloc.add(ValidationEvent());
                }, validator:(value) {
                  // if (value == null || value.trim().isEmpty) return null; // OK if empty
                  // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  // if (!emailRegex.hasMatch(value.trim())) {
                  //   return 'valid_email'.tr();
                  // }
                  // return null;
                },),

              Spacer(),
              PButton(onPressed:() {
                SafeToast.show(message:'Coming Soon',type:MessageType.warning,);
              },hasBloc:false,title:'save_info'.tr(),isFitWidth:true,),
              const SizedBox(height:16),
            ],),
          )
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:mawidak/core/component/custom_drop_down/p_drop_down.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

class DoctorBankInfoScreen extends StatelessWidget {
  const DoctorBankInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> banks = [
      {
        'label': 'Cairo, Egypt',
        'value': '30.0444',
      },
      {
        'label': 'Cairo, Egypt',
        'value': '30.0444',
      },
      {
        'label': 'Cairo, Egypt',
        'value': '30.0444',
      },
      {
        'label': 'Cairo, Egypt',
        'value': '30.0444',
      },
    ];

    return Scaffold(
      backgroundColor:AppColors.whiteBackground,
    body:SingleChildScrollView(
      child: Column(children: [
        Container(
          width: 400, color:Color(0xffF1F8FF),
          padding: const EdgeInsets.only(
            left: 20, right: 20, top: 20, bottom: 20,),
          margin:EdgeInsets.only(bottom:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PText(title:'معلومات الحساب البنكية', size: PSize.text20,),
              PText(title:'سيتم استخدام هذه المعلومات لتحويل مستحقاتك المالي', size: PSize.text16,
                fontColor: AppColors.grey200, fontWeight: FontWeight.w400,),
              const SizedBox(height:0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:18),
          child: Column(children: [
            PDropDown(options:banks,label:'اسم البنك',hintText:'اختر اسم البنك',),
            Padding(
              padding: const EdgeInsets.only(top:12,bottom: 10),
              child: PTextField(labelAbove:'اسم صاحب الحساب',hintText:'أدخل الاسم كما هو مسجل بالبنك',
                feedback:(value) {

                },),
            ),
            Padding(
              padding: const EdgeInsets.only(top:12,bottom: 10),
              child: PTextField(labelAbove:'رقم الآيبان (IBAN)',hintText:'أدخل رقم الآيبان',
                feedback:(value) {

                },),
            ),
            Padding(
              padding: const EdgeInsets.only(top:12,bottom: 10),
              child: PTextField(labelAbove:'رقم الحساب البنكي',hintText:'أدخل رقم الحساب',
                feedback:(value) {

                },),
            ),
            Padding(
              padding: const EdgeInsets.only(top:12,bottom: 10),
              child: PTextField(labelAbove:'فرع البنك ( اختياري )',hintText:'أدخل اسم الفرع',
                feedback:(value) {

                },),
            ),
            const SizedBox(height:40,)
          ],),
        )
      ],),
    ),);
  }
}

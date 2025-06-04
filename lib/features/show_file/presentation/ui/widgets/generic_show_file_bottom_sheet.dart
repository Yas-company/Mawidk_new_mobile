import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';

showGenericShowFileBottomSheet({required String title}){
  showModalBottomSheet(
    context: navigatorKey.currentState!.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding:EdgeInsets.zero,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          // height: 300,
          child:GenericShowFileBottomSheet(title:title,)
      ),
    ),
  );
}

class GenericShowFileBottomSheet extends StatelessWidget {
  final String title;
  const GenericShowFileBottomSheet({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PText(title:title.tr(), fontWeight: FontWeight.w700,size:PSize.text16,),
              InkWell(onTap:() {
                Navigator.pop(context);
              }, child:Icon(Icons.close,color:AppColors.grey200,))
            ],
          ),
          SizedBox(height: 16),
          PTextField(labelAbove:'medicine_name'.tr(),hintText:'medicine_name'.tr(), feedback:(value) {

          },),
          SizedBox(height: 10),
          PTextField(labelAbove:'dosage'.tr(),hintText:'dosage_hint'.tr(), feedback:(value) {

          },),
          PTextField(labelAbove:'repeat_usage'.tr(),hintText:'repeat_usage_hint'.tr(), feedback:(value) {

          },),
          SizedBox(height: 10),
          PTextField(labelAbove:'start_date'.tr(),hintText:'start_date_hint'.tr(), feedback:(value) {

          },),
          SizedBox(height: 10),
          PTextField(labelAbove:'usage_info'.tr(),hintText:''.tr(), feedback:(value) {

          },maxLines:2,),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: PButton(onPressed:() {

                },title:'save'.tr(),hasBloc:false,fillColor:AppColors.primaryColor,),
              ),
              SizedBox(width: 12),
              Expanded(
                child: PButton(onPressed:() {

                },title:'cancel'.tr(),hasBloc:false,fillColor:AppColors.secondary,),
              ),
            ],
          ),
          SizedBox(height:4),
        ],
      ),
    );
  }

  Widget buildTextField(String label, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';

class ConsultationBottomSheet extends StatefulWidget {
  // final ConsultationData? item;
  final Function(Object requestModel) onSubmit;
  final bool isEdit;


  const ConsultationBottomSheet({
    super.key,required this.onSubmit,
    required this.isEdit,
    // this.item,
  });

  @override
  State<ConsultationBottomSheet> createState() => ConsultationBottomSheetState();
}

class ConsultationBottomSheetState extends State<ConsultationBottomSheet> {
   TextEditingController consultationDateController = TextEditingController();
   TextEditingController mainComplaintController = TextEditingController();
   TextEditingController examinationController = TextEditingController();
   TextEditingController nextDateController = TextEditingController();
   TextEditingController notesController = TextEditingController();

   TextEditingController bloodPressureDiastolicController = TextEditingController();
   TextEditingController bloodPressureSystolicController = TextEditingController();
   TextEditingController pulseRateController = TextEditingController();
   TextEditingController temperatureController = TextEditingController();
   TextEditingController bloodSugarLevelController = TextEditingController();

  @override
  void dispose() {
    consultationDateController.dispose();
    mainComplaintController.dispose();
    examinationController.dispose();
    nextDateController.dispose();
    notesController.dispose();
    bloodPressureDiastolicController.dispose();
    bloodPressureSystolicController.dispose();
    pulseRateController.dispose();
    temperatureController.dispose();
    bloodSugarLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,removeTop: true,
      child: Scaffold(
        backgroundColor:AppColors.whiteBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding:EdgeInsets.only(top:24),
            child: appBar(context: context,backBtn: true,text:'patient_file'.tr(),isCenter:true,),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                InkWell(onTap:() async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    consultationDateController.text = '${date.year}-${date.month}-${date.day}';
                    consultationDateController.text = DateFormat('yyyy-MM-dd').format(date);
                  }
                },child: PTextField(enabled:false,
                  controller: consultationDateController,labelAbove:'consultation_date'.tr(),
                  hintText:'consultation_date'.tr(), feedback:(value) {
            
                  },disabledBorderColor:Colors.transparent,suffixIcon:Icon(Icons.calendar_month_rounded),),
                ),
                const SizedBox(height: 16),
                PTextField(controller: mainComplaintController,labelAbove:'main_complaint2'.tr(),
                  hintText:'enter_main_complaint'.tr(), feedback:(value) {
            
                  },),
                const SizedBox(height: 16),
                PText(title:'vital_signs'.tr(),size:PSize.text18,),
                const SizedBox(height:9),
                Container(padding:EdgeInsets.only(left:8,right:8,top:10,bottom:10),decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color:AppColors.primaryColor550,
                ),child:Column(children: [
                  Row(children: [
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PText(title: 'blood_pressure'.tr(),size:PSize.text14,),
                              Container(
                                padding:EdgeInsets.only(top:4),
                                height: 35,
                                child: TextFormField(
                                controller: bloodPressureDiastolicController,
                                  keyboardType:TextInputType.number,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    isDense: true,fillColor:Colors.white,filled:true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:AppColors.grayColor200, width: 1.0), // default border
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:AppColors.primaryColor, width: 1.5), // on focus
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onChanged:(value) {

                                  },
                                ),
                              ),
                            ]
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:24,left:4,right:4),
                          child: PImage(source:AppSvgIcons.slash,width:10,),
                        ),
                        Expanded(
                            child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PText(title: ''),
                                  Container(
                                    padding:EdgeInsets.only(top:4),
                                    height: 35,
                                    child: TextFormField(
                                      controller: bloodPressureSystolicController,
                                      keyboardType:TextInputType.number,
                                      textAlignVertical: TextAlignVertical.center,
                                      style: const TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        isDense: true,fillColor:Colors.white,filled:true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color:AppColors.grayColor200, width: 1.0), // default border
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color:AppColors.primaryColor, width: 1.5), // on focus
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      onChanged:(value) {

                                      },
                                    ),
                                  ),
                                ]
                            )),
                      ],),
                    ),
                    const SizedBox(width:10,),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PText(title: 'pulse'.tr(),size:PSize.text14,),
                                  Container(
                                    padding:EdgeInsets.only(top:4),
                                    height: 35,
                                    child: TextFormField(
                                      controller: pulseRateController,
                                      keyboardType:TextInputType.number,
                                      textAlignVertical: TextAlignVertical.center,
                                      style: const TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        isDense: true,fillColor:Colors.white,filled:true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color:AppColors.grayColor200, width: 1.0), // default border
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color:AppColors.primaryColor, width: 1.5), // on focus
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      onChanged:(value) {

                                      },
                                    ),
                                  ),
                                ]
                            ))
                  ],),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PText(title: 'temperature'.tr(),size:PSize.text14,),
                          Container(
                            padding:EdgeInsets.only(top:4),
                            height: 35,
                            child: TextFormField(
                              controller: temperatureController,
                              keyboardType:TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                isDense: true,fillColor:Colors.white,filled:true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.grayColor200, width: 1.0), // default border
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.primaryColor, width: 1.5), // on focus
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onChanged:(value) {

                              },
                            ),
                          ),
                        ]
                    )),
                    const SizedBox(width:10,),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PText(title: 'blood_sugar_level'.tr(),size:PSize.text14,),
                          Container(
                            padding:EdgeInsets.only(top:4),
                            height: 35,
                            child: TextFormField(
                              controller: bloodSugarLevelController,
                              keyboardType:TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                isDense: true,fillColor:Colors.white,filled:true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.grayColor200, width: 1.0), // default border
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.primaryColor, width: 1.5), // on focus
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onChanged:(value) {

                              },
                            ),
                          ),
                        ]
                    )),
                  ],),
                ],),),
            
                const SizedBox(height: 16),
            
                PTextField(controller: examinationController,labelAbove:'bed_examination'.tr(),
                  hintText:'describe_suffer'.tr(), feedback:(value) {
            
                  },),
            
                const SizedBox(height: 16),
            
                InkWell(onTap:() async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    nextDateController.text = '${date.year}-${date.month}-${date.day}';
                    nextDateController.text = DateFormat('yyyy-MM-dd').format(date);
                  }
                },child: PTextField(enabled:false,
                  controller: nextDateController,labelAbove:'follow_date'.tr(),
                  hintText:'consultation_date'.tr(), feedback:(value) {
            
                  },disabledBorderColor:Colors.transparent,suffixIcon:Icon(Icons.calendar_month_rounded),),
                ),
            
                const SizedBox(height: 16),
                PTextField(controller: notesController,labelAbove:'notes'.tr(),hintText:'any_notes'.tr(),
                  feedback:(value) {
            
                  },),
                // if (!widget.isEdit) ...[
                //   const SizedBox(height: 0),
                //   PDropDown(controller:TextEditingController(text:_status),
                //     options:stabilityList,label:'status'.tr(),onChange:(value) {
                //
                //     },)
                // ],
                // Spacer(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: PButton(borderRadius:12,
                        onPressed:() {
                          if (widget.isEdit) {
                            // final updateModel = UpdateDiagnosisRequestModel(
                            //   description: _descriptionController.text,
                            //   date: _dateController.text,
                            // );
                            // widget.onSubmit(updateModel);
                          } else {
                            final addModel = AddConsultationRequestModel(
                              patientId:0,
                              mainComplaint: mainComplaintController.text,
                              notes: notesController.text,
                              consultationDate: consultationDateController.text,
                              bloodPressureDiastolic: num.parse(bloodPressureDiastolicController.text),
                              bloodPressureSystolic: num.parse(bloodPressureSystolicController.text),
                              bloodSugarLevel: num.parse(bloodSugarLevelController.text),
                              pulseRate: num.parse(pulseRateController.text),
                              temperature: num.parse(temperatureController.text),
                              clinicalExamination:examinationController.text,
                              nextFollowUpDate:nextDateController.text
                            );
                            widget.onSubmit(addModel);
                          }
                          Future.delayed(Duration(milliseconds: 1400,),() {
                            Navigator.pop(context);
                          },);
                        },fillColor:AppColors.primaryColor,
                        title: 'consultation_save'.tr(),
                        hasBloc: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PButton(borderRadius:12,
                        onPressed: () => Navigator.pop(context),
                        title: 'cancel'.tr(),
                        fillColor: AppColors.secondary,
                        hasBloc: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool validateFields(){
    return mainComplaintController.text.isNotEmpty&&consultationDateController.text.isNotEmpty
        &&bloodPressureDiastolicController.text.isNotEmpty
        &&consultationDateController.text.isNotEmpty
        &&bloodPressureSystolicController.text.isNotEmpty
        &&bloodSugarLevelController.text.isNotEmpty
        &&pulseRateController.text.isNotEmpty
        &&temperatureController.text.isNotEmpty;
  }
}

// void showAddingConsultationBottomSheet({required int id,
//   required Function(AddConsultationRequestModel) onSubmit}){
//   showModalBottomSheet(
//     context:navigatorKey.currentState!.context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => AnimatedPadding(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//       padding: MediaQuery.of(context).viewInsets,
//       child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           padding: const EdgeInsets.all(20),
//           // height: 300,
//           child: ConsultationBottomSheet(isEdit: false,onSubmit:(model) {
//             AddConsultationRequestModel addModel = model as AddConsultationRequestModel;
//             addModel.patientId = id;
//             onSubmit(addModel);
//           },)
//       ),
//     ),
//   );
// }

// void showEditingConsultationBottomSheet({final DiagnosisData? item
//   ,required Function(UpdateDiagnosisRequestModel) onSubmit,}){
//   showModalBottomSheet(
//     context:navigatorKey.currentState!.context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => AnimatedPadding(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//       padding: MediaQuery.of(context).viewInsets,
//       child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           padding: const EdgeInsets.all(20),
//           // height: 300,
//           child: ConsultationBottomSheet(
//             item:item,onSubmit: (Object model) {
//             final updateModel = model as UpdateDiagnosisRequestModel;
//             onSubmit(updateModel);
//             // Use updateModel
//           },isEdit: true,
//           )
//       ),
//     ),
//   );
// }
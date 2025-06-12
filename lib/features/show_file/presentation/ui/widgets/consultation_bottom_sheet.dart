import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/all_consultaions_response_model.dart';

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
   TextEditingController _nameController = TextEditingController();
   TextEditingController _dateController = TextEditingController();
   TextEditingController _descriptionController = TextEditingController();
  // List<Map<String, dynamic>> stabilityList = [
  //   {'label': 'مستقر', 'value': true},
  //   {'label': 'غير مستقر', 'value': false},
  // ];
  // String _status = 'مستمر'; // default value

  @override
  void initState() {
    super.initState();
    // _nameController = TextEditingController(text: widget.item?.main_complaint ?? '');
    // _dateController = TextEditingController(text: widget.item?.consultation_date ?? '');
    // _descriptionController = TextEditingController(text: widget.item?.notes ?? '');
    // _status = (widget.item?.status ??0) == 1? stabilityList.first['label']:
    // stabilityList[1]['label'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
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
            padding: const EdgeInsets.only(top:24),
            child: appBar(context: context,backBtn: true,text:'patient_file'.tr(),isCenter:true),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(onTap:() async {
                DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );
                if (date != null) {
                  _dateController.text = '${date.year}-${date.month}-${date.day}';
                  _dateController.text = DateFormat('yyyy-MM-dd').format(date);
                }
              },child: PTextField(enabled:false,
                controller: _dateController,labelAbove:'تاريخ الاستشارة',hintText:'تاريخ الاستشارة', feedback:(value) {

                },disabledBorderColor:Colors.transparent,suffixIcon:Icon(Icons.calendar_month_rounded),),
              ),
              const SizedBox(height: 16),
              PTextField(controller: _nameController,labelAbove:'الشكوى الرئيسية',
                hintText:'ادخل الشكوى الرئيسية', feedback:(value) {

                },),

              const SizedBox(height: 16),
              PTextField(controller: _nameController,labelAbove:'الفحص السريري',
                hintText:'وصف الاعراض التي يعاني منها المريض', feedback:(value) {

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
                  _dateController.text = '${date.year}-${date.month}-${date.day}';
                  _dateController.text = DateFormat('yyyy-MM-dd').format(date);
                }
              },child: PTextField(enabled:false,
                controller: _dateController,labelAbove:'موعد المتابعة القادم',hintText:'تاريخ الاستشارة', feedback:(value) {

                },disabledBorderColor:Colors.transparent,suffixIcon:Icon(Icons.calendar_month_rounded),),
              ),

              const SizedBox(height: 16),
              PTextField(controller: _descriptionController,labelAbove:'ملاحظات',hintText:'اي ملاحظات اضافية',
                feedback:(value) {

                },),
              // if (!widget.isEdit) ...[
              //   const SizedBox(height: 0),
              //   PDropDown(controller:TextEditingController(text:_status),
              //     options:stabilityList,label:'status'.tr(),onChange:(value) {
              //
              //     },)
              // ],
              const SizedBox(height: 24),
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
                            mainComplaint: _nameController.text,
                            notes: _descriptionController.text,
                            consultationDate: _dateController.text,
                            bloodPressureDiastolic: 85,
                            bloodPressureSystolic: 130,
                            bloodSugarLevel: 95,
                            pulseRate: 78,
                            temperature: 37.2,
                            clinicalExamination: "No signs of infection, patient appears alert.",
                            nextFollowUpDate: "2025-06-15"
                          );
                          widget.onSubmit(addModel);
                        }
                        Navigator.pop(context);
                      },fillColor:AppColors.primaryColor,
                      title: 'حفظ الاستشارة'.tr(),
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
              )
            ],
          ),
        ),
      ),
    );
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
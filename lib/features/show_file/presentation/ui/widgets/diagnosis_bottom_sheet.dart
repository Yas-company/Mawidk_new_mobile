import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_drop_down/p_drop_down.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/show_file/data/model/add_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/diagnosis_response_model.dart';
import 'package:mawidak/features/show_file/data/model/update_diagnosis_request_model.dart';

class DiagnosisBottomSheet extends StatefulWidget {
  final DiagnosisData? item;
  final Function(Object requestModel) onSubmit;
  final bool isEdit;


  const DiagnosisBottomSheet({
    super.key,required this.onSubmit,
    required this.isEdit,
    this.item,
  });

  @override
  State<DiagnosisBottomSheet> createState() => _DiagnosisBottomSheetState();
}

class _DiagnosisBottomSheetState extends State<DiagnosisBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;
  List<Map<String, dynamic>> stabilityList = [
    {'label': 'مستقر', 'value': true},
    {'label': 'غير مستقر', 'value': false},
  ];
  String _status = 'مستمر'; // default value

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.diagnosis ?? '');
    _dateController = TextEditingController(text: widget.item?.date ?? '');
    _descriptionController = TextEditingController(text: widget.item?.description ?? '');
    _status = (widget.item?.status ??0) == 1? stabilityList.first['label']:
    stabilityList[1]['label'];
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

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              PText(
                title: widget.isEdit ? 'edit_info'.tr() : 'add_new_diagnosis'.tr(),
                fontWeight: FontWeight.w700,
                size: PSize.text18,
              ),
              InkWell(onTap: () {
                Navigator.pop(context);
              },child: Icon(Icons.close,
                color: AppColors.grey200,
              ))
            ]),
            const SizedBox(height: 16),
            PTextField(controller: _nameController,labelAbove:'diagnosis'.tr(),
              hintText:widget.isEdit?'':'add_diagnosis_name'.tr(), feedback:(value) {

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
              controller: _dateController,labelAbove:'diagnosis_date2'.tr(),hintText:'choose_date'.tr(),
              feedback:(value) {

              },disabledBorderColor:Colors.transparent,),
            ),
            const SizedBox(height: 16),
            PTextField(controller: _descriptionController,labelAbove:'diagnosis_desc'.tr(),
              hintText:'put_diagnosis_desc'.tr(),
              feedback:(value) {

              },),
            if (!widget.isEdit) ...[
              const SizedBox(height: 0),
              PDropDown(controller:TextEditingController(text:_status),
                options:stabilityList,label:'status'.tr(),onChange:(value) {

                },)
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: PButton(borderRadius:12,
                    onPressed:() {
                        if (widget.isEdit) {
                          final updateModel = UpdateDiagnosisRequestModel(
                            description: _descriptionController.text,
                            date: _dateController.text,
                          );
                          widget.onSubmit(updateModel);
                        } else {
                          final addModel = AddDiagnosisRequestModel(
                            patientId:0,
                            diagnosis: _nameController.text,
                            description: _descriptionController.text,
                            status: _status == 'مستقر' ? 1 : 0,
                            date: _dateController.text,
                          );
                          widget.onSubmit(addModel);
                        }
                        Navigator.pop(context);
                    },fillColor:AppColors.primaryColor,
                    title: 'save'.tr(),
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
    );
  }
}


void showAddingDiagnosisBottomSheet({required int id,required Function(AddDiagnosisRequestModel) onSubmit}){
  showModalBottomSheet(
    context:navigatorKey.currentState!.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          // height: 300,
          child: DiagnosisBottomSheet(isEdit: false,onSubmit:(model) {
            AddDiagnosisRequestModel addModel = model as AddDiagnosisRequestModel;
            addModel.patientId = id;
            onSubmit(addModel);
          },)
      ),
    ),
  );
}

void showEditingDiagnosisBottomSheet({final DiagnosisData? item
  ,required Function(UpdateDiagnosisRequestModel) onSubmit,}){
  showModalBottomSheet(
    context:navigatorKey.currentState!.context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          // height: 300,
          child: DiagnosisBottomSheet(
            item:item,onSubmit: (Object model) {
            final updateModel = model as UpdateDiagnosisRequestModel;
            onSubmit(updateModel);
            // Use updateModel
          },isEdit: true,
          )
      ),
    ),
  );
}
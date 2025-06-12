import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/show_file/data/model/drug/add_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/drug_response_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/update_drug_request_model.dart';


class DrugBottomSheet extends StatefulWidget {
  final DrugData? item;
  final Function(Object requestModel) onSubmit;
  final bool isEdit;


  const DrugBottomSheet({
    super.key,required this.onSubmit,
    required this.isEdit,
    this.item,
  });

  @override
  State<DrugBottomSheet> createState() => DrugBottomSheetState();
}

class DrugBottomSheetState extends State<DrugBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _dosageController;
  late TextEditingController _frequencyController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _dosageController = TextEditingController(text:widget.isEdit? (widget.item?.dosage ?? 0).toString():'');
    _dateController = TextEditingController(text: widget.item?.startDate ?? '');
    _frequencyController = TextEditingController(text:widget.isEdit? (widget.item?.frequency ?? 1).toString():'');
    _descriptionController = TextEditingController(text: widget.item?.instructions ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _dosageController.dispose();
    _descriptionController.dispose();
    _frequencyController.dispose();
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
                title: widget.isEdit ? 'تعديل المعلومات' : 'اضافة دواء جديد',
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
            PTextField(controller: _nameController,labelAbove:'اسم الدواء',hintText:'اسم الدواء',
              feedback:(value) {

              },),

            const SizedBox(height: 16),
            PTextField(textInputType:TextInputType.number,
              controller: _dosageController,labelAbove:'الجرعة',hintText:'مثال : ٥٠ ملغ',
              feedback:(value) {

              },),

            if(!widget.isEdit)...[
              const SizedBox(height: 16),
              PTextField(textInputType:TextInputType.number,
                controller: _frequencyController,labelAbove:'تكرار الاستخدام',hintText:'مرة واحدة يوميا',
                feedback:(value) {

                },)
            ],
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
              controller: _dateController,labelAbove:'تاريخ البدء',hintText:'ضع التاريخ', feedback:(value) {

              },disabledBorderColor:Colors.transparent,),
            ),
            const SizedBox(height: 16),
            PTextField(controller: _descriptionController,labelAbove:'تعليمات الاستخدام',hintText:'',
              maxLines: 2,
              feedback:(value) {

              },),
            if (!widget.isEdit) ...[
              const SizedBox(height: 0),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: PButton(borderRadius:12,
                    onPressed:() {
                      if (widget.isEdit) {
                        final updateModel = UpdateDrugRequestModel(
                          name:_nameController.text,
                          instructions:_descriptionController.text,
                          dosage: _dosageController.text.isEmpty?1:int.parse(_dosageController.text),
                        );
                        widget.onSubmit(updateModel);
                      } else {
                        final addModel = AddDrugRequestModel(
                          patientId:0,
                          name:_nameController.text,
                          instructions: _descriptionController.text,
                          startDate: _dateController.text,
                          dosage: _dosageController.text.isEmpty?1:int.parse(_dosageController.text),
                          frequency: _frequencyController.text.isEmpty?1:int.parse(_frequencyController.text),
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


void showAddingDrugBottomSheet({required int id,required Function(AddDrugRequestModel) onSubmit}){
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
          child: DrugBottomSheet(isEdit: false,onSubmit:(model) {
            AddDrugRequestModel addModel = model as AddDrugRequestModel;
            addModel.patientId = id;
            onSubmit(addModel);
          },)
      ),
    ),
  );
}

void showEditingDrugBottomSheet({final DrugData? item
  ,required Function(UpdateDrugRequestModel) onSubmit,}){
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
          child: DrugBottomSheet(
            item:item,onSubmit: (Object model) {
            final updateModel = model as UpdateDrugRequestModel;
            onSubmit(updateModel);
            // Use updateModel
          },isEdit: true,
          )
      ),
    ),
  );
}
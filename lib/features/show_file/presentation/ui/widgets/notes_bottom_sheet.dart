import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/show_file/data/model/add_note_request_model.dart';
import 'package:mawidak/features/show_file/data/model/all_notes_response_model.dart';
import 'package:mawidak/features/show_file/data/model/update_note_request_model.dart';

class NotesBottomSheet extends StatefulWidget {
  final NotesData? item;
  final Function(Object requestModel) onSubmit;
  final bool isEdit;


  const NotesBottomSheet({
    super.key,required this.onSubmit,
    required this.isEdit,
    this.item,
  });

  @override
  State<NotesBottomSheet> createState() => NotesBottomSheetState();
}

class NotesBottomSheetState extends State<NotesBottomSheet> {
  late TextEditingController _addressController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.item?.title ?? '');
    _dateController = TextEditingController(text: widget.item?.date ?? '');
    _descriptionController = TextEditingController(text: widget.item?.note ?? '');
  }

  @override
  void dispose() {
    _addressController.dispose();
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
                title: widget.isEdit ? 'edit_note'.tr() : 'add_notes'.tr(),
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
            PTextField(controller: _addressController,labelAbove:'address'.tr(),hintText:'note_address'.tr(),
              feedback:(value) {

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
              controller: _dateController,labelAbove:'date'.tr(),hintText:'start_date_hint'.tr(), feedback:(value) {

              },disabledBorderColor:Colors.transparent,),
            ),
            const SizedBox(height: 16),
            PTextField(controller: _descriptionController,labelAbove:'description2'.tr(),hintText:'',
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
                        final updateModel = UpdateNoteRequestModel(
                          title:_addressController.text,
                          note:_descriptionController.text,
                          date:_dateController.text,
                        );
                        widget.onSubmit(updateModel);
                      } else {
                        final addModel = AddNoteRequestModel(
                          patientId:0,
                          title:_addressController.text,
                          note:_descriptionController.text,
                          date:_dateController.text,
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


void showAddingNoteBottomSheet({required int id,required Function(AddNoteRequestModel) onSubmit}){
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
          child: NotesBottomSheet(isEdit: false,onSubmit:(model) {
            AddNoteRequestModel addModel = model as AddNoteRequestModel;
            addModel.patientId = id;
            onSubmit(addModel);
          },)
      ),
    ),
  );
}

void showEditingNoteBottomSheet({final NotesData? item
  ,required Function(UpdateNoteRequestModel) onSubmit,}){
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
          child: NotesBottomSheet(
            item:item,onSubmit: (Object model) {
            final updateModel = model as UpdateNoteRequestModel;
            onSubmit(updateModel);
            // Use updateModel
          },isEdit: true,
          )
      ),
    ),
  );
}
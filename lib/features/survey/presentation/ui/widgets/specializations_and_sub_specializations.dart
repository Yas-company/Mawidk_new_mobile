import 'package:flutter/material.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';

class SpecializationDropdown extends StatefulWidget {
  final void Function(Option? selectedSpecialization, List<Option> selectedSubSpecializations)
  onChangedSpecializations;
  final String title;
  final String hint;

  const SpecializationDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.onChangedSpecializations,
  });

  @override
  State<SpecializationDropdown> createState() => _LinkedDropdownsState();
}

class _LinkedDropdownsState extends State<SpecializationDropdown> {
  Option? selectedSpecialization;
  List<Option> selectedSubSpecializations = [];
  Option? selectedSubValue; // For dropdown's current value

  List<Option> get filteredSubSpecializations {
    if (selectedSpecialization == null) return [];
    return subSpecializations
        .where((sub) => sub.sepcializationId == selectedSpecialization!.id)
        .toList();
  }

  void _notifyChange() {
    widget.onChangedSpecializations(selectedSpecialization, selectedSubSpecializations);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabeledDropdown(
          title: widget.title,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Option>(
              isExpanded: true,
              hint: PText(title: widget.hint),
              value: selectedSpecialization,
              dropdownColor: AppColors.whiteColor,
              items: specializations.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: PText(title: option.optionText ?? ''),
                );
              }).toList(),
              onChanged: (Option? value) {
                setState(() {
                  selectedSpecialization = value;
                  selectedSubSpecializations = [];
                  selectedSubValue = null;
                  _notifyChange();
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (filteredSubSpecializations.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabeledDropdown(
                title: 'التخصص الدقيق',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Option>(
                    isExpanded: true,
                    hint: PText(title: "اختر التخصص الدقيق"),
                    value: null,
                    dropdownColor: AppColors.whiteColor,
                    items: filteredSubSpecializations
                        .where((sub) => !selectedSubSpecializations.contains(sub))
                        .map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: PText(title: option.optionText ?? ''),
                      );
                    }).toList(),
                    onChanged: (Option? value) {
                      if (value == null) return;
                      setState(() {
                        selectedSubSpecializations.add(value);
                        selectedSubValue = null;
                        _notifyChange();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedSubSpecializations.map((option) {
                  return Chip(
                    padding:EdgeInsets.only(bottom:4),
                    label:PText(title:option.optionText ?? '',
                        fontColor:AppColors.whiteColor,size:PSize.text14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor:AppColors.primaryColor,
                    deleteIcon: Padding(
                      padding: const EdgeInsets.only(top:4),
                      child: const Icon(Icons.close,color:AppColors.whiteColor,),
                    ),
                    onDeleted: () {
                      setState(() {
                        selectedSubSpecializations.remove(option);
                        _notifyChange();
                      });
                    },
                    // label: PText(title: option.optionText ?? '', size: PSize.text12),
                    // deleteIcon: const Icon(Icons.close, size: 18),
                    // onDeleted: () {
                    //   setState(() {
                    //     selectedSubSpecializations.remove(option);
                    //     _notifyChange();
                    //   });
                    // },
                    // backgroundColor: AppColors.primaryColor100,
                  );
                }).toList(),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildLabeledDropdown({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText(
          title: title,
          size: PSize.text14,
          fontColor: AppColors.fontColor,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.whiteColor),
          ),
          child: child,
        ),
      ],
    );
  }
}

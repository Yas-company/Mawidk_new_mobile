import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_drop_down/p_drop_down.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/lookups/lookup_bloc.dart';

List<String> visitTypes = ['زيارة منزلية','حجز اونلاين','في العيادة'];

typedef FilterCallback = void Function(int? location, int? specialization, int selectedVisitIndex);
void filterBottomSheet(BuildContext context,LookupBloc lookupBloc,final FilterCallback onApplyFilter) {
  showModalBottomSheet(
    context: context,isScrollControlled:true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      String? location,specialization;
      int? cityId,specializationId;
      int selectedVisitIndex = -1;
      return StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:6),
                child: PText(title: 'filter'.tr(), size: PSize.text14, fontColor: AppColors.grey200),
              ),
              const SizedBox(height:14),
              PDropDown(hintText:'المدينة',keyValue:'name'
                ,label:'location'.tr(),isSpecializations:true,
                options: lookupBloc.itemList.map((option) => {
                  'id': option.id,
                  'name': option.name,
                }).toList(),onChange:(value) {
                  location = value?['name'];
                  cityId = value?['id'];
                  print('location>>'+location.toString());
                  setState(() {});
                },),
              const SizedBox(height: 20),
              PDropDown(
                hintText:'اختر التخصص',keyValue:'optionText',
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
              Padding(
                padding: const EdgeInsets.only(top:14,bottom:10),
                child: PText(title:'الموعد',size:PSize.text14,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: visitTypes.asMap().entries.map((entry) {
                  int index = entry.key;
                  String item = entry.value;
                  bool isSelected = selectedVisitIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVisitIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          border:Border.all(color:isSelected?AppColors.primaryColor:Colors.transparent),
                          color: isSelected ? AppColors.primaryTransparent : AppColors.whiteColor,
                        ),
                        child: Center(
                          child: PText(
                            title: item,
                            fontColor: isSelected ? AppColors.blackColor : AppColors.grey200,
                            size: PSize.text14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height:30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(height:55,
                      child: PButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onApplyFilter(cityId,specializationId,selectedVisitIndex);
                        },
                        title: 'تصفية'+ ' ('+
                            getSelectedCount(location??'', specialization??'', selectedVisitIndex).toString()+')',
                        hasBloc: false,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(height:55,
                      child: PButton(
                        onPressed:() {
                          Navigator.pop(context);
                        },
                        title: 'إلغاء',
                        fillColor: AppColors.secondary,
                        hasBloc: false,
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height:10),
            ],
          ),
        );
      },);
    },
  );
}

int getSelectedCount(String location,String specialization,int selectedVisitIndex) {
  int count = 0;
  if (location.isNotEmpty) count++;
  if (specialization.isNotEmpty) count++;
  if (selectedVisitIndex != -1) count++;
  return count;
}
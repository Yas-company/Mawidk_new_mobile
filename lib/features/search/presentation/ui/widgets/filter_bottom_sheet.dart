import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_drop_down/p_drop_down.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/lookups/lookup_bloc.dart';

// List<String> visitTypes = ['زيارة منزلية','حجز اونلاين','في العيادة'];
List<String> userTypes = ['doctor2'.tr(),'specialist2'.tr(),'consultant'.tr()];

typedef FilterCallback = void Function(int? location, int? specialization, int selectedVisitIndex,num evaluate,
    int type);
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
      // int selectedVisitIndex = -1;
      int? selectedEvaluation;
      int selectedUserTypeIndex = -1;
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
              PDropDown(hintText:isArabic()?'المدينة':'',keyValue:'name'
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
              const SizedBox(height: 10),
              PDropDown(
                hintText:isArabic()?'اختر التخصص':'',keyValue:'optionText',
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
              // Padding(
              //   padding: const EdgeInsets.only(top:14,bottom:10),
              //   child: PText(title:'الموعد',size:PSize.text14,),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: visitTypes.asMap().entries.map((entry) {
              //     int index = entry.key;
              //     String item = entry.value;
              //     bool isSelected = selectedVisitIndex == index;
              //
              //     return Expanded(
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             selectedVisitIndex = index;
              //           });
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.symmetric(horizontal: 4),
              //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //           decoration: BoxDecoration(
              //             borderRadius: const BorderRadius.all(Radius.circular(16)),
              //             border:Border.all(color:isSelected?AppColors.primaryColor:Colors.transparent),
              //             color: isSelected ? AppColors.primaryTransparent : AppColors.whiteColor,
              //           ),
              //           child: Center(
              //             child: PText(
              //               title: item,
              //               fontColor: isSelected ? AppColors.blackColor : AppColors.grey200,
              //               size: PSize.text14,
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),

              Padding(
                padding: const EdgeInsets.only(top:14,bottom:10),
                child: PText(title:'rank'.tr(),size:PSize.text14,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: userTypes.asMap().entries.map((entry) {
                  int index = entry.key;
                  String item = entry.value;
                  bool isSelected = selectedUserTypeIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedUserTypeIndex = index;
                          // print('selectedUserTypeIndex>>'+selectedUserTypeIndex.toString());
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


              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: PText(title: 'evaluation'.tr(), size: PSize.text14),
              ),
              // Center(
              //   child: AccurateHalfStarRating(
              //     rating:selectedEvaluation??0,
              //     onRatingChanged: (value) {
              //       setState(() {
              //         selectedEvaluation = value;
              //       });
              //     },
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int starValue = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEvaluation = starValue; // selectedEvaluation should be int
                      });
                    },
                    child: Icon(
                      Icons.star,
                      size: 36,
                      color: (selectedEvaluation ?? 0) >= starValue
                          ? Colors.orange
                          : AppColors.grey200,
                    ),
                  );
                }),
              ),



              const SizedBox(height:30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(height:55,
                      child: PButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // onApplyFilter(cityId,specializationId,selectedVisitIndex);
                          onApplyFilter(cityId,specializationId,selectedUserTypeIndex,selectedEvaluation??0,
                          selectedUserTypeIndex+1);
                        },
                        title: 'filter'.tr()+ ' ('+
                            getSelectedCount(location??'', specialization??'', selectedUserTypeIndex).toString()+')',
                            // getSelectedCount(location??'', specialization??'', selectedVisitIndex).toString()+')',
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
                        title: 'cancel'.tr(),
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






class AccurateHalfStarRating extends StatefulWidget {
  final double rating;
  final int starCount;
  final double starSize;
  final ValueChanged<double> onRatingChanged;

  const AccurateHalfStarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.starCount = 5,
    this.starSize = 40.0,
  });

  @override
  State<AccurateHalfStarRating> createState() => _AccurateHalfStarRatingState();
}

class _AccurateHalfStarRatingState extends State<AccurateHalfStarRating> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  void _handleTap(TapDownDetails details, BoxConstraints constraints) {
    double starWidth = constraints.maxWidth / widget.starCount;
    double tapX = details.localPosition.dx;

    // Convert tap X position into a double rating value
    double rawRating = (tapX / starWidth);
    double newRating = (rawRating * 2).round() / 2;

    setState(() {
      _currentRating = newRating;
    });
    widget.onRatingChanged(_currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTapDown: (details) => _handleTap(details, constraints),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.starCount, (index) {
            IconData icon;
            if (_currentRating >= index + 1) {
              icon = Icons.star;
            } else if (_currentRating >= index + 0.5) {
              icon = Icons.star_half;
            } else {
              icon = Icons.star_border;
            }

            return Icon(
              icon,
              color: Colors.amber,
              size: widget.starSize,
            );
          }),
        ),
      ),
    );
  }
}


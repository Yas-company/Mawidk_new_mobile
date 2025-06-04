import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/features/all_patients/data/model/patients_response_model.dart';
import 'package:mawidak/features/all_patients/presentation/ui/widgets/patient_item_card_widget.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/bloc/search_for_doctors_bloc.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/bloc/search_for_doctors_event.dart';

class SearchResultForDoctorWidget extends StatelessWidget {
  final SearchForDoctorsBloc searchBloc;
  final String searchKey;
  const SearchResultForDoctorWidget({super.key,required this.searchBloc,required this.searchKey});

  @override
  Widget build(BuildContext context) {
    return PBlocBuilder(bloc:searchBloc,
      init:() {
        if(searchKey.isNotEmpty){
          searchBloc.add(ApplySearchForDoctor(key: searchKey));
        }
      },
      emptyWidget:(state) {
        return (state is EmptyState)?Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.15),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PImage(source: AppSvgIcons.emptySearch, width: 170, height: 170,),
                    PText(title: 'sorry'.tr(), size: PSize.text18, fontWeight: FontWeight.w700),
                    const SizedBox(height:10,),
                    PText(title: state.data, size: PSize.text14),
                    const SizedBox(height:10,),
                    PButton(onPressed:() {
                      Navigator.pop(context);
                      // Navigator.of(context).popUntil((route) => route.isFirst);
                    },title:'back_to_patients'.tr(),hasBloc: false,)
                  ],
                ),
              ),
            ),
          ),
        ):SizedBox.shrink();
      },
      loadedWidget:(state) {
        List<PatientData> dataList = ((state as LoadedState).data).model?.model ?? [];
        searchBloc.isMap = false;
        return  Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              PatientData item = dataList[index];
              return PatientItemCardWidget(patientData:item);
            },
            separatorBuilder: (context, index) => SizedBox(height:0,width:4,),
            itemCount:dataList.length,),
        );
      },loadingWidget:Center(child:Padding(
        padding:EdgeInsets.only(top:MediaQuery.sizeOf(context).height*0.25),
        child: CustomLoader(size:35,),
      )),);
  }
}

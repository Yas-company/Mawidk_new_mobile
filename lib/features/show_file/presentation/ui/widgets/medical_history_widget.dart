import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/show_file/data/model/medical_history_response_model.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_bloc.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';

class MedicalHistoryWidget extends StatelessWidget {
  final int id;
  const MedicalHistoryWidget({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    ShowFileBloc showFileBloc = ShowFileBloc(showFileUseCase: getIt());
    return BlocProvider(create: (context) => showFileBloc,
      child: PBlocBuilder(
        init:() {
          showFileBloc.add(ApplyMedicalHistory(id: id));
        },loadingWidget:Center(child:Center(child: CustomLoader(size:35,))),
        bloc:showFileBloc,loadedWidget:(state) {
        MedicalHistoryData model
        = ((state as LoadedState).data).model?.model?? MedicalHistoryData();
        return SingleChildScrollView(
          child:Column(
            mainAxisSize:MainAxisSize.min,
            crossAxisAlignment:CrossAxisAlignment.start,children: [
            const SizedBox(height:16,),
            chronicDiseasesItem(model.chronicDiseases??[]),
            const SizedBox(height:20,),
            familyHistoryItem(model.familyDiseases??''),
            const SizedBox(height:20,),
            operations(model.seriousHealthIssues??''),
            const SizedBox(height:20,),
            lifeStyle(model.smokingStatus??'لا',model.smokingStatus??'لا', model.exerciseFrequency??''),
            const SizedBox(height:20,),
          ],),
        );
      },),
    );
  }

  Widget chronicDiseasesItem(List<String> chronicDiseases){
    return Container(
      // margin: EdgeInsets.only(top:20),
      padding:EdgeInsets.symmetric(horizontal:20,vertical:10),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PText(title:'chronic_diseases'.tr(),fontWeight:FontWeight.w700,),
          const SizedBox(height:14,),
          // ...chronicDiseases.map((e) {
          ...List.generate(chronicDiseases.length, (index) {
            final e = chronicDiseases[index];
            final isLast = index == chronicDiseases.length - 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(title: e),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Divider(color: AppColors.grey100),
                  ),
              ],
            );
          }),
          const SizedBox(height:8,),
        ],
      ),
    );
  }

  Widget familyHistoryItem(String familyHistory){
    return Container(
      padding:EdgeInsets.symmetric(horizontal:20,vertical:10),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PText(title:'family_history'.tr(),fontWeight:FontWeight.w700,),
          const SizedBox(height:14,),
          PText(title:familyHistory)
        ],
      ),
    );
  }

  Widget operations(String familyHistory){
    return Container(
      padding:EdgeInsets.symmetric(horizontal:20,vertical:10),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PText(title:'surgical_operations'.tr(),fontWeight:FontWeight.w700,),
          const SizedBox(height:14,),
          PText(title:familyHistory)
        ],
      ),
    );
  }

  Widget lifeStyle(String smoke,String water,String sport){
    return Container(
      padding:EdgeInsets.symmetric(horizontal:20,vertical:10),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PText(title:'life_style'.tr(),fontWeight:FontWeight.w700,),
          const SizedBox(height:14,),
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              PText(title:'smoking'.tr()), PText(title:smoke),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(color: AppColors.grey100),
          ),
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              PText(title:'alcohol'.tr()), PText(title:water),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(color: AppColors.grey100),
          ),
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              PText(title:'sport'.tr()), PText(title:sport),
            ],
          ),
          const SizedBox(height:8,),
        ],
      ),
    );
  }
}

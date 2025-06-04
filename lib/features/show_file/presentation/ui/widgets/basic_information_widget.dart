import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/show_file/data/model/basic_information_response_model.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_bloc.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';

class BasicInformationWidget extends StatelessWidget {
  final int id;
  const BasicInformationWidget({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    ShowFileBloc showFileBloc = ShowFileBloc(showFileUseCase: getIt());
    return BlocProvider(create: (context) => showFileBloc,
      child: PBlocBuilder(
        init:() {
          showFileBloc.add(ApplyBasicInfo(id: id));
        },loadingWidget:Center(child:Center(child: CustomLoader(size:35,))),
        bloc:showFileBloc,loadedWidget:(state) {
        BasicInformationData model
        = ((state as LoadedState).data).model?.model?? BasicInformationData();
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top:20),
            padding:EdgeInsets.symmetric(horizontal:14,vertical:10),
            decoration:BoxDecoration(
                color:AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16)
            ),child:Column(
            mainAxisSize:MainAxisSize.min,
            crossAxisAlignment:CrossAxisAlignment.start,children: [
            PText(title:'p_info'.tr(),fontWeight:FontWeight.w700,fontColor:Colors.black,),
            const SizedBox(height:14,),
            itemRow(key:'birth_date', value:model.birthDate??''),
            itemRow(key:'phone', value: model.phone??''),
            itemRow(key:'email', value: model.email??''),
            itemRow(key:'weight', value: (model.weight??0).toString()),
            itemRow(key:'blood_type', value:model.bloodType??''),
            itemRow(key:'allergy', value:model.allergies??''),
            itemRow(key:'address', value:model.address??'',showDivider:false),
            const SizedBox(height:10,),
          ],),),
        );
      },),
    );
  }

  Widget itemRow({required String key,required String value,bool showDivider = true}){
    return Column(
      children: [
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,children: [
          PText(title:key.tr(),fontColor:AppColors.grayShade3,),
          Padding(
            padding: const EdgeInsets.only(top:3),
            child: PText(title:value,fontColor:AppColors.grayShade3,),
          ),
        ],),
        if(showDivider)Padding(
          padding: const EdgeInsets.symmetric(vertical:4),
          child: Divider(color:AppColors.grey100,),
        ),
      ],
    );
  }
}

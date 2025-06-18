import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/all_consultaions_response_model.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_bloc.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';
import 'package:path/path.dart';

class ConsultationWidget extends StatelessWidget {
  final int id;
  // final ValueChanged<DiagnosisData> onTap;
  const ConsultationWidget({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    ShowFileBloc showFileBloc = ShowFileBloc(showFileUseCase: getIt());
    return BlocProvider(create: (context) => showFileBloc,
      child: BlocListener<ShowFileBloc,BaseState>(listener:(context, state) {
        if(state is ButtonLoadingState){
          loadDialog();
        }else if(state is FormLoadedState){
          hideLoadingDialog();
          SafeToast.show(message: state.data?.message ?? 'Success',
              duration: const Duration(seconds: 1));
          showFileBloc.add(ApplyConsultations(id: id));
        }else if(state is ErrorState){
          hideLoadingDialog();
        }
      },child:Stack(fit: StackFit.expand,
        children: [
          PBlocBuilder(
            emptyWidget:(state) {
              return Center(child: PText(title: 'no_consultations'.tr()));
            },
            init:() {
              showFileBloc.add(ApplyConsultations(id: id));
            },loadingWidget:Center(child:Center(child: CustomLoader(size:35,))),
            bloc:showFileBloc,loadedWidget:(state) {
            List<ConsultationData> model = ((state as LoadedState).data).model?.model?? [];
            return ListView.builder(
              padding: EdgeInsets.only(bottom:20),
              itemBuilder:(context, index) {
                ConsultationData item = model[index];
                return itemRow(context,showFileBloc,item);
              },shrinkWrap:true,itemCount:model.length,);
          },),
          Positioned(
            bottom: 40,
            left: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical:14),
              ),
              onPressed: () {
                context.push(AppRouter.consultationBottomSheet,extra:{
                  'isEdit':false,
                  'onSubmit':(model) {
                    ((model as AddConsultationRequestModel)).patientId = id;
                    print('model>>'+jsonEncode(model));
                    showFileBloc.add(ApplyAddingConsultation(addConsultationRequestModel: model));
                  },
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.add,color:AppColors.primaryColor,),
                  ),
                  const SizedBox(width:22),
                  PText(
                    title: 'new_consultation'.tr(),
                    fontColor: AppColors.whiteBackground,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(width:14,)
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget itemRow(BuildContext context,ShowFileBloc showFileBloc,ConsultationData item){
    return Container(margin: EdgeInsets.only(top:20),
      padding:EdgeInsets.only(left:isArabic()?0:14,right:isArabic()?14:0),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:12,),
              PText(title:item.main_complaint??'',fontWeight:FontWeight.w700,),
              const SizedBox(height:8,),
              PText(title:(item.consultation_date??''),fontColor:AppColors.grey200,size:PSize.text13,),
              const SizedBox(height:8,),
              PText(title:'main_complaint'.tr(),fontColor:Colors.black,size:PSize.text13,),
              const SizedBox(height:8,),
              PText(title:(item.main_complaint??''),fontColor:AppColors.grayShade3,size:PSize.text13,
                fontWeight:FontWeight.w500,),
              const SizedBox(height:8,),
              PText(title:'${'notes'.tr()} : ',fontColor:Colors.black,size:PSize.text13,),
              const SizedBox(height:8,),
              PText(title:(item.notes??''),fontColor:AppColors.grayShade3,size:PSize.text13,
                fontWeight:FontWeight.w500,),
              const SizedBox(height:20,),
            ],
          ),
          Positioned(left:isArabic()?0:null,top:0,right:isArabic()?null:0,
              child:Container(margin:EdgeInsets.only(top:20,left:10,right:10),
              padding:EdgeInsets.symmetric(vertical:6,horizontal:10),
              decoration:BoxDecoration(
                  color:Color(0xffD4EDDA),
                  borderRadius:BorderRadius.circular(16)
              ),child:PText(title:'complete'.tr(),fontColor:Color(0xff61CF7B),fontWeight:FontWeight.w500,))),

          Positioned(left:isArabic()?0:null,bottom:0,right:isArabic()?null:0,child:GestureDetector(onTap:() {
            context.push(AppRouter.consultationDetailsWidget,extra: item.id??0);
          },child: Padding(
              padding: const EdgeInsets.only(bottom:14,left:14,right:14),
              child: PText(title:
              'show_details'.tr(),fontColor:AppColors.primaryColor,fontWeight:FontWeight.w500,),
            ),
          ))
        ],
      ),
    );
  }
}

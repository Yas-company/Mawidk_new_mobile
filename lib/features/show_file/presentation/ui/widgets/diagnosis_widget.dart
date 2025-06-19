import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/show_file/data/model/diagnosis_response_model.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_bloc.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/diagnosis_bottom_sheet.dart';

class DiagnosisWidget extends StatelessWidget {
  final int id;
  // final ValueChanged<DiagnosisData> onTap;
  const DiagnosisWidget({super.key,required this.id});

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
          showFileBloc.add(ApplyDiagnosis(id: id));
        }else if(state is ErrorState){
          hideLoadingDialog();
        }
      },child:Stack(fit: StackFit.expand,
        children: [
          PBlocBuilder(
            emptyWidget:(state) {
              return Center(child: PText(title: 'no_diagnosis'.tr()));
            },
            init:() {
              showFileBloc.add(ApplyDiagnosis(id: id));
            },loadingWidget:Center(child:Center(child: CustomLoader(size:35,))),
            bloc:showFileBloc,loadedWidget:(state) {
            List<DiagnosisData> model = ((state as LoadedState).data).model?.model?? [];
            return ListView.builder(
              padding: EdgeInsets.only(bottom:20),
              itemBuilder:(context, index) {
              DiagnosisData item = model[index];
              return itemRow(showFileBloc,item);
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
                showAddingDiagnosisBottomSheet(id:id,onSubmit:(model) {
                  showFileBloc.add(ApplyAddingDiagnosis(addDiagnosisRequestModel: model));
                },);
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
                    title: 'add_diagnosis'.tr(),
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

  Widget itemRow(ShowFileBloc showFileBloc,DiagnosisData item){
    return Container(margin: EdgeInsets.only(top:20),
      padding:EdgeInsets.only(left:0,right:14),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PText(title:item.diagnosis??'',fontWeight:FontWeight.w700,),
              IconButton(
                  onPressed:() {
                    showEditingDiagnosisBottomSheet(item:item,onSubmit:(model) {
                      showFileBloc.add(ApplyEditingDiagnosis(updateDiagnosisRequestModel: model, id: item.id??0));
                    },);
                  },icon: PImage(source:AppSvgIcons.icEdit)),
            ],
          ),
          const SizedBox(height:8,),
          PText(title:'diagnosis_date'.tr()+(item.date??''),fontColor:AppColors.grey200,size:PSize.text13,),
          const SizedBox(height:8,),
          PText(title:'description'.tr(),fontColor:Colors.black,size:PSize.text13,),
          const SizedBox(height:8,),
          PText(title:(item.description??''),fontColor:AppColors.grayShade3,size:PSize.text13,
            fontWeight:FontWeight.w500,),
          const SizedBox(height:8,),
          PText(title:'status'.tr(),fontColor:Colors.black,size:PSize.text13,),
          const SizedBox(height:8,),
          PText(title:(item.status??''),fontColor:AppColors.grayShade3,size:PSize.text13,
            fontWeight:FontWeight.w500,),
          const SizedBox(height:20,),
        ],
      ),
    );
  }
}

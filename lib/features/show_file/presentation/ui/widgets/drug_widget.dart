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
import 'package:mawidak/features/show_file/data/model/drug/drug_response_model.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_bloc.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/delete_bottom_sheet.dart';
import 'package:mawidak/features/show_file/presentation/ui/widgets/drug_bottom_sheet.dart';

class DrugWidget extends StatelessWidget {
  final int id;
  const DrugWidget({super.key,required this.id});

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
          showFileBloc.add(ApplyDrugs(id: id));
        }else if(state is ErrorState){
          hideLoadingDialog();
        }
      },child:Stack(fit: StackFit.expand,
        children: [
          PBlocBuilder(
            emptyWidget:(state) {
              return Center(child: PText(title: 'No Drugs'));
            },
            init:() {
              showFileBloc.add(ApplyDrugs(id: id));
            },loadingWidget:Center(child:Center(child: CustomLoader(size:35,))),
            bloc:showFileBloc,loadedWidget:(state) {
            List<DrugData> model = ((state as LoadedState).data).model?.model?? [];
            return ListView.builder(
              padding: EdgeInsets.only(bottom:20),
              itemBuilder:(context, index) {
                DrugData item = model[index];
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
                showAddingDrugBottomSheet(id:id,onSubmit:(model) {
                  showFileBloc.add(ApplyAddingDrugs(addDrugRequestModel: model));
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
                    title: 'add_drug'.tr(),
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

  Widget itemRow(ShowFileBloc showFileBloc,DrugData item){
    return Container(margin: EdgeInsets.only(top:20),
      padding:EdgeInsets.only(left:0,right:14),
      decoration:BoxDecoration(
          color:AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height:14,),
          Row(
            children: [
              PText(title:item.name??'',fontWeight:FontWeight.w700,),
              Spacer(),
              const SizedBox(width:14,),
              InkWell(
                  onTap:() {
                    showEditingDrugBottomSheet(item:item,onSubmit:(model) {
                      showFileBloc.add(ApplyEditingDrugs(updateDrugRequestModel: model, id: item.id??0));
                    },);
                  },child: PImage(source:AppSvgIcons.icEdit2)),
              const SizedBox(width:14,),
              InkWell(
                  onTap:() {
                    showDeleteDrugOrNoteBottomSheet(onTap:() {
                      showFileBloc.add(ApplyDeleteDrugs(id: item.id??0));
                    }, name:item.name??'');
                  },child: PImage(source:AppSvgIcons.icClose)),
              const SizedBox(width:14,),
            ],
          ),
          const SizedBox(height:8,),
          PText(title:(item.frequency??0).toString(),fontColor:AppColors.grey200,size:PSize.text13,),
          const SizedBox(height:8,),
          PText(title:'start_dat'.tr(),fontColor:Colors.black,size:PSize.text13,),
          const SizedBox(height:8,),
          PText(title:(item.startDate??''),fontColor:AppColors.grayShade3,size:PSize.text13,
            fontWeight:FontWeight.w500,),
          const SizedBox(height:8,),
          PText(title:'instructions'.tr(),fontColor:Colors.black,size:PSize.text13,),
          const SizedBox(height:8,),
          PText(title:(item.instructions??''),fontColor:AppColors.grayShade3,size:PSize.text13,
            fontWeight:FontWeight.w500,),
          const SizedBox(height:20,),
        ],
      ),
    );
  }
}

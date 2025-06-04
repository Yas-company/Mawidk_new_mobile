import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/features/search/data/model/search_response_model.dart';
import 'package:mawidak/features/search/presentation/bloc/search_bloc.dart';
import 'package:mawidak/features/search/presentation/bloc/search_event.dart';
import 'package:mawidak/features/search_results/presentation/ui/widgets/doctors_list_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final SearchBloc searchBloc;
  final String searchKey;
  const SearchResultWidget({super.key,required this.searchBloc,required this.searchKey});

  @override
  Widget build(BuildContext context) {
    return PBlocBuilder(bloc:searchBloc,
      init:() {
      if(searchKey.isNotEmpty){
        searchBloc.add(ApplySearchForPatient(key: searchKey));
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
                      // Navigator.pop(context);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },title:'back_to_home'.tr(),hasBloc: false,)
                  ],
                ),
              ),
            ),
          ),
        ):SizedBox.shrink();
      },
      loadedWidget:(state) {
        List<SearchData> dataList = ((state as LoadedState).data).model?.model ?? [];
        searchBloc.isMap = false;
        return  Expanded(
          child: ListView.separated(
            shrinkWrap: true,padding:EdgeInsets.only(bottom:16,top:16,left:16,right:16),
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              SearchData item = dataList[index];
              return DoctorsListWidget(onClickCard:() {
                context.push(AppRouter.doctorProfileScreen,extra:{
                  'id':item.id??0,
                  'name':item.name??'',
                  'specialization':item.specialization??''
                });
              },imageUrl:item.image??'',
                doctorName:item.name??'',
                rating: 4.8,
                specialization:item.specialization??'',
                location: 'New York, USA',
                onTap: () {
                  context.push(AppRouter.appointmentBookingScreen,extra:{
                    'id':item.id??0,
                    'name':item.name??'',
                    'specialization':item.specialization??''
                  });
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height:10,width:4,),
            itemCount:dataList.length,),
        );
      },loadingWidget:Center(child:Padding(
        padding:EdgeInsets.only(top:MediaQuery.sizeOf(context).height*0.25),
        child: CustomLoader(size:35,),
      )),);
  }
}

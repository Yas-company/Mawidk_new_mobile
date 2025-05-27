import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/patient_favourite/data/model/favourite_doctors_list_response_model.dart';
import 'package:mawidak/features/patient_favourite/presentation/bloc/favourite_bloc.dart';
import 'package:mawidak/features/patient_favourite/presentation/bloc/favourite_event.dart';
import 'package:mawidak/features/patient_favourite/presentation/ui/widgets/favourite_item_widget.dart';

class PatientFavouriteScreen extends StatelessWidget {
  const PatientFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteBloc favouriteBloc = FavouriteBloc(favouriteUseCase: getIt());
    return BlocProvider(create: (context) => favouriteBloc,
      child: Scaffold(backgroundColor: AppColors.whiteBackground,
      body:SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top:30,bottom:14),
            child: PText(title: 'favourite'.tr()),
          ),
          PBlocBuilder<FavouriteBloc,BaseState>(bloc:favouriteBloc,
              init:() {
                favouriteBloc.add(ApplyFavouriteEvent());
              },loadedWidget:(state) {
              List<FavouriteDoctorListData> dataList = ((state as LoadedState).data).model?.model ?? [];
                return  Expanded(
                  child: ListView.builder(itemBuilder:(context, index) {
                    FavouriteDoctorListData item = dataList[index];
                    return FavouriteItemWidget(onCardClick:() {
                      context.push(AppRouter.doctorProfileScreen,extra:{
                        'id':item.doctor?.id??0,
                        'name':item.doctor?.name??'',
                        'specialization':item.doctor?.specialization??''
                      });
                    },onTap:() {
                      context.push(AppRouter.appointmentBookingScreen,extra:{
                        'id':item.doctor?.id??0,
                        'name':item.doctor?.name??'',
                        'specialization':item.doctor?.specialization??''
                      });
                    },imageUrl:item.doctor?.photo??'',
                        doctorName:item.doctor?.name??'',
                        rating:4, location:'', specialization:item.doctor?.specialization??'');
                  },shrinkWrap: true,itemCount:dataList.length,),
                );
              },loadingWidget:Expanded(child: Center(child:CustomLoader(size:35,))))
        ],),
      ),),
    );
  }
}

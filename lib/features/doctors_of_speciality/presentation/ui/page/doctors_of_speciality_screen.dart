import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/doctors_of_speciality/presentation/bloc/doctors_of_speciality_bloc.dart';
import 'package:mawidak/features/doctors_of_speciality/presentation/bloc/doctors_of_speciality_event.dart';
import 'package:mawidak/features/home/data/model/doctors_for_patient_response_model.dart';
import 'package:mawidak/features/patient_favourite/presentation/ui/widgets/favourite_item_widget.dart';

class DoctorsOfSpecialityScreen extends StatelessWidget {
  final int id;
  final String specializationName;
  const DoctorsOfSpecialityScreen({super.key,required this.id,required this.specializationName});

  @override
  Widget build(BuildContext context) {
    DoctorsOfSpecialityBloc doctorsOfSpecialityBloc = DoctorsOfSpecialityBloc(contactUsUseCase:getIt());
    return BlocProvider(create:(context) => doctorsOfSpecialityBloc,
      child: MediaQuery.removePadding(context:context,removeTop:true,
        child: Scaffold(backgroundColor: AppColors.whiteBackground,
          appBar:PreferredSize(preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:20),
              child: appBar(context: context,isCenter:true,text:specializationName,backBtn:true),
            ),
          ),
          body:SafeArea(
            child: PBlocBuilder(bloc:doctorsOfSpecialityBloc,
                init:() {
                  doctorsOfSpecialityBloc.add(ApplyDoctorsOfSpecialityEvent(id: id));
                },
                loadingWidget:Center(child:CustomLoader(size:35,)),
                loadedWidget:(state) {
                  List<DoctorModel> dataList = ((state as LoadedState).data).model?.model ?? [];
                  return  ListView.builder(itemBuilder:(context, index) {
                    DoctorModel item = dataList[index];
                    return FavouriteItemWidget(onCardClick:() {
                      context.push(AppRouter.doctorProfileScreen,extra:{
                        'id':item.id??0,
                        'name':item.name??'',
                        'specialization':item.specialization??''
                      });
                    },onTap:() {
                      context.push(AppRouter.appointmentBookingScreen,extra:{
                        'id':item.id??0,
                        'name':item.name??'',
                        'specialization':item.specialization??''
                      });
                    },imageUrl:'https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg',
                        doctorName:item.name??'',
                        rating:4, location:'', specialization:item.specialization??'');
                  },shrinkWrap: true,itemCount:dataList.length,);
                },emptyWidget:(state) {
                  return Center(child: PText(title:'no_doctors'.tr()));
                },),
          ),),
      ),
    );
  }
}

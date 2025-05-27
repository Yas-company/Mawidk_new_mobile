import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/home/data/model/home_details_response_model.dart';
import 'package:mawidak/features/home/presentation/bloc/home_doctor_bloc.dart';
import 'package:mawidak/features/home/presentation/bloc/home_patient_event.dart';
import 'package:mawidak/features/home/presentation/ui/doctor_widgets/clinic_management_widget.dart';
import 'package:mawidak/features/home/presentation/ui/doctor_widgets/next_patient_widget.dart';
import 'package:mawidak/features/home/presentation/ui/doctor_widgets/patients_statistics_widget.dart';
import 'package:mawidak/features/home/presentation/ui/doctor_widgets/time_ask_widget.dart';
import 'package:mawidak/features/home/presentation/ui/page/unactive_doctor_home_screen.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/search_widget.dart';

bool isProfileDoctorIsActive = false;

class HomeScreenDoctor extends StatelessWidget {
  const HomeScreenDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    HomeDoctorBloc homeDoctorBloc = HomeDoctorBloc(homePatientUseCase:getIt());
    final List<Map<String, dynamic>> list = const [
    {
      'title': 'عيادة الرياض',
      'subTitle':'شارع العليا ، الرياض',
    },
      {
        'title': 'عيادة الرياض',
        'subTitle':'شارع العليا ، الرياض',
      },
    ];
    return BlocProvider(create:(context) => homeDoctorBloc..add(DoctorHomeDetailsEvent()),
      child: Scaffold(backgroundColor:AppColors.background,
          body:BlocConsumer<HomeDoctorBloc,BaseState>(listener:(context, state) {
            if(state is LoadingState){
              loadDialog();
            }else if(state is ErrorState){
              hideLoadingDialog();
            }else if(state is LoadedState){
              hideLoadingDialog();
            }
          },builder:(context, state) {
            DoctorHomeDetailsResponseModel model = (state is LoadedState)?
            (((state).data).model?.model ??
                DoctorHomeDetailsResponseModel()):DoctorHomeDetailsResponseModel();
            return Padding(
                padding: EdgeInsets.symmetric(horizontal:isProfileDoctorIsActive?0:14),
                child: !isProfileDoctorIsActive ? UnActiveDoctorHomeScreen():CustomScrollView(slivers:[

                  SliverToBoxAdapter(child: SearchWidget(hasFilter:false,hint:'patient_list'.tr(),
                    onTap:() => context.push(AppRouter.search),)),

                  SliverToBoxAdapter(child: Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: PText(title:'have_today'.tr(),size:PSize.text18,),
                  )),
                  SliverToBoxAdapter(child:Padding(
                    padding: EdgeInsets.only(top:10,bottom:14),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          mainAxisSize:MainAxisSize.max,children: [
                            Expanded(
                                child:TimeAskCard(title:'home_visit', image:AppSvgIcons.icHomeVisit,
                                  value:model.model?.homeVisitAppointments??0,
                                  onTap:() {

                                  },)
                            ),
                            const SizedBox(width:3,),
                            Expanded(
                                child:TimeAskCard(title:'book_online', image:AppSvgIcons.icBookOnline,
                                  value:model.model?.onlineAppointments??0,
                                  onTap:() {

                                  },)
                            ),
                          ],),
                        const SizedBox(height:3,),
                        Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          mainAxisSize:MainAxisSize.max,children: [
                            Expanded(
                                child:TimeAskCard(title:'attendance', image:AppSvgIcons.icAttendance,
                                  value:model.model?.onlineAppointments??0,
                                  onTap:() {

                                  },)
                            ),
                            const SizedBox(width:3,),
                            Expanded(
                                child:TimeAskCard(title:'follow', image:AppSvgIcons.icFollow,
                                  value:model.model?.followUpAppointments??0,
                                  onTap:() {

                                  },)
                            ),
                          ],),
                      ],
                    ),
                  ),),
                  SliverToBoxAdapter(
                    child:ClinicManagementCard(list:list, onTap:() {
                      context.push(AppRouter.locationScreen);
                    },),
                  ),
                  SliverToBoxAdapter(child:Card(color:Colors.white,
                    margin:EdgeInsets.only(top:14,bottom:14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation:0,
                    child: Padding(
                      padding: const EdgeInsets.only(top:10,right:10,left:10),
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          PText(title:'patient_statistics'.tr(),size:PSize.text18,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PatientsStatisticsCard(title:(model.model?.totalPatients??0).toString(),
                                image: AppSvgIcons.user,value:'مريض',
                                onTap:() {

                                },),
                              PatientsStatisticsCard(title:(model.model?.newPatients??0).toString(),
                                image: AppSvgIcons.icPatientsColored,value:'مرضى جدد',
                                onTap:() {

                                },),
                              PatientsStatisticsCard(title:(model.model?.averageRating??0).toString(),
                                image: AppSvgIcons.icStar,value:'تقييمات',
                                onTap:() {

                                },),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top:0,bottom:14),
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          PText(title:'next_patient'.tr(),size:PSize.text18,),
                          const SizedBox(height:14,),
                          NextPatientCard(name: 'name', title: 'title', image: 'image', date: 'date', onCall:() {

                          },),
                        ],
                      ),
                    ),
                  ),
                ],)
            );
          },)),
    );
  }
}

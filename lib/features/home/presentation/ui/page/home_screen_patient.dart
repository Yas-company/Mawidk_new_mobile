import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/p_carousel.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/doctor_or_patient/presentation/ui/widget/doctor_or_patient_widget.dart';
import 'package:mawidak/features/home/data/model/banner_response_model.dart';
import 'package:mawidak/features/home/data/model/doctors_for_patient_response_model.dart';
import 'package:mawidak/features/home/presentation/bloc/banner_bloc.dart';
import 'package:mawidak/features/home/presentation/bloc/home_patient_bloc.dart';
import 'package:mawidak/features/home/presentation/bloc/home_patient_event.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/header_widget.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/next_appointment_widget.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/search_widget.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/specializations_widget.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/top_rated_doctors_widget.dart';
import 'package:mawidak/features/search/presentation/ui/widgets/filter_bottom_sheet.dart';

class HomeScreenPatient extends StatelessWidget {
  const HomeScreenPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = const [
      {'title': 'مركز طبي', 'image': AppIcons.healthCenter},
      {'title': 'مستشفى', 'image': AppIcons.hospital,},
      {'title': 'طبيب', 'image': AppIcons.doctor,},
    ];
    final locale = context.locale;
    HomePatientBloc homePatientBloc = HomePatientBloc(homePatientUseCase:getIt());
    BannerBloc bannerBloc = BannerBloc(homeUseCase:getIt());
    Future<void> refreshData() async {
      bannerBloc.add(BannersEvent());
      homePatientBloc.add(DoctorsOfPatientEvent());
    }
    return BlocProvider(create: (context) => homePatientBloc,
      child: Scaffold(backgroundColor:AppColors.background,
          body: RefreshIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.whiteColor,
            onRefresh: refreshData,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:14),
              child: CustomScrollView(slivers:[
                SliverToBoxAdapter(child:SearchWidget(hintFontSize:12.3,hasFilter:false,isEnabled: false,onTap:() {
                  context.push(AppRouter.search);
                  // context.push(AppRouter.searchResults,extra:'');
                },onTapFilter:() {
                  // filterBottomSheet(context,() {
                  //
                  // },);
                },)),
                // SliverToBoxAdapter(child:ImageCarousel(imageUrls: itemList)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20,bottom:14),
                    child: PBlocBuilder(init:() {
                      bannerBloc.add(BannersEvent());
                    },bloc:bannerBloc,loadedWidget:(state) {
                      List<BannerData> itemList = ((state as LoadedState).data).model?.model ?? [];
                      return PCarousel(itemList: itemList);
                      // return PListViewCarousel<BannerData>(
                      //   items: itemList,dotColor:Color(0xffD9D9D9),
                      //   height: 140,
                      //   itemBuilder: (item) {
                      //     return InkWell(
                      //       onTap: () {
                      //       },child: Container(
                      //       width: MediaQuery.sizeOf(context).width*0.92,
                      //       margin: EdgeInsets.only(
                      //           left: itemList.length == 1 ? 0 : 20),
                      //       child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(16),
                      //           child: PImage(
                      //               source: item.image  ?? '',
                      //               fit: BoxFit.fill)),
                      //     ),
                      //     );
                      //   },
                      // );
                    },),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HeaderWidget(hasMore:false,title: 'next_meeting'.tr(),),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top:14,bottom:14),
                    child: Center(child: PText(title: 'Soon')),
                    // child: NextAppointmentWidget(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:14),
                    child: Center(
                      child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        spacing:14,
                        mainAxisSize:MainAxisSize.max,children: [
                          Expanded(
                            child: DoctorOrPatientWidget(title:items[0]['title'],
                              image:items[0]['image'],onChange:() async {},),
                          ),
                          Expanded(
                            child: DoctorOrPatientWidget(title:items[1]['title'],
                              image:items[1]['image'],onChange:() async {},),
                          ),
                          Expanded(
                            child: DoctorOrPatientWidget(title:items[2]['title'],
                              image:items[2]['image'],onChange:() async {},),
                          ),
                        ],),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HeaderWidget(title: 'specializations'.tr(), onClickMore: () {
                    context.push(AppRouter.allSpecializationsScreen);
                  },),
                ),
                SliverToBoxAdapter(child:Padding(
                  padding: const EdgeInsets.only(top:10,bottom:14),
                  child: SpecializationCarousel(specializations: specializations),
                )),

                // SliverToBoxAdapter(
                //   child: HeaderWidget(title: 'top_rated_doctors'.tr(), onClickMore: () {
                //
                //   },),
                // ),
                // SliverToBoxAdapter(child: const SizedBox(height:14,)),

                // SliverToBoxAdapter(
                //   child: PBlocBuilder(init:() {
                //     homePatientBloc.add(DoctorsOfPatientEvent());
                //   },bloc:homePatientBloc,loadedWidget:(state) {
                //     List<DoctorModel> itemList = ((state as LoadedState).data).model?.model ?? [];
                //     return SizedBox(height:170,
                //       child: ListView.separated(scrollDirection:Axis.horizontal,
                //         shrinkWrap: true,padding:EdgeInsets.only(bottom:20),
                //         // physics: NeverScrollableScrollPhysics(),
                //         itemBuilder: (context, index) {
                //           DoctorModel item = itemList[index];
                //           return SizedBox(width: 164,
                //             child: TopRatedDoctorCard(
                //               imageUrl: item.image??'',
                //               doctorName: item.name??'',
                //               rating: 4.8,
                //               specialization: item.specialization??'',
                //               location: 'New York, USA',
                //               onTap: () {
                //                 // context.push(AppRouter.doctorRatingsScreen,extra:item.id??0);
                //                 context.pushNamed(AppRouter.doctorProfileScreen,extra: {
                //                   // 'id':110,
                //                   'id':item.id??0,
                //                   'name':item.name??'',
                //                   'specialization':item.specialization??''
                //                 });
                //                 // context.push(AppRouter.doctorProfileScreen,extra:item.id??0);
                //               },
                //             ),
                //           );
                //         },
                //         separatorBuilder: (context, index) => SizedBox(height: 12,width:4,),
                //         itemCount:itemList.length,
                //       ),
                //     );
                //   },),
                // ),


                // SliverToBoxAdapter(
                //   child: HeaderWidget(title: 'top_rated_hospitals'.tr(), onClickMore: () {
                //
                //   },),
                // ),
                SliverToBoxAdapter(child: const SizedBox(height:14,)),

                // SliverToBoxAdapter(
                //   child: PBlocBuilder(init:() {
                //     homePatientBloc.add(DoctorsOfPatientEvent());
                //   },bloc:homePatientBloc,loadedWidget:(state) {
                //     List<DoctorModel> itemList = [
                //       DoctorModel(id: 1,name: 'السعودي الالماني'),
                //       DoctorModel(id: 2,name: 'السعودي الالماني'),
                //       DoctorModel(id: 3,name: 'السعودي الالماني'),
                //     ];
                //     return SizedBox(height:165,
                //       child: ListView.separated(scrollDirection:Axis.horizontal,
                //         shrinkWrap: true,padding:EdgeInsets.only(bottom:20),
                //         // physics: NeverScrollableScrollPhysics(),
                //         itemBuilder: (context, index) {
                //           DoctorModel item = itemList[index];
                //           return SizedBox(width: 164,
                //             child: TopRatedDoctorCard(showRating:true,
                //               imageUrl:item.image??'',
                //               doctorName: item.name??'',
                //               rating: 4.8,
                //               specialization: item.specialization??'',
                //               location: 'New York, USA',
                //               onTap: () {
                //                 // context.push(AppRouter.doctorRatingsScreen,extra:item.id??0);
                //                 // context.pushNamed(AppRouter.doctorProfileScreen,extra: {
                //                 //   'id':110,
                //                 //   'name':item.name??'',
                //                 // });
                //                 // context.push(AppRouter.doctorProfileScreen,extra:item.id??0);
                //               },
                //             ),
                //           );
                //         },
                //         separatorBuilder: (context, index) => SizedBox(height: 12,width:4,),
                //         itemCount:itemList.length,
                //       ),
                //     );
                //   },),
                // )

                // PBlocBuilder<BannerBloc, BaseState>(
                //   height: 160,
                //   init: () {
                //     bannerBloc.add(const HomeBannerEvent());
                //   },
                //   loadedWidget: (state) {
                //     List<BannerData> itemList =
                //         ((state as LoadedState).data).model.model ?? [];
                //     if (itemList.isEmpty) {
                //       return const EmptyWidget();
                //     }
                //     return PListViewCarousel<BannerData>(
                //       items: itemList,
                //       showIndicator: false,
                //       // viewportFraction:itemList.length==1?1:0.90,
                //       height: 170,
                //       itemBuilder: (item) {
                //         return InkWell(
                //           onTap: () {
                //             UrlLauncherManager.redirectUrl(item.link ?? '');
                //           },
                //           child: Container(
                //             width: itemList.length == 1
                //                 ? MediaQuery.sizeOf(context).width * 0.91
                //                 : MediaQuery.sizeOf(context).width * 0.80,
                //             margin: EdgeInsets.only(
                //                 left: itemList.length == 1 ? 0 : 20),
                //             child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(4),
                //                 child: PImage(
                //                     source: item.attachmentUrl ?? '',
                //                     fit: BoxFit.fill)),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   bloc: bannerBloc,
                // )
              ],)
            ),
          )),
    );
  }
}

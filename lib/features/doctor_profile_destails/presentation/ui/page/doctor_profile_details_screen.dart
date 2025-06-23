import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
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
import 'package:mawidak/features/doctor_profile/data/model/doctor_profile_response_model.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_request_model.dart';
import 'package:mawidak/features/doctor_profile/presentation/bloc/doctor_profile_bloc.dart';
import 'package:mawidak/features/doctor_profile/presentation/bloc/doctor_profile_event.dart';
import 'package:mawidak/features/doctor_profile/presentation/ui/widgets/doctor_rating_by_patient.dart';

class DoctorProfileDetailsScreen extends StatefulWidget {
  final int id;
  const DoctorProfileDetailsScreen({super.key,required this.id});
  @override
  State<DoctorProfileDetailsScreen> createState() => DoctorProfileDetailsScreenState();
}

class DoctorProfileDetailsScreenState extends State<DoctorProfileDetailsScreen> {
  DoctorProfileBloc doctorProfileBloc = DoctorProfileBloc(doctorProfileUseCase: getIt());
  @override
  Widget build(BuildContext context) {
    bool? isFavourite ;
    return BlocProvider(create: (context) => doctorProfileBloc,
      child: MediaQuery.removePadding(
        context: context, removeTop: true,
        child: Scaffold(
            backgroundColor:AppColors.whiteBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.only(top:24),
                child: appBar(context: context,backBtn: true,text:'profile'.tr(),isCenter:true,
                backgroundColor:AppColors.primaryTransparent),
              ),
            ),
            body:PBlocBuilder(bloc:doctorProfileBloc,init:() {
              doctorProfileBloc.add(ApplyDoctorProfileEvent(id: widget.id));
            },loadedWidget:(state) {
              DoctorModel item = ((state as LoadedState).data).model?.model ?? DoctorModel();
              // print('fe>${(state).data.model}');
              if((state).data.model==null){
                return Center(child: PText(title: 'no_doctor_details'.tr()));
              }
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Container(padding: EdgeInsets.symmetric(horizontal:24),
                          color: AppColors.primaryTransparent,
                          child: Stack(clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    (item.photo ?? '').isEmpty
                                        ? CircleAvatar(
                                      radius: 35,
                                      backgroundColor: AppColors.whiteColor,
                                      child: Icon(Icons.person),
                                    )
                                        : PImage(
                                      source: ApiEndpointsConstants.baseImageUrl + (item.photo ?? ''),
                                      isCircle: true,
                                      width: 60, height: 60,
                                    ),
                                    const SizedBox(width: 14),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          PText(title: item.name ?? ''),
                                          const SizedBox(height: 6),
                                          PText(
                                            title: item.specialization ?? '',
                                            fontColor: AppColors.grey200,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height:110,),
                              Positioned(
                                bottom:-8, right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    // context.push(AppRouter.doctorProfileDetailsScreen, extra: 110);
                                    context.push(AppRouter.updateDoctorProfileScreen, extra: item);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: AppColors.primaryColor),
                                      color: AppColors.shade3.withOpacity(0.6),
                                    ),
                                    child: PText(
                                      title: 'edit_profile'.tr(),
                                      fontColor: AppColors.grayShade3,
                                      size: PSize.text13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height:30,),
                        Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                          infoItem(title: 'patient'.tr(), image: AppSvgIcons.icPatient, value:
                          (item.countOfPatients??0).toString()),
                          infoItem(title: 'years_experience'.tr(), image: AppSvgIcons.icExperience, value:
                          (item.yearsOfExperience??0).toString()),
                          infoItem(title: 'evaluations'.tr(), image: AppSvgIcons.icRatings, value:
                          (item.ratingsCount??0).toString(),onTap:() {
                            context.pushNamed(AppRouter.doctorRatingsScreen,extra:{
                              'id':item.id??0,'isRating':true,
                              'name':item.name??'',
                              'image':item.photo??'',
                              'specialization':item.specialization??'',
                            });
                          },),
                          infoItem(title: 'comments'.tr(), image: AppSvgIcons.icComments, value:
                          (item.commentsCount??0).toString(),onTap:() {
                            context.pushNamed(AppRouter.doctorRatingsScreen,extra:{
                              'id':item.id??0,'isRating':false,
                              'name':item.name??'',
                              'image':item.photo??'',
                              'specialization':item.specialization??'',
                            });
                          },),
                        ],),
                        const SizedBox(height:14,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:24),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            PText(title: 'about_doctor'.tr(),fontWeight:FontWeight.w700,),
                            const SizedBox(height:6,),
                            PText(title:item.aboutDoctor??'غير متاح',size:PSize.text14,
                              fontColor: AppColors.grey200,),
                            const SizedBox(height:14,),
                            PText(title: 'sub_specialties'.tr(),fontWeight:FontWeight.w700,),
                            const SizedBox(height:10,),
                            Wrap(
                              spacing: 6, runSpacing: 6,
                              children: List.generate((item.subspecialities??[]).length, (index) {
                                final model = (item.subspecialities??[])[index];
                                return SizedBox(child: Container(
                                  padding: const EdgeInsets.symmetric(vertical:8,horizontal:10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor2200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: PText(
                                    title: model.name??'',
                                    // title: item??'',
                                    fontWeight:FontWeight.w400,
                                    size: PSize.text14,
                                    fontColor:AppColors.primaryColor,
                                  ),
                                ),
                                );
                              }),
                            ),
                            const SizedBox(height:14,),
                            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                              PText(title: 'evaluations_el'.tr(),fontWeight:FontWeight.w700,),
                              GestureDetector(onTap:() {
                                context.pushNamed(AppRouter.doctorRatingsScreen,extra:{
                                  'id':item.id??0,'isRating':true,
                                  'name':item.name??'',
                                  'image':item.photo??'',
                                  'specialization':item.specialization??'',
                                });
                              },child: Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                                  child: PText(fontWeight:FontWeight.w500,size:PSize.text13,
                                    title:'evaluations'.tr(),fontColor:AppColors.grey200,
                                  ),
                                ),
                                Positioned(bottom:5, left: 0, right: 0,
                                  child: Container(height: 1,
                                    color:AppColors.grey200,),
                                ),
                              ],
                              ),
                              )
                            ],),const SizedBox(height:14,),
                            if((item.ratings??[]).isNotEmpty)
                              DoctorRatingByPatient(ratings:(item.ratings??[]).first,
                                rate:item.averageRating??0.0,)
                          ],),
                        )
                      ],),
                    ),
                  ),
                  const SizedBox(height:14,),
                ],
              );
            },loadingWidget:Center(child:CustomLoader(size:35,)))),
      ),
    );
  }

  Widget infoItem({required String title,required String image,required String value,final VoidCallback? onTap}){
    return InkWell(hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,onTap:onTap,
      child: Column(children: [
        CircleAvatar(radius:25,
            backgroundColor:AppColors.primaryColor1100,
            child: PImage(source:image,width: 21, height: 21,
              color:AppColors.primaryColor,)
        ),
        const SizedBox(height:4),
        PText(title:value,alignText:TextAlign.center,fontColor:AppColors.primaryColor,
          fontWeight: FontWeight.w700,),
        PText(title: title,fontColor:AppColors.grey200,fontWeight: FontWeight.w400,
            size:PSize.text13)
      ],),
    );
  }
}

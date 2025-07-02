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
import 'package:mawidak/features/appointments/presentation/ui/widgets/price_card_widget.dart';

class DoctorProfileScreen extends StatefulWidget {
  final int id;
  final String name;
  final String specialization;
  const DoctorProfileScreen({super.key,required this.id,required this.name,required this.specialization});
  @override
  State<DoctorProfileScreen> createState() => DoctorProfileScreenState();
}

class DoctorProfileScreenState extends State<DoctorProfileScreen> {
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
                child: appBar(context: context,backBtn: true,text:'doctor_details'.tr(),isCenter:true,actions:[
                  GestureDetector(onTap:() {
                    SafeToast.show(message: 'Coming soon while publish the app',
                    type: MessageType.warning);
                  },child: Container(margin:EdgeInsets.only(top:20),
                        padding:EdgeInsets.all(9.5),
                        decoration:BoxDecoration(shape:BoxShape.circle,
                            border: Border.all(color:AppColors.grey100)),
                        child:PImage(source:AppSvgIcons.share,width:16,height:16)),
                  ),
                  const SizedBox(width:8,),
                  BlocConsumer<DoctorProfileBloc,BaseState>(listener:(context, state) {
                    if(state is FavouriteLoadingState){
                      loadDialog();
                    }else if (state is FavouriteLoadedState){
                      hideLoadingDialog();
                      doctorProfileBloc.isFavourite=false;
                      SafeToast.show(message:state.data?.message ?? '');
                    }
                  },builder:(context, state) {
                    if(state is LoadedState){
                      isFavourite = ((state).data).model?.model.isFavorite ?? false;
                    }else if(state is FavouriteLoadedState){
                      isFavourite = ((state).data).model?.model.isFavorite ?? false;
                    }
                    doctorProfileBloc.isFavourite = isFavourite ?? false;
                    return GestureDetector(onTap:() {
                      doctorProfileBloc.add(AddToFavouriteEvent(model:FavouriteRequestModel(
                          doctorId: widget.id,isFavorite:!doctorProfileBloc.isFavourite
                      )));
                    },child: Container(margin:EdgeInsets.only(top:20),
                        padding:EdgeInsets.all(9.5),
                        decoration:BoxDecoration(shape:BoxShape.circle,
                            border:Border.all(color:AppColors.grey100)),
                        child:PImage(source: AppSvgIcons.love,width:16,height:16,
                            color:doctorProfileBloc.isFavourite?Colors.red:AppColors.grayColor200)),
                    );
                  },),
                  const SizedBox(width:10,),
                ]),
              ),
            ),
            body:Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: PBlocBuilder(bloc:doctorProfileBloc,init:() {
                doctorProfileBloc.add(ApplyDoctorProfileEvent(id: widget.id));
              },loadedWidget:(state) {
                DoctorModel item = ((state as LoadedState).data).model?.model ?? DoctorModel();
                // print('fe>${(state).data.model}');
                if((state).data.model==null){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    SafeToast.show(message: state.data?.message ?? '',type:MessageType.error);
                    Navigator.pop(context);
                  });
                  return SizedBox.shrink();
                  // return Center(child: PText(title: 'no_doctor_details'.tr()));
                }
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            (item.photo??'').isEmpty?CircleAvatar(radius:35,
                            backgroundColor: AppColors.whiteColor,
                            child:Icon(Icons.person),):PImage(
                              source:ApiEndpointsConstants.baseImageUrl+(item.photo??''),
                              isCircle:true,width:60,height:60,),
                            const SizedBox(width:14,),
                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,children: [
                                PText(title:item.name??''),const SizedBox(height:6,),
                                PText(title:item.specialization??'',fontColor:AppColors.grey200,),
                                // const SizedBox(height:6,),
                                // Row(
                                //   children: [
                                //     const Icon(Icons.my_location, size: 20, color:AppColors.primaryColor),
                                //     const SizedBox(width: 4),
                                //     PText(title:'location',fontColor:AppColors.grayShade3,
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ],
                                // )
                              ],),
                            )
                          ],),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:4,horizontal:8),
                            child: Divider(color:AppColors.grey100,),
                          ),
                          const SizedBox(height:8,),
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
                      ),
                    ),
                    PButton(
                      isFitWidth: true,
                      onPressed: () {
                        context.push(AppRouter.appointmentBookingScreen,extra:{
                          'id':widget.id,
                          'name':widget.name,
                          'specialization':widget.name
                        });
                      },
                      hasBloc: false,
                      title: 'book_appointment'.tr(),
                    ),
                    const SizedBox(height:14,),
                  ],
                );
              },loadingWidget:Center(child:CustomLoader(size:35,))),
            )),
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

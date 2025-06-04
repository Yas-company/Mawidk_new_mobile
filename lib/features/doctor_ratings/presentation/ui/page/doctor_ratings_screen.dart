import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/doctor_ratings/data/model/doctor_ratings_response_model.dart';
import 'package:mawidak/features/doctor_ratings/presentation/bloc/doctor_ratings_bloc.dart';
import 'package:mawidak/features/doctor_ratings/presentation/bloc/doctor_ratings_event.dart';
import 'package:mawidak/features/doctor_ratings/presentation/ui/widgets/doctor_ratings_item.dart';

class DoctorRatingsScreen extends StatefulWidget {
  final int id;
  final bool isRating;
  final String name;
  const DoctorRatingsScreen({super.key,required this.id,required this.name,
  this.isRating = true});
  @override
  State<DoctorRatingsScreen> createState() => DoctorRatingsScreenState();
}

class DoctorRatingsScreenState extends State<DoctorRatingsScreen> with TickerProviderStateMixin {
  DoctorRatingsBloc doctorRatingsBloc = DoctorRatingsBloc(doctorRatingsUseCase:getIt());
  List<bool> _visibleItems = [];

  Future<void> refreshData() async {
    final completer = Completer<void>();
    // Listen once for the loaded state
    final subscription = doctorRatingsBloc.stream.listen((state) {
      if (state is LoadedState) {
        final list = (state.data).model?.model ?? [];
        _runStaggeredAnimation(list.length);
        completer.complete();
      }
    });
    // Trigger refresh
    doctorRatingsBloc.add(ApplyDoctorRatingsEvent(id: widget.id,isRate: widget.isRating));

    // Wait for completion
    await completer.future;
    await subscription.cancel();
  }


  void _runStaggeredAnimation(int count) async {
    _visibleItems = List.generate(count, (_) => false);
    for (int i = 0; i < count; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _visibleItems[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context, removeTop: true,
      child: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.whiteColor,
        onRefresh: refreshData,
        child: Scaffold(
          backgroundColor:AppColors.whiteBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:24),
              // child: appBar(context: context,backBtn: true,text:widget.name,isCenter:true,actions:[
              child: appBar(context: context,backBtn: true,
                  text:widget.isRating?'all_evaluations'.tr():'all_comments'.tr(),isCenter:true,actions:[
                // Container(margin:EdgeInsets.only(top:20),
                //     padding:EdgeInsets.all(11),
                //     decoration:BoxDecoration(shape:BoxShape.circle,
                //         border: Border.all(color:AppColors.grey100)),
                //     child:PImage(source:AppSvgIcons.share,width:20,height:18,)),
                // const SizedBox(width:10,),
                // Container(margin:EdgeInsets.only(top:20),
                //     padding:EdgeInsets.all(11),
                //     decoration:BoxDecoration(shape:BoxShape.circle,
                //         border: Border.all(color:AppColors.grey100)),
                //     child:PImage(source: AppSvgIcons.love,width:20,height:18)),
                // const SizedBox(width:10,),
              ]),
            ),
          ),
          body: BlocProvider(
            create: (context) => doctorRatingsBloc,
            child:Center(
              child: PBlocBuilder<DoctorRatingsBloc,BaseState>(bloc:doctorRatingsBloc,
                  init:() {
                    // doctorRatingsBloc.add(ApplyDoctorRatingsEvent(id: id));
                    doctorRatingsBloc.add(ApplyDoctorRatingsEvent(id: widget.id,
                    isRate: widget.isRating));
                  },loadingWidget: Center(child:CustomLoader(size:35,)),
                  loadedWidget:(state) {
                    List<DoctorRating> dataList = ((state as LoadedState).data).model?.model ?? [];
        
                    if (_visibleItems.length != dataList.length) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _runStaggeredAnimation(dataList.length);
                      });
                    }
        
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20),
                      child: Column(children: [
                        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                          PText(title:widget.isRating?'evaluations'.tr():'comments'.tr(),fontWeight:FontWeight.w700,),
                          Stack(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                                child: PText(fontWeight:FontWeight.w500,size:PSize.text13,
                                  title:
                                  '${dataList.length} ${widget.isRating?'evaluate'.tr():'comment'.tr()}',fontColor:AppColors.grey200,
                                ),
                              ),
                              Positioned(bottom:5, left: 0, right: 0,
                                child: Container(height: 1,
                                  color:AppColors.grey200,),
                              ),
                            ],
                          )
                        ],),
                        ListView.builder(padding:EdgeInsets.only(top:20),
                          itemBuilder:(context, index) {
                          final visible = _visibleItems.length > index && _visibleItems[index];
                          return AnimatedOpacity(
                              opacity: visible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedSlide(
                              duration: const Duration(milliseconds: 500),
                                  offset: visible ? Offset.zero : const Offset(0, 0.2),
                                  child: DoctorRatingsItem(doctorRating:dataList[index],
                                  showRating: widget.isRating,)));
                        },itemCount:dataList.length,shrinkWrap:true,)
                      ],),
                    );
                  },),
            )
          ),
        ),
      ),
    );
  }
}

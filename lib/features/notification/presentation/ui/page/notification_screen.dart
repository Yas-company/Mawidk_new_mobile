import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/notification/data/model/notification_response_model.dart';
import 'package:mawidak/features/notification/domain/use_case/notification_use_case.dart';
import 'package:mawidak/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mawidak/features/notification/presentation/bloc/notification_event.dart';
import 'package:mawidak/features/notification/presentation/ui/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationBloc notificationBloc = NotificationBloc(notificationUseCase:getIt());
    return MediaQuery.removePadding(context: context, removeTop: true,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:20),
              child: appBar(context: context,isCenter:true,text: 'الاشعارات'),
            )),
      backgroundColor:AppColors.whiteBackground,
      body:BlocProvider(create: (context) => notificationBloc,
        child: PBlocBuilder(bloc:notificationBloc,
            init:() {
              notificationBloc.add(ApplyGetNotificationEvent());
            },loadingWidget:Center(child:CustomLoader(size:35,)),
            loadedWidget:(state) {
              NotificationParentModel model
              = ((state as LoadedState).data).model?.model?? NotificationParentModel();

              dynamic todayList = model.today??[];
              dynamic yesterdayList = model.yesterday??[];
              dynamic olderList = model.older??[];

              return SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:14,right:14,bottom:18,top:14),
                      child: PText(title:'اليوم',fontColor:AppColors.grey200,),
                    ),
                    todayList.isEmpty?
                    Center(child: PText(title: 'لا يوجد اشعارات')):
                    ListView.builder(physics:NeverScrollableScrollPhysics(),itemBuilder:(context, index) {
                      NotificationModel model = todayList[index];
                      return NotificationItem(notification: model,onTap:() async {
                        final response = await NotificationUseCase(notificationRepository:getIt()).
                        getNotificationById(id:model.id??0);
                        response.fold((l) => null,(r) {
                          notificationBloc.add(ApplyNotificationById(id: model.id??0));
                        },);
                        // notificationBloc.add(ApplyNotificationById(id: model.id??0));
                      },);
                    },itemCount:todayList.length,shrinkWrap:true,),
                    Padding(
                      padding: const EdgeInsets.only(left:14,right:14,bottom:18,top:24),
                      child: PText(title:'الامس',fontColor:AppColors.grey200,),
                    ),
                    yesterdayList.isEmpty?
                    Center(child: PText(title: 'لا يوجد اشعارات')):
                    ListView.builder(physics:NeverScrollableScrollPhysics(),itemBuilder:(context, index) {
                      NotificationModel model = yesterdayList[index];
                      return NotificationItem(notification: model,onTap:() async {
                        // final response = await NotificationUseCase().getNotificationById(id:event.id);
                        notificationBloc.add(ApplyNotificationById(id: model.id??0));
                      },);
                    },itemCount:yesterdayList.length,shrinkWrap:true,),
                    Padding(
                      padding: const EdgeInsets.only(left:14,right:14,bottom:18,top:24),
                      child: PText(title:'الاقدم',fontColor:AppColors.grey200,),
                    ),
                    olderList.isEmpty?
                    Center(child: PText(title: 'لا يوجد اشعارات')):
                    ListView.builder(physics:NeverScrollableScrollPhysics(),itemBuilder:(context, index) {
                      NotificationModel model = olderList[index];
                      return NotificationItem(notification: model,onTap:() async {
                        // final response = await NotificationUseCase().getNotificationById(id:event.id);
                        notificationBloc.add(ApplyNotificationById(id: model.id??0));
                      },);
                    },itemCount:olderList.length,shrinkWrap:true,),
                  ],
                ),
              );
            },)
      ),),
    );
  }
}

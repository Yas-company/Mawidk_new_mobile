import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/appointment/presentation/bloc/appointment_booking_bloc.dart';
import 'package:mawidak/features/appointment/presentation/ui/widgets/day_picker_widget.dart';
import 'package:mawidak/features/appointment/presentation/ui/widgets/time_picker_widget.dart';
import '../../../../../core/data/assets_helper/app_svg_icon.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final int id;
  final String name;
  final String specialization;
  const AppointmentBookingScreen({super.key,required this.id,required this.name,
  required this.specialization});
  @override
  AppointmentBookingScreenState createState() => AppointmentBookingScreenState();
}

class AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  DateTime selectedDate = DateTime.now();
  AppointmentBookingBloc appointmentBookingBloc = AppointmentBookingBloc(appointmentBookingUseCase:getIt());
  @override
  Widget build(BuildContext context) {
    appointmentBookingBloc.model.doctorId = widget.id;
    return BlocProvider(create:(context) => appointmentBookingBloc,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MediaQuery.removePadding( context: context, removeTop: true,
          child: Scaffold(
            backgroundColor:AppColors.whiteBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.only(top:24),
                child: appBar(context: context,backBtn: true,text:widget.name,isCenter:true,actions:[
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
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  //   PImage(source:'https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg',
                  //     isCircle:true,width:60,height:60,),
                  //   const SizedBox(width:14,),
                  //   Padding(
                  //     padding: const EdgeInsets.only(top:10),
                  //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.center,children: [
                  //         PText(title:widget.name??''),const SizedBox(height:6,),
                  //         PText(title:widget.specialization??'',fontColor:AppColors.grey200,),
                  //         // const SizedBox(height:6,),
                  //         // Row(
                  //         //   children: [
                  //         //     const Icon(Icons.my_location, size: 20, color:AppColors.primaryColor),
                  //         //     const SizedBox(width: 4),
                  //         //     PText(title:'location',fontColor:AppColors.grayShade3,
                  //         //       overflow: TextOverflow.ellipsis,
                  //         //     ),
                  //         //   ],
                  //         // )
                  //       ],),
                  //   )
                  // ],),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical:8,horizontal:8),
                  //   child: Divider(color:AppColors.grey100,),
                  // ),

                  ArabicDatePicker(onChoose:(p0) {
                    appointmentBookingBloc.model.appointmentDate = p0;
                  },),

                  TimePickerWidget(onChoose:(p0) {
                    appointmentBookingBloc.model.appointmentTime = p0;
                  },),

                  Padding(
                    padding: const EdgeInsets.only(top:6,bottom:8),
                    child: PText(title:'notes'.tr(),),
                  ),
                 PTextField(hintText:'add_note'.tr(), feedback:(value) {
                   appointmentBookingBloc.model.notes = value;
                 },maxLines:4,),
                  SizedBox(height: 24),

                  PButton(title:'book_appointment'.tr(),onPressed:() {
                    context.push(AppRouter.appointmentPaymentScreen,extra:appointmentBookingBloc.model);
                  },hasBloc:false,isFitWidth:true,
                      icon:PImage(source:
                      isArabic()?AppSvgIcons.icNext:AppSvgIcons.icBack,
                        height:14,fit:BoxFit.scaleDown,)),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}







import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_bloc.dart';
import 'package:mawidak/features/appointments/presentation/ui/widgets/all_appointments_screen.dart';

class AppointmentsScreen extends StatefulWidget {

  const AppointmentsScreen({super.key});

  @override
  AppointmentsScreenState createState() => AppointmentsScreenState();
}

class AppointmentsScreenState extends State<AppointmentsScreen> {
  DoctorAppointmentsBloc doctorAppointmentsBloc = DoctorAppointmentsBloc(doctorAppointmentsUseCase:getIt());
  final List<String> tabs = ['all'.tr(), 'in_clinic'.tr(), 'remote'.tr(),];
  int _selectedIndex = 0;
  late List<Widget?> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabViews = List.filled(tabs.length, null);
    _tabViews[0] = _buildTabWidget(0); // Load the first tab initially
  }

  Widget _buildCustomTab(int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          if (_tabViews[index] == null) {
            _tabViews[index] = _buildTabWidget(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(left: 0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.whiteBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.grayColor200 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            tabs[index],
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? AppColors.primaryColor : AppColors.grey200,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabWidget(int index) {
    switch (index) {
      case 0:
        return AllAppointmentsScreen(doctorAppointmentsBloc:doctorAppointmentsBloc,);
      case 1:
        return AllAppointmentsScreen(doctorAppointmentsBloc:doctorAppointmentsBloc,);
      case 2:
        return AllAppointmentsScreen(doctorAppointmentsBloc:doctorAppointmentsBloc,);
      default:
        return Center(child: Text("Not Implemented"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: BlocProvider(create: (context) => doctorAppointmentsBloc,
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding:  EdgeInsets.only(top: 24,right:isArabic()?30:50),
              child: appBar(
                context: context,
                backBtn: false, isCenter: true,
                text: 'times'.tr(),
              ),
            ),
          ),
          backgroundColor: AppColors.whiteBackground,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<DoctorAppointmentsBloc,BaseState>(builder:(context, state) {
                  return InkWell(hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap:(state is LoadingState || state is InitialState)?null:() {
                    // if(doctorAppointmentsBloc.pendingList.isNotEmpty){
                    context.push(AppRouter.doctorPendingAppointments,
                        // extra:doctorAppointmentsBloc.pendingList
                        extra:doctorAppointmentsBloc
                    );
                    // }else{
                    //   // SafeToast.show(message: 'message',type: MessageType.warning);
                    // }
                  },child: Container(padding:EdgeInsets.only(top:14,bottom:14,left:20,right:isArabic()?20:14),
                      decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(16),
                          color:AppColors.whiteColor
                      ),child:Row(children: [
                        (state is LoadingState || state is InitialState)?
                        SizedBox.shrink():
                        Container(padding:EdgeInsets.all(10),decoration:BoxDecoration(shape:BoxShape.circle,
                          color: AppColors.primaryColor,),
                          child:PText(title:doctorAppointmentsBloc.pendingList.length.toString(),
                            fontColor:Colors.white,size:PSize.text14,),),
                        // BlocBuilder<DoctorAppointmentsBloc,BaseState>(builder:(context, state) {
                        //   if(state is LoadingState || state is InitialState){
                        //     return SizedBox.shrink();
                        //   }
                        //   return Container(padding:EdgeInsets.all(10),decoration:BoxDecoration(shape:BoxShape.circle,
                        //   color: AppColors.primaryColor,),
                        //   child:PText(title:doctorAppointmentsBloc.pendingList.length.toString(),
                        //     fontColor:Colors.white,size:PSize.text14,),);
                        // },),
                        const SizedBox(width:14,),
                        PText(title:'pending_requests'.tr(),size:PSize.text14,fontWeight:FontWeight.w500,),
                        Spacer(),
                        isArabic()?
                        PImage(source:AppSvgIcons.icArrow,color:AppColors.primaryColor,):
                            Icon(Icons.arrow_forward_ios_sharp,color:AppColors.primaryColor,)
                      ],),),
                  );
                },),
                Container(margin:EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left:10,right:10,),
                  decoration: BoxDecoration(
                  color: AppColors.whiteColor, // background of entire TabBar
                  borderRadius: BorderRadius.circular(16),
                ),height: 46,
                  child: Row(
                    children: List.generate(
                      tabs.length,
                          (index) => Expanded(child: SizedBox(height:32,child: _buildCustomTab(index))),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                PText(title: getArabicFormattedDate(),
                  fontColor: AppColors.grey200,
                  size: PSize.text14,
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: List.generate(
                      tabs.length,
                          (index) => _tabViews[index] ?? const SizedBox(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getArabicFormattedDate() {
  final now = DateTime.now();
  final day = DateFormat('d', 'ar').format(now);         // ٥
  final month = DateFormat('MMMM', 'ar').format(now);    // مايو
  return 'اليوم، $day $month';
}
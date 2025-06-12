import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/patient_appointments/data/model/patient_appointments_response_model.dart';
import 'package:mawidak/features/patient_appointments/presentation/bloc/patient_appointments_bloc.dart';
import 'package:mawidak/features/patient_appointments/presentation/bloc/patient_appointments_event.dart';
import 'package:mawidak/features/patient_appointments/presentation/ui/widgets/cancel_bottom_sheet.dart';
import 'package:mawidak/features/patient_appointments/presentation/ui/widgets/patient_appointments_card_widget.dart';

class PatientAppointmentsScreen extends StatefulWidget {

  const PatientAppointmentsScreen({super.key});

  @override
  PatientAppointmentsScreenState createState() => PatientAppointmentsScreenState();
}

class PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  PatientAppointmentsBloc patientAppointmentsBloc = PatientAppointmentsBloc(patientAppointmentsUseCase:getIt());
  final List<String> tabs = ['all_appointments'.tr(), 'next_appointments'.tr(), 'past_appointments'.tr(),];
  int _selectedIndex = 0;
  late List<Widget?> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabViews = List.filled(tabs.length, null);
    _tabViews[0] = _buildTabWidget(0); // Load the first tab initially
  }

  Widget _buildTabWidget(int index) {
    switch (index) {
      case 0:
        return buildScreen(patientAppointmentsBloc.allList);
      case 1:
        return buildScreen(patientAppointmentsBloc.nextList);
      case 2:
        return buildScreen(patientAppointmentsBloc.pastList);
      default:
        return Center(child: Text("Not Implemented"));
    }
  }

  Widget buildScreen(List<AppointmentData> list){
    return list.isEmpty?
    Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hourglass_empty),
          PText(title: 'no_appointments_found'.tr(), size: PSize.text18),
        ],
      ),
    ):
    ListView.builder(itemBuilder: (context, index) {
      AppointmentData item = list[index];
      return PatientAppointmentsCardWidget(model: item, onAccept:() {

      },onCancel:() {
        cancelAppointmentBottomSheet(() {
          patientAppointmentsBloc.add(ApplyPatientCancelEvent(model:AcceptAppointmentRequestModel(status:5),
              id:item.id??0));
        },);
      },);
    },shrinkWrap:true,itemCount:list.length,);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: _selectedIndex,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: BlocProvider(
          create: (context) => patientAppointmentsBloc,
          child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.only(top: 24, right: 30),
                child: appBar(
                  context: context,
                  backBtn: false, isCenter: true,
                  text: 'my_appointments'.tr(),
                ),
              ),
            ),
            backgroundColor: AppColors.whiteBackground,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:10),
                TabBar(
                  padding:EdgeInsets.zero,
                  labelPadding:EdgeInsets.symmetric(horizontal:0),
                  isScrollable: false,
                  indicatorPadding:EdgeInsets.only(left:10,right:10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  indicatorColor: AppColors.primaryColor,
                  // indicatorWeight: 2.5,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.grey200,
                  labelStyle: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo',
                  ),
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                ),
                const SizedBox(height: 14),
                BlocListener<PatientAppointmentsBloc,BaseState>(listener:(context, state) {
                  if(state is ButtonLoadingState){
                    loadDialog();
                  }else if(state is FormLoadedState){
                    hideLoadingDialog();
                    SafeToast.show(message: state.data?.message ?? 'Success',
                        duration: const Duration(seconds: 1));
                    patientAppointmentsBloc.add(ApplyPatientAppointmentsEvent());
                  }else if(state is ErrorState){
                    hideLoadingDialog();
                  }
                },child:PBlocBuilder<PatientAppointmentsBloc, BaseState>(
                  bloc: patientAppointmentsBloc,
                  init: () {
                    patientAppointmentsBloc.add(ApplyPatientAppointmentsEvent());
                  },
                  loadingWidget: const Expanded(child: Center(child: CustomLoader(size: 35))),
                  loadedWidget: (state) {
                    final item = (state as LoadedState).data.model as PatientAppointmentsResponseModel;
                    patientAppointmentsBloc.allList = item.model?.all ?? [];
                    patientAppointmentsBloc.nextList = item.model?.upcoming ?? [];
                    patientAppointmentsBloc.pastList = item.model?.past ?? [];

                    return Expanded(
                      child: TabBarView(
                        children: [
                          buildScreen(patientAppointmentsBloc.allList),
                          buildScreen(patientAppointmentsBloc.nextList),
                          buildScreen(patientAppointmentsBloc.pastList),
                        ],
                      ),
                    );
                  },
                ),)
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
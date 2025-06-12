import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_bloc.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_event.dart';
import 'package:mawidak/features/appointments/presentation/ui/widgets/doctor_pending_appointments_card.dart';

class DoctorPendingAppointmentsScreen extends StatelessWidget {
  // final List<DoctorAppointmentsData> pendingList;
  final DoctorAppointmentsBloc doctorAppointmentsBloc;
  const DoctorPendingAppointmentsScreen({super.key,required this.doctorAppointmentsBloc});

  @override
  Widget build(BuildContext context) {
    DoctorAppointmentsBloc doctorAppointmentsBloc = DoctorAppointmentsBloc(doctorAppointmentsUseCase:getIt());
    return MediaQuery.removePadding(context:context,removeTop:true,
      child: BlocProvider(create:(context) => doctorAppointmentsBloc,
        child: Scaffold(
          backgroundColor: AppColors.whiteBackground,
          appBar: PreferredSize(preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:24),
              child: appBar(context: context,backBtn: true,isCenter:true,text: 'pending_requests'.tr()),
            ),
          ),
          body:BlocListener<DoctorAppointmentsBloc,BaseState>(listener:(context, state) {
            if(state is ButtonLoadingState){
              loadDialog();
            }else if(state is FormLoadedState){
              hideLoadingDialog();
              // Navigator.pop(navigatorKey.currentState!.context);
              SafeToast.show(message: state.data?.message ?? 'Success',
                  duration: const Duration(seconds: 1));
              doctorAppointmentsBloc.add(ApplyDoctorPendingAppointmentsEvent());
            }else if(state is ErrorState){
              hideLoadingDialog();
              // Navigator.pop(navigatorKey.currentState!.context);
            }
          },child:ListView.builder(
            padding:EdgeInsets.only(left:20,right:20,top:10),
            itemBuilder:(context, index) {
              DoctorAppointmentsData item = doctorAppointmentsBloc.pendingList[index];
              return DoctorPendingAppointmentsCard(model:item,
                onCancel:(model) {
                  doctorAppointmentsBloc.add(ApplyDoctorCancelEvent(id: item.id??0,
                      model: model ?? CancelAppointmentRequestModel(cancellationReason:4,
                          otherReason:'empty', cancelledBy:'doctor')));
                },onAccept: () {
                  doctorAppointmentsBloc.add(ApplyDoctorAcceptEvent(id: item.id??0,
                      model:AcceptAppointmentRequestModel(status: 2)));
                },);
            },shrinkWrap:true,itemCount:doctorAppointmentsBloc.pendingList.length,),)),
      ),
    );
  }
}

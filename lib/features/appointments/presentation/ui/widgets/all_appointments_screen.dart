import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_loader/custom_loader.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/p_bloc_builder.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_bloc.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_event.dart';
import 'package:mawidak/features/appointments/presentation/ui/widgets/appointment_card.dart';

class AllAppointmentsScreen extends StatelessWidget {
  final DoctorAppointmentsBloc doctorAppointmentsBloc;
  const AllAppointmentsScreen({super.key,required this.doctorAppointmentsBloc});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => doctorAppointmentsBloc,
      child:BlocListener<DoctorAppointmentsBloc,BaseState>(listener:(context, state) {
        if(state is ButtonLoadingState){
          loadDialog();
        }else if(state is FormLoadedState){
          hideLoadingDialog();
          Navigator.pop(navigatorKey.currentState!.context);
          SafeToast.show(message: state.data?.message ?? 'Success',
              duration: const Duration(seconds: 1));
          doctorAppointmentsBloc.add(ApplyDoctorAppointmentsEvent());
        }else if(state is ErrorState){
          hideLoadingDialog();
          Navigator.pop(navigatorKey.currentState!.context);
        }
      },child:PBlocBuilder(bloc:doctorAppointmentsBloc,
        init:() {
          doctorAppointmentsBloc.add(ApplyDoctorAppointmentsEvent());
        },
        loadingWidget: Expanded(child: Center(child: CustomLoader(size: 35))),
        loadedWidget:(state) {
          List<DoctorAppointmentsData> itemList
          = ((state as LoadedState).data).model?.model?? [];
          return ListView.builder(
            padding:EdgeInsets.only(top:14),
            itemBuilder:(context, index) {
              DoctorAppointmentsData item = itemList[index];
              return AppointmentCard(model:item,onCancel:(model) {
                doctorAppointmentsBloc.add(ApplyDoctorCancelEvent(id: item.id??0,
                    model: model ?? CancelAppointmentRequestModel(cancellationReason:4,
                        otherReason:'empty', cancelledBy:'doctor')));
              },onViewDetails: () {

              },);
            },itemCount:itemList.length,shrinkWrap:true,);
        },emptyWidget: (state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.hourglass_empty),
                PText(title: 'no_appointments_found'.tr(), size: PSize.text18),
              ],
            ),
          );
        },),),
    ); // All Appointments
  }
}
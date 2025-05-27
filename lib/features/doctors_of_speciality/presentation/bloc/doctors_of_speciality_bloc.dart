import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/contact_us/data/model/contact_us_request_model.dart';
import 'package:mawidak/features/doctors_of_speciality/domain/use_case/doctors_of_speciality_use_case.dart';
import 'package:mawidak/features/doctors_of_speciality/presentation/bloc/doctors_of_speciality_event.dart';


class DoctorsOfSpecialityBloc extends Bloc<DoctorsOfSpecialityEvent, BaseState> {
  final DoctorsOfSpecialityUseCase contactUsUseCase;

  ContactUsRequestModel model = ContactUsRequestModel();
  DoctorsOfSpecialityBloc({required this.contactUsUseCase}) : super(InitialState()) {
    on<ApplyDoctorsOfSpecialityEvent>(onApplyContactUsEvent);
  }

  Future<void> onApplyContactUsEvent(ApplyDoctorsOfSpecialityEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await contactUsUseCase.getDoctors(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
            final list = (r).model?.model?? [];
            if(list.isEmpty){
              emit(EmptyState(r.message,));
              return;
            }
        emit(LoadedState(r,isMap:false));
      },
    );
  }

}

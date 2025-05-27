import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/notification/domain/use_case/notification_use_case.dart';
import 'package:mawidak/features/notification/presentation/bloc/notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, BaseState> {
  final NotificationUseCase notificationUseCase;

  NotificationBloc({required this.notificationUseCase}) : super(InitialState()) {
    on<ApplyGetNotificationEvent>(onApplyGetNotificationEvent);
    on<ApplyNotificationById>(onApplyNotificationById);
  }

  Future<void> onApplyGetNotificationEvent(ApplyGetNotificationEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await notificationUseCase.getNotification();
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        emit(LoadedState(r,isMap:false));
      },
    );
  }

  Future<void> onApplyNotificationById(ApplyNotificationById event, Emitter emit) async {
    // emit(LoadingState());
    final response = await notificationUseCase.getNotificationById(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      add(ApplyGetNotificationEvent());
        // emit(LoadedState(r,isMap:false));
      },
    );
  }

}

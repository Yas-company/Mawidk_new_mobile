import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/base_network/client/dio_client.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/features/more/data/model/update_photo_response_model.dart';
import 'package:mawidak/features/more/domain/logout_use_case.dart';
import 'package:mawidak/features/more/presentation/bloc/logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, BaseState> {
  final LogoutUseCase logoutUseCase;
String imageUrl = '';
  LogoutBloc({required this.logoutUseCase}) : super(InitialState()) {
    on<MakeLogoutEvent>(onMakeLogoutEvent);
    on<MakeDeleteAccount>(onMakeDeleteAccount);
    on<UpdatePhotoEvent>(onUpdatePhotoEvent);
  }


  Future<void> onMakeLogoutEvent(MakeLogoutEvent event, Emitter emit) async {
    emit(LoadingState());
    loadDialog();
    final response = await logoutUseCase.makeLogout();
    await response.fold((l) async {
      hideLoadingDialog();
      emit(ErrorState(l));
      }, (r) async {
      hideLoadingDialog();
      DioClient().deleteToken();
        emit(LoadedState(r));
      },
    );
  }

  Future<void> onMakeDeleteAccount(MakeDeleteAccount event, Emitter emit) async {
    emit(LoadingState());
    loadDialog();
    final response = await logoutUseCase.deleteAccount();
    await response.fold((l) async {
      hideLoadingDialog();
      emit(ErrorState(l));
    }, (r) async {
      SharedPreferenceService().setString(SharPrefConstants.userType,'');
      await SharedPreferenceService().setBool(SharPrefConstants.surveyStatus,true);
      hideLoadingDialog();
      DioClient().deleteToken();
      emit(LoadedState(r));
    },
    );
  }

  Future<void> onUpdatePhotoEvent(UpdatePhotoEvent event, Emitter emit) async {
    emit(LoadingState());
    loadDialog();
    final response = await logoutUseCase.updatePhoto(file: event.file);
    await response.fold((l) async {
      hideLoadingDialog();
      emit(ErrorState(l));
    }, (r) async {
      UpdatePhotoData item = (r).model?.model ?? UpdatePhotoData();
      imageUrl = item.photo??'';
      SharedPreferenceService().setString(SharPrefConstants.image,imageUrl);
      hideLoadingDialog();
      emit(LoadedState(r));
    },);
  }

}

import 'package:mawidak/features/login/data/model/login_request_model.dart';
import 'package:mawidak/features/survey/presentation/bloc/survey_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class NormalLoginEvent extends LoginEvent {
  final LoginRequestModel loginRequestModel;
  // final SurveyBloc surveyBloc;
  // const NormalLoginEvent({required this.loginRequestModel,required this.surveyBloc}) : super();
  const NormalLoginEvent({required this.loginRequestModel,}) : super();
}
//
// class BiomatricLoginEvent extends LoginEvent {
//   const BiomatricLoginEvent() : super();
// }
//
class LoginValidationEvent extends LoginEvent {
  const LoginValidationEvent() : super();
}
//
// class EnableBiometricEvent extends LoginEvent {
//   const EnableBiometricEvent() : super();
// }

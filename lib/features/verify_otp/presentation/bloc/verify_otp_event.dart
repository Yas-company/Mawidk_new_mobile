import 'package:mawidak/features/login/data/model/login_request_model.dart';
import 'package:mawidak/features/verify_otp/data/model/verify_otp_request_model.dart';

abstract class VerifyOtpEvent {
  const VerifyOtpEvent();
}

class ApplyVerifyOtpEvent extends VerifyOtpEvent {
  // final SurveyBloc surveyBloc;
  final VerifyOtpRequestModel verifyOtpRequestModel;
  final bool isLogin;
  const ApplyVerifyOtpEvent({
    // required this.surveyBloc,
    required this.verifyOtpRequestModel,
  required this.isLogin}) : super();
}

class ValidationEvent extends VerifyOtpEvent {
  final String code;
  const ValidationEvent({required this.code}) : super();
}



class ReSendOtpEvent extends VerifyOtpEvent {
  final LoginRequestModel loginRequestModel;
  const ReSendOtpEvent({required this.loginRequestModel,}) : super();
}
import 'package:mawidak/features/register/data/model/register_request_model.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class AddRegisterEvent extends RegisterEvent {
  final RegisterRequestModel registerRequestModel;
  const AddRegisterEvent({required this.registerRequestModel}) : super();
}

// class BiomatricLoginEvent extends RegisterEvent {
//   const BiomatricLoginEvent() : super();
// }

class ValidationEvent extends RegisterEvent {
  const ValidationEvent() : super();
}

// class EnableBiometricEvent extends RegisterEvent {
//   const EnableBiometricEvent() : super();
// }

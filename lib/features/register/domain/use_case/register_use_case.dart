import 'package:dartz/dartz.dart';
import '../../data/model/register_request_model.dart';
import '../repository/register_repo.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  Future<Either> register(RegisterRequestModel params) async {
    return await registerRepository.register(model: params);
  }
}

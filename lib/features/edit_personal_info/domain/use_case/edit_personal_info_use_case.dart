import 'package:dartz/dartz.dart';
import 'package:mawidak/features/edit_personal_info/data/model/edit_personal_info_request_model.dart';
import 'package:mawidak/features/edit_personal_info/domain/repository/edit_personal_info_repository.dart';

class EditPersonalInfoUseCase {
  final EditPersonalInfoRepository editPersonalInfoRepository;

  EditPersonalInfoUseCase({required this.editPersonalInfoRepository});

  Future<Either> editProfile({required EditPersonalInfoRequestModel model}) async {
    return await editPersonalInfoRepository.editProfile(model: model);
  }

  Future<Either> getProfile() async {
    return await editPersonalInfoRepository.getProfile();
  }

}
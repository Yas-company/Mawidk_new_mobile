import 'package:dartz/dartz.dart';
import 'package:mawidak/features/edit_personal_info/data/model/edit_personal_info_request_model.dart';

abstract class EditPersonalInfoRepository {
  Future<Either<dynamic, dynamic>> editProfile({required EditPersonalInfoRequestModel model,});
}
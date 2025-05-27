import 'package:dartz/dartz.dart';
import 'package:mawidak/features/contact_us/data/model/contact_us_request_model.dart';
import 'package:mawidak/features/contact_us/domain/repository/contact_us_repository.dart';

class ContactUsUseCase {
  final ContactUsRepository contactUsRepository;

  ContactUsUseCase({required this.contactUsRepository});

  Future<Either> contactUs({required ContactUsRequestModel model}) async {
    return await contactUsRepository.contactUs(model: model);
  }
}

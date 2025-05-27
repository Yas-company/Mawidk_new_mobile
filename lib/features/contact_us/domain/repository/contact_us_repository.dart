import 'package:dartz/dartz.dart';
import 'package:mawidak/features/contact_us/data/model/contact_us_request_model.dart';

abstract class ContactUsRepository {
  Future<Either<dynamic, dynamic>> contactUs({required ContactUsRequestModel model});
}

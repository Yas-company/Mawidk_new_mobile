import 'package:mawidak/features/doctor_profile/data/model/favourite_request_model.dart';

abstract class DoctorProfileEvent {
  const DoctorProfileEvent();
}

class ApplyDoctorProfileEvent extends DoctorProfileEvent {
  final int id;
  const ApplyDoctorProfileEvent({required this.id}) : super();
}

class AddToFavouriteEvent extends DoctorProfileEvent {
  final FavouriteRequestModel model;
  const AddToFavouriteEvent({required this.model}) : super();
}
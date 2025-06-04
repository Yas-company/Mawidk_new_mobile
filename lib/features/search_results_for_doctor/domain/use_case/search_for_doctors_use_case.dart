import 'package:dartz/dartz.dart';
import 'package:mawidak/features/search_results_for_doctor/domain/repository/search_for_doctors_repository.dart';


class SearchForDoctorsUseCase {
  final SearchForDoctorsRepository searchRepository;

  SearchForDoctorsUseCase({required this.searchRepository});

  Future<Either> searchForDoctor({required String key}) async {
    return await searchRepository.searchForDoctor(key: key);
  }
}

import 'package:dartz/dartz.dart';
import 'package:mawidak/features/search/data/model/filter_request_model.dart';
import 'package:mawidak/features/search/data/model/search_map_request_model.dart';
import 'package:mawidak/features/search/domain/repository/search_respository.dart';


class SearchUseCase {
  final SearchRepository searchRepository;

  SearchUseCase({required this.searchRepository});

  Future<Either> searchForPatient({required String key}) async {
    return await searchRepository.searchForPatient(key: key);
  }
  Future<Either> searchMap({required SearchMapRequestModel model}) async {
    return await searchRepository.searchMap(model: model);
  }

  Future<Either> filter({required FilterRequestModel model}) async {
    return await searchRepository.filter(model: model);
  }
}

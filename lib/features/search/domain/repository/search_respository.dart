import 'package:dartz/dartz.dart';
import 'package:mawidak/features/search/data/model/filter_request_model.dart';
import 'package:mawidak/features/search/data/model/search_map_request_model.dart';

abstract class SearchRepository {
  Future<Either<dynamic, dynamic>> searchForPatient({required String key});
  Future<Either<dynamic, dynamic>> searchMap({required SearchMapRequestModel model});
  Future<Either<dynamic, dynamic>> filter({required FilterRequestModel model});
}

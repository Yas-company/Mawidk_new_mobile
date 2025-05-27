import 'package:dartz/dartz.dart';
import 'package:mawidak/features/lookups/lookup_repository.dart';

class LookupUseCase {
  final LookupRepository lookupRepository;

  LookupUseCase({required this.lookupRepository});

  Future<Either> fetchCities() async {
    return await lookupRepository.fetchCities();
  }
}

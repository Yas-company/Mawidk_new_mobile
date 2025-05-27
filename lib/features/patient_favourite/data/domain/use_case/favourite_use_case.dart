import 'package:dartz/dartz.dart';
import 'package:mawidak/features/patient_favourite/data/domain/repository/favourite_repository.dart';

class FavouriteUseCase {
  final FavouriteRepository favouriteRepository;

  FavouriteUseCase({required this.favouriteRepository});

  Future<Either> getFavouriteDoctors() async {
    return await favouriteRepository.getFavouriteDoctors();
  }
}

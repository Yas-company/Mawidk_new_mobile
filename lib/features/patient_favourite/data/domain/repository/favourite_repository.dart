import 'dart:io';
import 'package:dartz/dartz.dart';

abstract class FavouriteRepository {
  Future<Either<dynamic, dynamic>> getFavouriteDoctors();
}

import 'package:dartz/dartz.dart';
import 'package:mawidak/features/show_file/domain/repository/show_file_repository.dart';


class ShowFileUseCase {
  final ShowFileRepository showFileRepository;

  ShowFileUseCase({required this.showFileRepository});

  Future<Either> getBasicInfo({required int id}) async {
    return await showFileRepository.getBasicInfo(id: id);
  }
}

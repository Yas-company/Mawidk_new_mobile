import 'dart:io';
import 'package:mawidak/core/services/file_service_picker/file_service_picker.dart';

abstract class UploadEvent {}

class PickFiles extends UploadEvent {
  final PickerType pickerType;
  final int numberOfImages;
  PickFiles({required this.pickerType, required this.numberOfImages});
}

class RemoveFile extends UploadEvent {
  final File file;
  RemoveFile(this.file);
}

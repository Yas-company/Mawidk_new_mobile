import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:path/path.dart' as p;
import 'package:mawidak/core/services/file_service_picker/file_service_picker.dart';
import 'upload_event.dart';
import 'upload_state.dart';

int imageMaxSizeInBytes = 5 * 1024 * 1024; // 2 MB
int fileMaxSizeInBytes = 2 * 1024 * 1024; // 2 MB
// int fileMaxSizeInBytes = 10 * 1024 * 1024; // 10 MB

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final FilePickerService _filePickerService = FilePickerService();
  List<File> selectedFiles = [];

  UploadBloc() : super(UploadInitial()) {
    on<PickFiles>(_handlePickFiles);
    on<RemoveFile>(_handleRemoveFile);
  }
  Future<void> _handlePickFiles(PickFiles event, Emitter<UploadState> emit) async {
    try {
      List<File> newFiles = await _filePickerService.pickFile(event.pickerType);

      if (newFiles.isEmpty) {
        emit(UploadFailure("لم يتم تحديد أي ملفات صالحة أو حجم الملف يتجاوز الحد الأقصى"));
        return;
      }

      if (newFiles.length > 3) {
        // Show toast if more than 3 selected
        SafeToast.show(message: "الحد الاقصي للمفات هو ثلاثة فقط",type:MessageType.warning);
        newFiles = newFiles.sublist(0, 3); // Keep only first 3 files
      }

      // Validate the first image (you can also validate all if needed)
      File firstImage = newFiles.first;
      if (!(await validateImage(file: firstImage))) {
        emit(UploadFailure("حجم الملف كبير"));
        return;
      }

      emit(Uploading());
      await Future.delayed(const Duration(milliseconds: 300));

      if (event.numberOfImages == 1) {
        selectedFiles.clear();
        selectedFiles.addAll(newFiles);
      } else {
        selectedFiles.addAll(newFiles);
        // Optionally limit total selectedFiles to 3 as well:
        if (selectedFiles.length > 3) {
          selectedFiles = selectedFiles.sublist(0, 3);
        }
      }

      emit(FilesPicked(List.from(selectedFiles)));
    } catch (e) {
      emit(UploadFailure("File picking failed: ${e.toString()}"));
    }
  }

  // Future<void> _handlePickFiles(PickFiles event, Emitter<UploadState> emit) async {
  //   try {
  //     List<File> newFiles = await _filePickerService.pickFile(event.pickerType);
  //     if (newFiles.isEmpty) {
  //       emit(UploadFailure("No valid files selected or file size exceeds limit"));
  //       return;
  //     }
  //     File image = newFiles.first;
  //     if (!(await validateImage(file: image))) {
  //       emit(UploadFailure("size of file is bigger"));
  //       return;
  //     }
  //
  //     emit(Uploading());
  //
  //     await Future.delayed(
  //       const Duration(milliseconds: 300),
  //     ); // Optional delay for smooth UX
  //     if (event.numberOfImages == 1) {
  //       selectedFiles.clear();
  //       selectedFiles.addAll(newFiles);
  //     } else {
  //       selectedFiles.addAll(newFiles);
  //     }
  //
  //     emit(FilesPicked(List.from(selectedFiles)));
  //   } catch (e) {
  //     emit(UploadFailure("File picking failed: ${e.toString()}"));
  //   }
  // }

  Future<void> _handleRemoveFile(
      RemoveFile event, Emitter<UploadState> emit) async {
    selectedFiles.removeWhere((file) => file.path == event.file.path);
    emit(FilesPicked(List.from(selectedFiles))); // Emit updated state
  }
}

Future<bool> validateImage({required File file, bool isImage = true}) async {
  int fixedSize = isImage ? imageMaxSizeInBytes : fileMaxSizeInBytes;
  int fileSize = await file.length();
  // String size = getFileSizeString(bytes: fileSize);
  // uploadedSize = size;
  // // print('size>>' + size.toString());
  if (fileSize > fixedSize) {
    SafeToast.show(
      duration: const Duration(seconds: 3),
      message: isImage
          ? 'حجم المرفق يتجاوز الحد الأقصى وهو 5 ميجا بايت.'
          : 'حجم المرفق يتجاوز الحد الأقصى وهو 2 ميجا بايت.',
      type: MessageType.error,
    );
  }
  return fixedSize >= fileSize;
}



// Future<String> getFileSize({required File file, bool isImage = true}) async {
//   int fileSize =  file.lengthSync();
//   String size = getFileSizeString(bytes: fileSize);
//   return size;
// }

String getReadableFileSize(File file) {
  final int bytes = file.lengthSync();
  const suffixes = ['B', 'Kb', 'Mb', 'Gb', 'Tb'];

  if (bytes == 0) return '0 B';

  final int i = (bytes != 0) ? (log(bytes) / log(1024)).floor() : 0;
  final double size = bytes / pow(1024, i);

  return '${size.toStringAsFixed(2)} ${suffixes[i]}';
}

String getFileExtension(File file) {
  return p.extension(file.path).replaceAll('.', '').toLowerCase();
}
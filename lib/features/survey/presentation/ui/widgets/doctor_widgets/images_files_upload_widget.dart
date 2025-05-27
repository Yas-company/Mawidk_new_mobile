import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/bloc/upload_bloc.dart';
import 'package:mawidak/core/bloc/upload_event.dart';
import 'package:mawidak/core/bloc/upload_state.dart';
import 'package:mawidak/core/component/dashed_border/dashed_border_container.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/image/show_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/services/file_service_picker/file_service_picker.dart';

class ImagesFilesUploadWidget extends StatelessWidget {
  final List<File> files;
  final int numberOfImages;
  final bool allowImages;
  final bool allowFiles;
  final Function(List<File> selectedFiles)? onChange;

  const ImagesFilesUploadWidget({
    super.key,
    required this.files ,
    this.numberOfImages = 2,
    this.allowImages = true,
    this.allowFiles = true,
    this.onChange,
  });

  bool isImageFile(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    UploadBloc uploadBloc = UploadBloc();
    uploadBloc.selectedFiles = files;
    // List<File> selectedFiles = [];
    List<File> selectedFiles = files;
    return Scaffold(backgroundColor:AppColors.whiteBackground,
      body: BlocProvider(create: (context) => uploadBloc,
        child: BlocConsumer<UploadBloc, UploadState>(
          listener: (context, state) {
            if (state is FilesPicked || state is FileRemoved) {
              selectedFiles = (state as dynamic).pickedFiles ?? [];
              onChange?.call(selectedFiles);
            }
          },
          builder: (context, state) {
            if (state is FilesPicked) {
              selectedFiles = state.pickedFiles;
            }
            onChange?.call(selectedFiles);

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 400, color:Color(0xffF1F8FF),
                    padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20,),
                    margin:EdgeInsets.only(bottom:20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PText(title:'الشهادات', size: PSize.text20,),
                        PText(title:'هل لديك شهادات طبية او دورات ؟ يمكنك رفعها هنا', size: PSize.text14,
                          fontColor: AppColors.grey200, fontWeight: FontWeight.w400,),
                        const SizedBox(height:0),
                      ],
                    ),
                  ),
                  PText(title: 'حمل ملفاتك', size: PSize.text20),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    child: PText(
                      title: 'بصيغة JPG, PNG, PDF ',
                      size: PSize.text14,
                      fontColor: AppColors.grey200,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _showPickerDialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: DashedBorderContainer(
                        dashedBorderColor: AppColors.shade4,
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.only(
                              top: 50, bottom: 40, left: 20, right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.primaryColor10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PImage(
                                source: AppSvgIcons.elementFile,
                                height: 32,
                                width: 32,
                              ),
                              const SizedBox(height: 12),
                              PText(
                                title: 'اختر ملف',
                                decoration: TextDecoration.underline,
                                size: PSize.text16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height:16),
                  BlocBuilder<UploadBloc, UploadState>(
                    builder: (context, state) {
                      // if (state is Uploading) {
                      //   return customLoader();
                      // } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20),
                        child: Wrap(
                          spacing: 10, runSpacing: 16,
                          children: selectedFiles.map((file) {
                            final isImage = isImageFile(file);
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: Container(
                                key: ValueKey(file.path), // Unique key triggers animation
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor10,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppColors.primaryColor),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isImage
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Hero(
                                        tag: file.toString(),
                                        child: GestureDetector(
                                          onTap: () {
                                            showImage(image: '', isFile: true, file: file);
                                          },
                                          child: Image.file(
                                            file,
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                        : Icon(Icons.file_copy_outlined, color: AppColors.primaryColor),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PText(
                                            maxLines: 1,
                                            title: file.path.split('/').last,
                                          ),
                                          PText(
                                            title: getReadableFileSize(file),
                                            fontColor: AppColors.grey200,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<UploadBloc>(context).add(RemoveFile(file));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteBackground,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                      // return AnimatedSwitcher(
                      //     duration: const Duration(milliseconds: 300),
                      //     transitionBuilder: (Widget child, Animation<double> animation) {
                      //       return ScaleTransition(
                      //         scale: animation,
                      //         child: FadeTransition(
                      //           opacity: animation,
                      //           child: child,
                      //         ),
                      //       );
                      //     },
                      //     child: Wrap(
                      //       key: ValueKey(selectedFiles.length), // triggers animation
                      //       spacing: 10,
                      //       runSpacing: 10,
                      //       children: selectedFiles.map((file) {
                      //         final isImage = isImageFile(file);
                      //         return Container(
                      //           key: ValueKey(file.path), // unique key for animation
                      //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                      //           decoration: BoxDecoration(
                      //             color: AppColors.primaryColor10,
                      //             borderRadius: BorderRadius.circular(14),
                      //             border: Border.all(color: AppColors.primaryColor),
                      //           ),
                      //           child: Row(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               isImage
                      //                   ? ClipRRect(
                      //                 borderRadius: BorderRadius.circular(4),
                      //                 child: Hero(
                      //                   tag: file.toString(),
                      //                   child: GestureDetector(
                      //                     onTap: () {
                      //                       showImage(image: '', isFile: true, file: file);
                      //                     },
                      //                     child: Image.file(
                      //                       file,
                      //                       width: 30,
                      //                       height: 30,
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //                   : Icon(Icons.file_copy_outlined, color: AppColors.primaryColor),
                      //               const SizedBox(width: 12),
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     PText(
                      //                       maxLines: 1,
                      //                       title: file.path.split('/').last,
                      //                     ),
                      //                     PText(
                      //                       title: getReadableFileSize(file),
                      //                       fontColor: AppColors.grey200,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               const SizedBox(width: 12),
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   BlocProvider.of<UploadBloc>(context).add(RemoveFile(file));
                      //                 },
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(4),
                      //                   decoration: BoxDecoration(
                      //                     color: AppColors.whiteBackground,
                      //                     borderRadius: BorderRadius.circular(4),
                      //                   ),
                      //                   child: const Icon(
                      //                     Icons.close,
                      //                     color: Colors.black,
                      //                     size: 16,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showPickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<UploadBloc>(context),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                top: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
            child: Wrap(
              children: [
                if (allowImages)
                  ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14),
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.photo_camera_back),
                    title: PText(title: 'اضافة صورة من ملف الصور'.tr()),
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context).add(
                        PickFiles(
                          pickerType: numberOfImages == 1
                              ? PickerType.singleImageGallery
                              : PickerType.multipleImages,
                          numberOfImages: numberOfImages,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                if (allowImages) const Divider(),
                if (allowImages)
                  ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14),
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: PText(title: 'افتح الكاميرا'.tr()),
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context).add(
                        PickFiles(
                          pickerType: PickerType.singleImageCamera,
                          numberOfImages: numberOfImages,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                if (allowFiles) const Divider(),
                if (allowFiles)
                  ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14),
                    horizontalTitleGap: 4,
                    leading: const Icon(Icons.insert_drive_file),
                    title: PText(title: 'اختر ملف PDF'.tr()),
                    onTap: () {
                      BlocProvider.of<UploadBloc>(context).add(
                        PickFiles(
                          pickerType: PickerType.file,
                          numberOfImages: numberOfImages,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../data/constants/global_obj.dart';
// import '../../global/enums/global_enum.dart';
// import '../download/download.dart';
//
// class ShareServices {
//   static Future<void> share({
//     required String title,
//     String body = '',
//     String? itemImageUrl,
//     ShareTypes shareType = ShareTypes.textOnly,
//     BuildContext? context,
//   }) async {
//     final RenderBox box = (context ?? navigatorKey.currentState!.context)
//         .findRenderObject() as RenderBox;
//
//     String fullShareUrl = "$title\n$body";
//
//     if (shareType == ShareTypes.textOnly) {
//       await Share.share(
//         fullShareUrl,
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
//       );
//     } else {
//       final File imageFile = await DownloadServices.download(
//         url: itemImageUrl!,
//         saveType: SaveTypes.saveTemporary,
//       );
//       await Share.shareXFiles(
//         [
//           XFile(imageFile.path),
//         ],
//         text: fullShareUrl,
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
//       );
//     }
//   }
// }

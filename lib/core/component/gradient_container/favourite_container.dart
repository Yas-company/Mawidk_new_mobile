// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mawidak/core/component/image/p_image.dart';
// import 'package:mawidak/core/component/text/p_text.dart';
// import 'package:mawidak/core/data/app_dimensions/app_dimensions.dart';
// import 'package:mawidak/core/data/constants/app_colors.dart';
// import 'package:mawidak/core/global/enums/global_enum.dart';
// import 'package:mawidak/core/global/global_func.dart';
// import 'package:mawidak/core/services/url_launcher/url_launcher_manager.dart';
//
// class CircleGradientContainer extends StatelessWidget {
//   final String icon;
//   final String title;
//   final String? description;
//   final String? url;
//   final bool isVertical;
//   final bool? showDivider;
//   final int? length;
//   final String redirect;
//   const CircleGradientContainer({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.showDivider = false,
//     required this.redirect,
//     required this.isVertical,
//     this.description,
//     this.length,
//     this.url = '',
//   });
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if ((url ?? '').isNotEmpty) {
//           UrlLauncherManager.redirectUrl('http://selfservices.ipa.edu.sa/');
//         } else {
//           if (redirect.isNotEmpty) {
//             if (title.contains('news'.tr()) || title.contains('events'.tr())) {
//               context.push(redirect,
//                   extra: title.contains('news'.tr()) ? true : false);
//             } else {
//               context.push(redirect);
//             }
//           }
//         }
//       },
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(bottom: 4, right: 4),
//                 width: 50,
//                 height: 55,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [AppColors.secondaryColor, AppColors.primaryColor],
//                   ),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: 45,
//                     height: 52,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: isDarkContext(context)
//                           ? AppColors.darkBackgroundColor
//                           : AppColors.whiteColor, // Inner circle color
//                     ),
//                     child: Center(
//                       child: PImage(
//                         source: icon,
//                         color: isDarkContext(context)
//                             ? AppColors.whiteColor
//                             : AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (isVertical)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       PText(
//                         title: description ?? '',
//                         size: PSize.text16,
//                         fontWeight: FontWeight.w600,
//                         fontColor: isDark
//                             ? AppColors.whiteColor
//                             : AppColors.contentColor,
//                       ),
//                       SizedBox(
//                         height: AppDimensions.margin8,
//                       ),
//                       PText(
//                         title: title,
//                         size: PSize.text16,
//                         fontWeight: FontWeight.w600,
//                         fontColor: isDark
//                             ? AppColors.whiteColor
//                             : AppColors.titleColor,
//                       )
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//           if (showDivider ?? false)
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 4),
//               child: Divider(),
//             ),
//           if (!isVertical)
//             Container(
//               width: length != null && length! > 3 ? 70 : null,
//               alignment: Alignment.center,
//               child: PText(
//                 maxLines: 2,
//                 title: title,
//                 size: PSize.text16,
//                 alignText: TextAlign.center,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }

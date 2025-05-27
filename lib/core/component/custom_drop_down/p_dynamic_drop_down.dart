// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:mawidak/core/component/text/p_text.dart';
// import 'package:mawidak/core/data/constants/app_colors.dart';
// import 'package:mawidak/core/global/enums/global_enum.dart';
// import 'package:mawidak/core/global/global_func.dart';
//
// class PDynamicDropDown extends StatelessWidget {
//   final List<dynamic> items;
//   final String keyTitle;
//   // final ReportProblemBloc reportProblemBloc;
//   final Function(Map<String, dynamic>?)? onChanged;
//   final Map<String, dynamic>? value;
//   const PDynamicDropDown({
//     super.key,
//     required this.items,
//     required this.keyTitle,
//     // required this.reportProblemBloc,
//     this.onChanged,
//     this.value,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         DropdownButtonHideUnderline(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? AppColors.darkFieldBackgroundColor
//                   : AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: DropdownButton<Map<String, dynamic>>(
//               hint: Text('select'.tr(),),
//               value: value,
//               isExpanded: true,
//               dropdownColor: isDark
//                   ? AppColors.darkFieldBackgroundColor
//                   : AppColors.whiteColor,
//               onChanged: (newValue) {
//                 onChanged!(newValue);
//               },
//               selectedItemBuilder: (BuildContext context) {
//                 return items.map<Widget>((item) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom:3),
//                     child: PText(
//                       title: item[keyTitle],
//                       overflow: TextOverflow.visible,
//                       size:PSize.text14,
//                     ),
//                   );
//                 }).toList();
//               },
//               items: items.map<DropdownMenuItem<Map<String, dynamic>>>((item) {
//                 return DropdownMenuItem(
//                     value: item,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: PText(
//                             title: item[keyTitle],size:PSize.text14,
//                             fontColor:value == item
//                                 ? isDark?AppColors.whiteColor:AppColors.black
//                                 : AppColors.contentColor,
//                           ),
//                         ),
//                         const SizedBox(width: 8,),
//                         if (value == item) const Icon(Icons.check),
//                       ],
//                     ));
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

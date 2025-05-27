// import 'package:flutter/material.dart';
// import 'package:mawidak/core/component/text/p_text.dart';
// import 'dart:convert';
// import 'package:mawidak/core/component/text_field/p_textfield.dart';
// import 'package:mawidak/core/data/constants/app_colors.dart';
// import 'package:mawidak/core/global/enums/global_enum.dart';
//
// class SelectedDropDown<T> extends StatefulWidget {
//   final String? title;
//   final String titleKey;
//   final String? hint;
//   final List<T> items;
//   final T? selectedItem;
//   final TextStyle? style;
//   final TextStyle? hintStyle;
//   final Widget? icon;
//   final VoidCallback? onTap;
//   final bool? readOnly;
//   final Color? dropdownColor;
//   final Color? fontColor;
//   final ValueChanged onChange;
//   final String? Function(String?)? validator;
//   const SelectedDropDown({
//     super.key,
//     this.title,
//     required this.titleKey,
//     required this.onChange,
//     this.hint,
//     required this.items,
//     this.selectedItem,
//     this.style,
//     this.icon,
//     this.onTap,
//     this.readOnly = false,
//     this.dropdownColor,
//     this.fontColor,
//     this.hintStyle,
//     this.validator,
//   });
//
//   @override
//   State<SelectedDropDown> createState() => SelectedDropDownState();
// }
//
// class SelectedDropDownState extends State<SelectedDropDown> {
//   void modalBottomSheetMenu(BuildContext context, Widget widget) {
//     showModalBottomSheet(
//       isScrollControlled: false,
//       context: context,
//       elevation: 4,
//       builder: (context) {
//         return widget;
//       },
//     );
//   }
//
//   TextEditingController? controller;
//   bool hasValue = false;
//   setItem(dynamic selectedItem) {
//     controller = TextEditingController(
//       text: selectedItem != null
//           ? Map<String, dynamic>.from(
//               json.decode(json.encode(selectedItem)))[widget.titleKey]
//           : widget.hint,
//     );
//     if (selectedItem != null) {
//       hasValue = true;
//     }
//   }
//
//   @override
//   void initState() {
//     setItem(widget.selectedItem);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (widget.readOnly == true) return;
//         if (widget.items.isEmpty) return;
//
//         showModalBottomSheet(
//           isScrollControlled: false,
//           context: context,
//           elevation: 4,
//           builder: (context) {
//             return CustomDropDownMenu(
//               titleKey: widget.titleKey,
//               selectedItem: widget.selectedItem,
//               items: widget.items,
//               onRefreshed: (value) {
//                 setItem(value);
//                 setState(() {});
//               },
//               title: widget.title,
//               onChange: widget.onChange,
//               readOnly: widget.readOnly,
//             );
//           },
//         );
//       },
//       child: PTextField(
//         hintText: widget.hint,
//         feedback: (value) {},
//         validator: (value) => null,
//       ),
//     );
//     // return AppTextFormFieldItem(
//     //   controller: controller,
//     //   readOnly: true,
//     //   title: '',
//     //   onTap: () {
//     //     if (widget.readOnly == true) return;
//     //     if (widget.items.isEmpty) return;
//     //
//     //     showModalBottomSheet(
//     //       isScrollControlled: false,
//     //       context: context,
//     //       elevation: 4,
//     //       builder: (context) {
//     //         return CustomDropDownMenu(
//     //           titleKey: widget.titleKey,
//     //           selectedItem: widget.selectedItem,
//     //           items: widget.items,
//     //           onRefreshed: (value) {
//     //             setItem(value);
//     //             setState(() {});
//     //           },
//     //           title: widget.title,
//     //           onChange: widget.onChange,
//     //           readOnly: widget.readOnly,
//     //         );
//     //       },
//     //     );
//     //   },
//     //   formFieldItemType: AppFormFieldItemType.text,
//     //   stream: BehaviorSubject().stream,
//     //   onChanged: null,
//     //   textInputType: TextInputType.text,
//     //   labelFontColor: labelColor,
//     //   borderColor: borderColor,
//     //   focusedBorderColor: textFormFieldFocusedColor,
//     //   iconColor: hintColor,
//     //   fontColor: hasValue ? fontColor : gray,
//     //   focusedIconColor: textFormFieldFocusedColor,
//     //   fillColor: bgColor,
//     //   showHint: true,
//     //   validator: widget.validator,
//     //   suffixIcon: const Icon(
//     //     Icons.keyboard_arrow_down_rounded,
//     //     size: 24,
//     //   ),
//     //   fontSize: SizeConfig.subTitleFontSize * 0.9,
//     //   borderRadius: BorderRadius.all(
//     //     Radius.circular(SizeConfig.paddingHalf),
//     //   ),
//     // );
//   }
// }
//
// class CustomDropDownMenu<T> extends StatelessWidget {
//   final String? title;
//   final String titleKey;
//   final String? hint;
//   final List<T> items;
//   T? selectedItem;
//   final ValueChanged onChange;
//   final TextStyle? style;
//   final TextStyle? hintStyle;
//   final Widget? icon;
//   final VoidCallback? onTap;
//   final ValueChanged<T> onRefreshed;
//   final bool? readOnly;
//   final Color? dropdownColor;
//
//   CustomDropDownMenu({
//     super.key,
//     this.title,
//     required this.titleKey,
//     this.hint,
//     required this.items,
//     this.selectedItem,
//     required this.onRefreshed,
//     required this.onChange,
//     this.style,
//     this.icon,
//     this.onTap,
//     this.readOnly = false,
//     this.dropdownColor,
//     this.hintStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // int position = 0 ;
//     // Get the index of the selected item to scroll to its position.
//     int selectedIndex = items.indexWhere((item) {
//       var mapItem = Map<String, dynamic>.from(json.decode(json.encode(item)));
//       return selectedItem != null &&
//           mapItem[titleKey] ==
//               Map<String, dynamic>.from(
//                   json.decode(json.encode(selectedItem)))[titleKey];
//     });
//     //
//     // ScrollController scrollController = ScrollController(
//     //   initialScrollOffset: selectedIndex != -1 ? selectedIndex * 44.54 : 0,
//     // );
//
//     return SafeArea(
//       child: Container(
//         height: getDynamicHeight(context),
//         color: Colors.white,
//         child: Stack(
//           children: [
//             StatefulBuilder(
//               builder: (context, setState) {
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 20, right: 40, top: 14, bottom: 14),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           PText(
//                             title: title ?? '',
//                             size: PSize.text16,
//                             fontColor: AppColors.primaryColor,
//                           ),
//                           Container(
//                             width: 40,
//                             height: 40,
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: AppColors.backgroundColor,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: InkWell(
//                               onTap: () => Navigator.pop(context),
//                               child:
//                                   const Icon(Icons.clear, color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                         // controller: scrollController,
//                         itemCount: items.length,
//                         itemBuilder: (context, index) {
//                           var map = Map<String, dynamic>.from(
//                               json.decode(json.encode(items[index])));
//                           dynamic item;
//                           if (selectedItem != null) {
//                             item = Map<String, dynamic>.from(
//                                 json.decode(json.encode(selectedItem)));
//                           }
//
//                           return InkWell(
//                             onTap: () {
//                               // onChange(items[index]);
//                               selectedItem = items[index];
//                               selectedIndex = index;
//                               setState(() {});
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 24, right: 24, top: 2, bottom: 2),
//                               child: Container(
//                                 height: 55,
//                                 padding: const EdgeInsets.only(
//                                     left: 8, right: 12, top: 11, bottom: 8),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   color: item == null
//                                       ? null
//                                       : '${map[titleKey]}' ==
//                                               '${item[titleKey]}' // Check if this is the selected item.
//                                           ? AppColors.backgroundColor
//                                           : null,
//                                 ),
//                                 child: PText(
//                                     title: '${map[titleKey]}',
//                                     size: PSize.text16),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     chooseButton(
//                       context,
//                       () {
//                         onChange(items[selectedIndex]);
//                         selectedItem = items[selectedIndex];
//                         // if(onRefreshed!=null){
//                         onRefreshed(selectedItem as T);
//                         // }
//                         Navigator.pop(context);
//                       },
//                     ),
//                     // Positioned(
//                     //   bottom: 0,
//                     //   left: 0,
//                     //   right: 0,
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.only(top: 0),
//                     //     child: chooseButton(
//                     //       context,
//                     //           () {
//                     //         print('selc>>' + selectedIndex.toString());
//                     //         onChange(items[selectedIndex]);
//                     //         selectedItem = items[selectedIndex];
//                     //         Navigator.pop(context);
//                     //       },
//                     //     ),
//                     //   ),
//                     // )
//                   ],
//                 );
//               },
//             ),
//             // Positioned(
//             //   bottom: 0,
//             //   left: 0,
//             //   right: 0,
//             //   child: Padding(
//             //     padding: const EdgeInsets.only(top: 30),
//             //     child: chooseButton(
//             //       context,
//             //       () {
//             //         print('selc>>' + selectedIndex.toString());
//             //         onChange(items[selectedIndex]);
//             //         selectedItem = items[selectedIndex];
//             //         Navigator.pop(context);
//             //       },
//             //     ),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
//
//   dynamic getDynamicHeight(BuildContext context) {
//     double height = MediaQuery.sizeOf(context).height * 0.60;
//     double itemHeight = 60;
//     double buttonHeight = 60;
//     double measureItems = (height / itemHeight) + buttonHeight;
//     if (items.length > measureItems) {
//       return null;
//     } else {
//       double h = items.length == 1 ? 2.8 : 1.6;
//       return (itemHeight * (items.length * h)) + buttonHeight;
//     }
//   }
//
//   Widget chooseButton(BuildContext context, void Function() onChange) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: ElevatedButton(
//         onPressed: () {
//           onChange();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryColor,
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check,
//               color: Colors.white,
//             ),
//             SizedBox(width: 8),
//             Text(
//               'اختيار',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

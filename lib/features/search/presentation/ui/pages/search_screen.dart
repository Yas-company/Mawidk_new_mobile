import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(context: context, removeTop: true,
      child: Scaffold(backgroundColor:AppColors.whiteBackground,
        appBar:PreferredSize(preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(top:20),
              child: appBar(context: context,text: 'بحث',isCenter:true,),
            )),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal:16),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(hint:'ابحث باسم الدكتور او التخصص',textInputAction: TextInputAction.send,
                  // isEnabled: false,
                  onChanged:(value) {
                },onFieldSubmitted:(value) {
                    context.push(AppRouter.searchResults,extra:value??'');
                },onTapFilter:() {
                      context.push(AppRouter.searchResults,extra:'');
                    }),
                Padding(
                  padding: const EdgeInsets.only(top:20,bottom:10),
                  child: PText(title:'اقتراحات',size:  PSize.text14,),
                ),
                Wrap(
                  spacing: 8.0, runSpacing: 0,
                  children: specializations.map((item) {
                    final bool isSelected = specializations.contains(item);
                    return ChoiceChip(
                      showCheckmark:false,
                      label:PText(title:item.optionText??'',size:PSize.text13,),
                      selected: isSelected,padding:EdgeInsets.zero,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor:AppColors.primaryColor2200,
                      backgroundColor:AppColors.whiteColor,
                      labelStyle: TextStyle(fontWeight:FontWeight.w400,
                          color:AppColors.primaryColor,
                          fontFamily:'cairo',fontSize:12
                      ),
                      onSelected:(value) {
                        context.push(AppRouter.searchResults,extra:item.optionText);
                      },
                    );
                  }).toList(),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top:8,bottom:10),
                //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       PText(title:'البحث السابق',size:  PSize.text14,),
                //       Stack(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(bottom: 3), // Adjust this value for spacing
                //             child: PText(
                //               title:'حذف',fontColor:AppColors.grey200,fontWeight:FontWeight.w500,
                //             ),
                //           ),
                //           Positioned(
                //             bottom:5, left: 0, right: 0,
                //             child: Container(height: 1,
                //               color:AppColors.grey200,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                // ListView.builder(itemBuilder:(context, index) {
                //   return Padding(
                //     padding: const EdgeInsets.only(top:2,bottom:5),
                //     child: Column(
                //       children: [
                //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             PText(title: 'دكتور اطفال',fontColor:AppColors.grey200,),
                //             GestureDetector(onTap:() {
                //
                //             }, child:Icon(Icons.clear,color:AppColors.grey200,))
                //           ],
                //         ),
                //         Divider(color:AppColors.grey100,)
                //       ],
                //     ),
                //   );
                // },shrinkWrap: true,itemCount:6,physics:NeverScrollableScrollPhysics(),)
              ],),
          ),
        ),),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/search_widget.dart';
import 'package:mawidak/features/search/presentation/bloc/search_bloc.dart';
import 'package:mawidak/features/search/presentation/bloc/search_event.dart';
import 'package:mawidak/features/search_results/presentation/ui/widgets/search_map_or_list_widget.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/bloc/search_for_doctors_bloc.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/bloc/search_for_doctors_event.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/ui/widget/search_result_for_doctor_widget.dart';

class SearchForDoctorsScreen extends StatefulWidget{
  String searchKey;
  SearchForDoctorsScreen({super.key,required this.searchKey,});

  @override
  State<SearchForDoctorsScreen> createState() => SearchForDoctorsScreenState();
}

class SearchForDoctorsScreenState extends State<SearchForDoctorsScreen> {
  SearchForDoctorsBloc searchBloc = SearchForDoctorsBloc(searchUseCase: getIt());

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(context: context, removeTop: true,
      child: BlocProvider(create: (context) => searchBloc,
        child: Scaffold(backgroundColor:AppColors.whiteBackground,
            appBar:PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: appBar(context: context,text: 'بحث',isCenter:true,),
                )),
            body:Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  child: SearchWidget(hasFilter:false,controller:TextEditingController(text:widget.searchKey),
                      hint:'patient_list'.tr(),textInputAction: TextInputAction.send,onFieldSubmitted:(value) {
                        widget.searchKey = value??'';
                        searchBloc.add(ApplySearchForDoctor(key:value??''));
                      }),
                ),
                BlocBuilder<SearchForDoctorsBloc, BaseState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(left:20,right:20,top:14,bottom:10),
                      child:PText(title: 'نتائج البحث :  ${searchBloc.itemLength}',
                        size: PSize.text14,fontColor: AppColors.blackColor,),
                    );
                  },
                ),
                BlocBuilder<SearchForDoctorsBloc, BaseState>(
                  builder: (context, state) {
                    return SearchResultForDoctorWidget(
                      searchBloc: searchBloc,
                      searchKey:widget.searchKey,);
                  },
                ),

              ],)
        ),
      ),
    );
  }
}

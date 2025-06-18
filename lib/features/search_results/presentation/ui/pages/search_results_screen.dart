import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/home/presentation/ui/widgets/search_widget.dart';
import 'package:mawidak/features/lookups/lookup_bloc.dart';
import 'package:mawidak/features/lookups/lookup_event.dart';
import 'package:mawidak/features/search/data/model/filter_request_model.dart';
import 'package:mawidak/features/search/presentation/bloc/search_bloc.dart';
import 'package:mawidak/features/search/presentation/bloc/search_event.dart';
import 'package:mawidak/features/search/presentation/ui/widgets/filter_bottom_sheet.dart';
import 'package:mawidak/features/search_results/presentation/ui/pages/search_map_screen.dart';
import 'package:mawidak/features/search_results/presentation/ui/pages/search_result_widget.dart';
import 'package:mawidak/features/search_results/presentation/ui/widgets/search_map_or_list_widget.dart';

class SearchResultsScreen extends StatefulWidget{
  final LookupBloc lookupBloc;
  String searchKey;
  bool isFilterClicked ;
  int? specializationId ;
  FilterRequestModel? filterRequestModel ;
  SearchResultsScreen({super.key,required this.searchKey,
  required this.lookupBloc,this.isFilterClicked=false,this.filterRequestModel,
  this.specializationId=0});

  @override
  State<SearchResultsScreen> createState() => SearchResultsState();
}

class SearchResultsState extends State<SearchResultsScreen> {
  SearchBloc searchBloc = SearchBloc(searchUseCase:getIt());
  // LookupBloc lookupBloc = LookupBloc(lookupUseCase:getIt());
  @override
  void initState() {
    super.initState();
    // print('model>>'+jsonEncode(widget.filterRequestModel));
    // lookupBloc.add(FetchCitiesEvent());
    if(widget.isFilterClicked){
      searchBloc.add(ApplyIsMapEvent(isMap: false));
      searchBloc.add(ApplyFilterEvent(filterRequestModel:widget.filterRequestModel??
          FilterRequestModel(specializationId:widget.specializationId??-1, cityId:0)));
    }
  }
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
                  child: SearchWidget(controller:TextEditingController(text:widget.searchKey),
                    hint:'ابحث باسم الدكتور',textInputAction: TextInputAction.send,
                    onChanged:(value) {
                    },onFieldSubmitted:(value) {
                    widget.searchKey = value??'';
                      searchBloc.add(ApplySearchForPatient(key:value??''));
                    },onTapFilter:() {
                        filterBottomSheet(context,widget.lookupBloc,(location, specialization, selectedVisitIndex,evaluate) {
                          widget.searchKey = specializations.firstWhere((e) => e.id == (specialization??0)).optionText??'';
                          setState(() {});
                          searchBloc.add(ApplyIsMapEvent(isMap: false));
                          // setState(() {});
                          searchBloc.add(ApplyFilterEvent(filterRequestModel:FilterRequestModel(
                              specializationId:specialization??0, cityId:location??0
                              // specializationId:1, cityId:11
                          )));
                        },);
                      }),
                ),
                BlocBuilder<SearchBloc, BaseState>(
                  builder: (context, state) {
                    bool isMap = false;
                    if (state is IsMapState) {
                      isMap = state.isMap;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SearchMapOrListWidget(
                        count: searchBloc.itemLength,
                        isMap: isMap, // Ensure your widget takes this prop
                        onValueChanged: (value) {
                          context.read<SearchBloc>().add(ApplyIsMapEvent(isMap: value));
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:20),
                //   child: BlocConsumer<SearchBloc,BaseState>(builder:(context, state) {
                //     return SearchMapOrListWidget(isMap:,count:searchBloc.itemLength,onValueChanged:(value) {
                //       searchBloc.add(ApplyIsMapEvent(isMap: value));
                //       setState(() {});
                //     },);
                //   }, listener:(context, state) {
                //
                //   },),
                // ),

                // if( searchBloc.isMap)const SizedBox(height:10,),
                // searchBloc.isMap ? SearchMapScreen(searchBloc: searchBloc,)
                //     : SearchResultWidget(searchBloc: searchBloc)

                BlocBuilder<SearchBloc, BaseState>(
                  builder: (context, state) {
                    return searchBloc.isMap
                        ? SearchMapScreen(searchBloc: searchBloc)
                        : SearchResultWidget(searchBloc: searchBloc,searchKey:widget.searchKey,);
                  },
                ),

              ],)
        ),
      ),
    );
  }
}

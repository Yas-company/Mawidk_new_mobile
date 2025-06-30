import 'package:mawidak/features/search/data/model/filter_request_model.dart';
import 'package:mawidak/features/search/data/model/search_map_request_model.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class ApplySearchForPatient extends SearchEvent {
  final String key;
  const ApplySearchForPatient({required this.key}) : super();
}

class ApplySearchMap extends SearchEvent {
  final SearchMapRequestModel searchMapRequestModel;
  const ApplySearchMap({required this.searchMapRequestModel}) : super();
}

class ApplyIsMapEvent extends SearchEvent {
  final bool isMap;
  const ApplyIsMapEvent({required this.isMap}) : super();
}

class ApplyFilterEvent extends SearchEvent {
  final FilterRequestModel filterRequestModel;
  const ApplyFilterEvent({required this.filterRequestModel}) : super();
}

class ApplyIsGridEvent extends SearchEvent {
  final bool isGrid;
  const ApplyIsGridEvent({required this.isGrid}) : super();
}
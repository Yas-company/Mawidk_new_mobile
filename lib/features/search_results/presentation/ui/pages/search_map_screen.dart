import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/core/services/location/location_service.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/features/search/data/model/search_map_request_model.dart';
import 'package:mawidak/features/search/data/model/search_map_response_model.dart';
import 'package:mawidak/features/search/presentation/bloc/search_bloc.dart';
import 'package:mawidak/features/search/presentation/bloc/search_event.dart';
import 'package:mawidak/features/search_results/presentation/ui/widgets/doctors_list_widget.dart';

class SearchMapScreen extends StatefulWidget {
  final SearchBloc searchBloc;
  const SearchMapScreen({super.key,required this.searchBloc});

  @override
  CommunicationMapScreenState createState() => CommunicationMapScreenState();
}

class CommunicationMapScreenState extends State<SearchMapScreen> {
  SearchBloc mapBloc = SearchBloc(searchUseCase: getIt());
  final List<Marker> _markers = [];
  MapController mapController = MapController();
  String? selectedMarkerId;
  ClinicData? mapItem;
  ClinicData? zoomedMapData;
  List<ClinicData> mapDataList = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final LocationData? locationData = await LocationService().getCurrentLocation();
    mapBloc.add(ApplySearchMap(searchMapRequestModel:SearchMapRequestModel(latitude: 32.0444,
        longitude: 33.2357)));
    // mapBloc.add(ApplySearchMap(
    //   searchMapRequestModel: SearchMapRequestModel(
    //     latitude: locationData?.latitude ?? 0,
    //     longitude: locationData?.longitude ?? 0,
    //   ),
    // ));
  }

  void loadMarkers(List<ClinicData> mapData) {
    _markers.clear();
    _markers.addAll(mapData.map((point) {
      bool isSelected = selectedMarkerId == (point.id ?? 0).toString();
      return Marker(
        width: 55,
        height: 55,
        point: LatLng(
          double.tryParse(point.latitude ?? '0.0') ?? 0.0,
          double.tryParse(point.longitude ?? '0.0') ?? 0.0,
        ),
        child: GestureDetector(
          onTap: () {
            selectedMarkerId = (point.id ?? 0).toString();
            mapItem = point;
            loadMarkers(mapData);
            mapController.move(
              LatLng(
                double.tryParse(point.latitude ?? '0.0') ?? 0.0,
                double.tryParse(point.longitude ?? '0.0') ?? 0.0,
              ),
              8,
            );
            setState(() {});
          },
          child: Image.asset(
            isSelected
                ? "assets/images/png/location_selected.png"
                : "assets/images/png/location_not_selected.png",
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
      );
    }));

    if (mapData.isNotEmpty) {
      zoomedMapData = mapData.first;

      // Delay the map movement to prevent zoom bug
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(
          LatLng(
            double.tryParse(zoomedMapData!.latitude ?? '0.0') ?? 0.0,
            double.tryParse(zoomedMapData!.longitude ?? '0.0') ?? 0.0,
          ),
          7,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mapBloc,
      child: BlocConsumer<SearchBloc, BaseState>(
        listener: (context, state) {
          if(state is LoadingState){
            loadDialog();
          }else if (state is LoadedState) {
            hideLoadingDialog();
            mapDataList = ((state.data.model?.model ?? []) as List<ClinicData>)
                .where((e) => (double.tryParse(e.latitude ?? '0') ?? 0) > 0)
                .toList();
            if (mapDataList.isNotEmpty) {
              loadMarkers(mapDataList);
              setState(() {});
            }
            widget.searchBloc.itemLength = mapDataList.length;
          }else if(state is ErrorState){
            hideLoadingDialog();
          }
        },
        builder: (context, state) {
          return Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: zoomedMapData != null
                        ? LatLng(
                      double.tryParse(zoomedMapData!.latitude ?? '0.0') ?? 0.0,
                      double.tryParse(zoomedMapData!.longitude ?? '0.0') ?? 0.0,
                    )
                        : const LatLng(0, 0),
                    initialZoom: 6,
                    maxZoom: 18,
                    minZoom: 3,
                    onTap: (_, __) {
                      setState(() {});
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      tileBuilder:null,
                      userAgentPackageName: 'com.example.app',
                    ),
                    TileLayer(
                      urlTemplate: 'https://api.maptiler.com/maps/0196cda6-d604-7a62-a115-ea8766581d21/?key=60hedG5jd4QzlrramGXo#8.0/52.09201/5.12380',
                      userAgentPackageName: 'com.example.app',
                      retinaMode: RetinaMode.isHighDensity(context),
                    ),
                    MarkerLayer(markers: _markers),
                  ],
                ),
                if (mapItem != null)
                  Positioned(
                    bottom: 20,
                    left: 14,
                    right: 14,
                    child: buildInfoCard(mapItem!),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildInfoCard(ClinicData item) {
    return InkWell(splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,onTap:() {
      context.push(AppRouter.doctorProfileScreen,extra:{
        'id':item.id??0,
        'name':item.name??'',
        'specialization':''
      });
    },child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child:DoctorsListWidget(onClickCard:() {
            context.push(AppRouter.doctorProfileScreen,extra:{
              'id':item.id??0,
              'name':item.name??'',
              'specialization':item.specialization??''
            });
          },imageUrl:item.image??'',
            imageColor: AppColors.whiteColor,
            backgroundColor: AppColors.whiteBackground,
            salary: item.consultationFee??'0',
            doctorName:item.name??'',
            rating: 4.8,
            specialization:item.specialization??'',
            location:item.address??'',
            onTap: () {
              context.push(AppRouter.appointmentBookingScreen,extra:{
                'id':item.id??0,
                'name':item.name??'',
                'specialization':item.specialization??''
              });
            },
          ),
          // child: Column(
          //   children: [
          //     Row(
          //       children: [
          //         const SizedBox(width: 8),
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               PText(
          //                 title: item.name ?? '',
          //                 size: PSize.text16,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //               const SizedBox(height: 4),
          //               PText(
          //                 title: item.address ?? '',
          //                 size: PSize.text16,
          //                 fontWeight: FontWeight.w400,
          //                 fontColor: AppColors.grey200,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     const SizedBox(height: 14),
          //     PButton(
          //       isFitWidth: true,
          //       onPressed: () {
          //         context.push(AppRouter.appointmentBookingScreen,extra:{
          //           'id':item.id??0,
          //           'name':item.name??'',
          //           'specialization':''
          //         });                // UrlLauncherManager.redirectUrl(item.link ?? '');
          //       },
          //       hasBloc: false,
          //       title:'book_appointment'.tr(),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mawidak/core/component/appbar/p_appbar.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/component/global_widgets.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/core/component/text/p_text.dart';
import 'package:mawidak/core/component/text_field/p_textfield.dart';
import 'package:mawidak/core/data/assets_helper/app_svg_icon.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';

class PickupLocationScreen extends StatefulWidget {
  const PickupLocationScreen({super.key});

  @override
  PickupLocationScreenState createState() => PickupLocationScreenState();
}

class PickupLocationScreenState extends State<PickupLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DeBouncer deBouncer = DeBouncer(milliseconds: 500);

  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      deBouncer.run(() {
        if (query.isNotEmpty) {
          searchLocation(query);
        } else {
          setState(() => _searchResults.clear());
        }
      });
    });
  }

  Future<void> searchLocation(String query) async {
    setState(() => _isLoading = true);
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=10');
    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterApp', // required for nominatim
    });
    if (response.statusCode == 200) {
      final List results = json.decode(response.body);
      setState(() {
        _searchResults = results.map<Map<String, dynamic>>((e) {
          return {
            'name': e['name'],
            'display_name': e['display_name'],
            'lat': e['lat'],
            'lon': e['lon'],
          };
        }).toList();
      });
    } else {
      setState(() => _searchResults = []);
    }

    setState(() => _isLoading = false);
  }

  // this using api
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      SafeToast.show(message:'Location permissions are denied',type:MessageType.error);
      return;
    }
    Position position = await Geolocator.getCurrentPosition();

    // Reverse geocoding: get name from lat/lon
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json',
    );
    loadDialog();
    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterApp', // Nominatim requires this header
    });
    hideLoadingDialog();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final displayName = data['display_name'] ?? 'Unknown location';
      setState(() {
        _searchResults.clear();
        _searchResults.add({
          'name': displayName,
          'lat': position.latitude.toString(),
          'lon': position.longitude.toString(),
        });
      });
    } else {
      SafeToast.show(message:'Failed to fetch location name',type:MessageType.error);
    }
  }


  // Future<void> getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   LocationPermission permission = await Geolocator.checkPermission();
  //
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return;
  //   }
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }
  //
  //   if (permission == LocationPermission.deniedForever ||
  //       permission == LocationPermission.denied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Location permissions are denied')),
  //     );
  //     return;
  //   }
  //
  //   Position position = await Geolocator.getCurrentPosition();
  //
  //   // 🧠 Reverse geocode without API
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //     position.latitude,
  //     position.longitude,
  //   );
  //
  //   if (placemarks.isNotEmpty) {
  //     final Placemark place = placemarks.first;
  //     final name = "${place.street}, ${place.locality}, ${place.subAdministrativeArea} , ${place.administrativeArea} , ${place.country} ";
  //     setState(() {
  //       _searchResults.clear();
  //       _searchResults.add({
  //         'name': name,
  //         'lat': position.latitude.toString(),
  //         'lon': position.longitude.toString(),
  //       });
  //       // _searchResults.insert(0, {
  //       //   'name': name,
  //       //   'lat': position.latitude.toString(),
  //       //   'lon': position.longitude.toString(),
  //       // });
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Could not get address from coordinates')),
  //     );
  //   }
  // }


  void onLocationSelected(Map<String, dynamic> location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${location['name']} \n ${location['display_name']??''}')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    deBouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:AppColors.whiteBackground,
      appBar:appBar(context:context,text: 'اختر موقعك',isCenter:true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            PTextField(controller:_searchController,hintText:'ابحث عن موقعك', feedback:(value) {

            }, validator:(value) => null,
            prefixIcon:Icon(Icons.search,color: AppColors.grey200,),
            suffixIcon:InkWell(
                onTap:getCurrentLocation,
                child: Icon(Icons.my_location,color:AppColors.primaryColor,)),),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(right:10),
              child: InkWell(onTap:getCurrentLocation,
                child: Row(children: [
                  PImage(source:AppSvgIcons.currentLocation,),
                  const SizedBox(width:10,),
                  PText(title:'استخدم موقعك الحالي',)
                ],),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8,bottom:10),
              child: Divider(color:AppColors.grey100,),
            ),
            if(_searchResults.isNotEmpty)Padding(
              padding: const EdgeInsets.only(right:14,left:14),
              child: PText(title: 'نتيجة البحث',fontColor:AppColors.grey200,),
            ),
            if (_isLoading)
              customLoader()
            else
              Expanded(
                child: _searchResults.isEmpty
                    ? Center(child: Text("No results"))
                    : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final location = _searchResults[index];
                    return ListTile(
                      contentPadding:EdgeInsets.zero,
                      minVerticalPadding:0,minLeadingWidth:0,
                      title:Padding(
                        padding: const EdgeInsets.symmetric(horizontal:14,vertical:10),
                        child: Row(mainAxisSize:MainAxisSize.max,children: [
                          Padding(
                            padding: const EdgeInsets.only(right:16,top:5),
                            child: PImage(source:AppSvgIcons.currentLocation,),
                          ),
                          const SizedBox(width:10,),
                          Expanded(child: PText(title:location['name'].isNotEmpty?
                          location['name']:location['display_name']))
                        ],),
                      ),
                      subtitle:Column(children: [
                        if(location['name'].isNotEmpty)
                          PText(title:location['display_name']??'',fontColor:AppColors.grey200,),
                        Padding(
                          padding: const EdgeInsets.only(top:8,bottom:10),
                          child: Divider(color:AppColors.grey100,),
                        ),
                      ],),
                      onTap: () => onLocationSelected(location),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}



class DeBouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  dispose() {
    _timer?.cancel();
  }
}
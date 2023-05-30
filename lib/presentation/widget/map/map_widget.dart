import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:steemit/data/model/location_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/location/data/locations/locations_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double _zoom = 18;

class MapWidget extends StatefulWidget {
  final LatLng? latLng;
  final String? location;

  const MapWidget({
    Key? key,
    this.latLng,
    this.location,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> googleMapController = Completer();
  final TextEditingController searchController = TextEditingController();
  LatLng? latLng;
  LatLng? currentLatLng;
  String? _mapStyle;
  final List<LocationModel> locations = List.empty(growable: true);
  Timer? searchOnStoppedTyping;
  String? location;
  String? currentLocation;

  @override
  void initState() {
    rootBundle.loadString('assets/map_style/map_style.txt').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });

    getCurrentLocation();

    getIt.get<LocationsCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is LocationsSuccess) {
        setState(() {
          locations.clear();
          locations.addAll(event.locations);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
              topPadding: MediaQuery.of(context).padding.top,
              content: S.current.lbl_choose_location,
              prefixIconPath: Icons.chevron_left,
              onPrefix: () => Navigator.pop(context),
              suffixContent: S.current.btn_done,
              onSuffix: () => Navigator.pop(context, [latLng, location])),
          Expanded(
            child: Stack(
              children: [
                if (latLng != null)
                  GoogleMap(
                    myLocationButtonEnabled: false,
                    initialCameraPosition:
                        CameraPosition(target: latLng!, zoom: _zoom),
                    onMapCreated: (GoogleMapController controller) async {
                      googleMapController.complete(controller);
                      (await googleMapController.future).setMapStyle(_mapStyle);
                    },
                    markers: {
                      Marker(
                          markerId: MarkerId(
                              "${latLng!.latitude}${latLng!.longitude}"),
                          position: latLng!)
                    },
                  )
                else
                  const Center(
                    child: CircularProgressIndicator(
                      color: BaseColor.green500,
                    ),
                  ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        if (locations.isNotEmpty)
                          Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 48),
                                shrinkWrap: true,
                                itemCount: locations.length,
                                itemBuilder: (context, index) {
                                  final location = locations[index];
                                  return ListTile(
                                    style: ListTileStyle.list,
                                    leading: const Icon(
                                      Icons.location_pin,
                                      color: BaseColor.red500,
                                    ),
                                    title: Text(
                                      location.description!,
                                      style: BaseTextStyle.body1(),
                                    ),
                                    onTap: () => selectLocation(location),
                                  );
                                }),
                          ),
                        TextFieldWidget.searchWhite(
                          onSuffixIconTap: () async {
                            setState(() {
                              searchController.clear();
                              locations.clear();
                              FocusScope.of(context).unfocus();
                              latLng = currentLatLng;
                              location = currentLocation;
                            });
                            (await googleMapController.future).animateCamera(
                                CameraUpdate.newLatLngZoom(latLng!, _zoom));
                          },
                          suffixIconPath: searchController.text.isNotEmpty
                              ? Icons.close
                              : null,
                          textEditingController: searchController,
                          onChanged: (value) => _onChangeHandler(value),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void selectLocation(LocationModel location) async {
    setState(() {
      FocusScope.of(context).unfocus();
      locations.clear();
      searchController.text = location.description!;
      latLng = LatLng(location.latLng!.latitude, location.latLng!.longitude);
      this.location = location.description;
    });
    (await googleMapController.future)
        .animateCamera(CameraUpdate.newLatLngZoom(latLng!, _zoom));
  }

  _onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel());
    }
    setState(() => searchOnStoppedTyping = Timer(duration, () {
          if (value.isNotEmpty) {
            getIt.get<LocationsCubit>().getData(value);
          } else {
            setState(() {
              locations.clear();
            });
          }
        }));
  }

  Future<void> getCurrentLocation() async {
    if (widget.latLng != null) {
      setState(() {
        latLng = widget.latLng;
        location = widget.location;
      });
    } else {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLatLng = LatLng(position.latitude, position.longitude);
        latLng = currentLatLng;
      });
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentLatLng!.latitude, currentLatLng!.longitude);
      setState(() {
        currentLocation =
            "${placeMarks.first.street}, ${placeMarks.first.subAdministrativeArea}, ${placeMarks.first.administrativeArea}";
        location = currentLocation;
      });
    }
  }
}

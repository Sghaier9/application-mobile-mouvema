import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:mouvema/src/core/internet_checker.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:geocoding/geocoding.dart' as geo;
import '../widgets/searchBarMap.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.onchange});
  final void Function(LatLng?)? onchange;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng? _selectedLocation;
  LatLng? origin;
  List<Marker> markers = [];
  Map<String, Marker?> mark = {'origin': null, 'destination': null};
  bool isConnected = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    verifyConnection();
    return (isConnected)
        ? Scaffold(

            body: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onLongPress: (tapPosition, point) {
                      onLongPress(tapPosition, point);
                    },
                    center: _selectedLocation ?? const LatLng(48, 2),
                    zoom: 6,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(markers: markers)
                  ],
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 8,
                                spreadRadius: 2)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 35),
                      // color: Colors.white,
                      child: Column(children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.arrow_back))
                          ],
                        ),

                             SearchBarMap(
                                location: 'Event location',
                                onSearch: (value) {
                                  _searchLocation(value, 'origin', pickUpIcon);
                                },
                              ),


                      ]),
                    ))
              ],
            ))
        : Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/warning.png',
                  width: 50,
                )),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text('There is no internet connection'),
                ),
              ],
            ),
          );
  }

  void _searchLocation(String query, String place, Icon icon) async {
    // String query = _searchController.text;
    if (query.isNotEmpty) {
      List<geo.Location> locations = await geo.locationFromAddress(query);
      if (locations.isNotEmpty) {
        setState(() {
          _selectedLocation =
              LatLng(locations[0].latitude, locations[0].longitude);
          //mapController.move(_selectedLocation!, 10);
          if (place == 'origin') {
            if (origin != null) {
              markers.removeAt(0);
            }
            origin = _selectedLocation;
            markers.insert(0, marker(origin!, pickUpIcon));
          }
          /*else {
            if (destination != null) {
              markers.removeLast();
            }
            destination = _selectedLocation;
            markers.add(marker(destination!, dropDownIcon));
          }*/
        });
      }
    }
  }

  void verifyConnection() async {
    bool a = await InternetCheckerImpl().isConnected();

    setState(() {
      isConnected = a;
    });
  }

  void onLongPress(tapPosition, point) {
    if (origin != null && _isSameLocation(point, origin!, mapController.zoom)) {
      setState(() {
        markers.removeAt(0);
        origin = null;
      });
    }

    else if (origin == null) {
      setState(() {
        origin = point;
        markers.insert(0, marker(point, pickUpIcon));
        widget.onchange!(origin);
      });
    }

  }

  Marker marker(LatLng point, Icon markerIcon) {
    return Marker(
      point: LatLng(point.latitude, point.longitude),
      builder: (context) {
        return markerIcon;
      },
    );
  }

  bool _isSameLocation(LatLng location1, LatLng location2, double zoom) {
    double markerTolerance;
    if (zoom < 10) {
      markerTolerance = 0.1;
    } else {
      markerTolerance = 0.01;
    }

    return (location1.latitude - location2.latitude).abs() < markerTolerance &&
        (location1.longitude - location2.longitude).abs() < markerTolerance;
  }



  Icon pickUpIcon = const Icon(
    Icons.location_pin,
    color: Color.fromARGB(255, 5, 206, 105),
  );
  Icon dropDownIcon = const Icon(
    Icons.location_pin,
    color: Color.fromARGB(255, 247, 23, 7),
  );
}

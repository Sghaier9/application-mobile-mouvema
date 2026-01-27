// ignore_for_file: depend_on_referenced_packages
import 'package:location/location.dart' as loc;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'
    show
        FlutterMap,
        InteractiveFlag,
        MapController,
        MapOptions,
        Marker,
        MarkerLayer,
        TileLayer;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MapView extends StatelessWidget {
  MapView({
    super.key,
    required this.size,
    required this.origin,
  });
  final LatLng origin;
  final Size size;
  late List<Marker> markers;

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.4,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.none,
              center: origin,
              zoom: 6,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: [
                Marker(
                  point: origin,
                  builder: (context) {
                    return const Icon(
                      Icons.location_pin,
                      color: Color.fromARGB(255, 8, 240, 8),
                    );
                  },
                ),

              ])
            ],
          ),
        ),
        Positioned(
            bottom: 2,
            right: 2,
            child: IconButton(
              onPressed: () {
                openGoogleMapsDirections(origin);
              },
              icon: const Icon(
                Icons.directions,
                color: Colors.teal,
                size: 50,
              ),
            ))
      ],
    );
  }

  LatLng calculateCenter(LatLng point1, LatLng point2) {
    double avgLatitude = (point1.latitude + point2.latitude) / 2;
    double avgLongitude = (point1.longitude + point2.longitude) / 2;
    return LatLng(avgLatitude, avgLongitude);
  }

  Marker marker(LatLng point, Icon markerIcon) {
    return Marker(
      point: LatLng(point.latitude, point.longitude),
      builder: (context) {
        return markerIcon;
      },
    );
  }

  double _calculateDistance(LatLng latLng1, LatLng latLng2) {
    const double earthRadius = 6371.0;

    double lat1 = latLng1.latitude;
    double lon1 = latLng1.longitude;
    double lat2 = latLng2.latitude;
    double lon2 = latLng2.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

}


Future<LatLng> _getCurrentLocation() async {
  bool serviceEnabled;
  loc.PermissionStatus permissionGranted;
  loc.Location location = loc.Location();

  // Check if location services are enabled
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {

    }
  }

  // Check for location permissions
  permissionGranted = await location.hasPermission();
  if (permissionGranted == loc.PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != loc.PermissionStatus.granted) {

    }
  }
  loc.LocationData locationData = await location.getLocation();
  return LatLng(locationData.latitude!, locationData.longitude!) ;

}

void openGoogleMapsDirections(LatLng destination) async {
  LatLng origin = await _getCurrentLocation();
  final url =
      'https://www.google.com/maps/dir/?api=1&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&travelmode=driving';

  try {
    // ignore: deprecated_member_use
    (await canLaunch(url));
    // ignore: deprecated_member_use
    await launch(url);
    // ignore: empty_catches
  } catch (e) {}
}

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/event.dart';
import '../../shared/toggle_farvorite_button.dart';
import 'widgets/details.dart';
import 'widgets/map_view.dart';

class LoadDetailsScreen extends StatelessWidget {
  const LoadDetailsScreen({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text('Details'),
        actions: [ToggleFavorites(loadRef: event.eventRef)],
        centerTitle: true,
      ),

      //appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MapView(
                origin: LatLng(event.adressLat, event.adressLng), size: size),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Details(
                event: event,
              ),
            )
          ],
        ),
      ),
    );
  }
}

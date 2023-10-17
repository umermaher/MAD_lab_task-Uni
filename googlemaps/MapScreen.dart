import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.title});

  final String title;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  _handleTap(LatLng point) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GoogleMap(
          onTap: (argument) {
            _handleTap(argument);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.4279, -122.0888),
            zoom: 12,
          ),
          markers: {
            const Marker(
              markerId: MarkerId("My-Marker"),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(37.4279, -122.0888),
              infoWindow: InfoWindow(title: "My Marker"),
            )
          },
        ),
      ),
    );
  }
}

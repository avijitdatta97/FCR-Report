import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  static const String routeName = '/mappage';
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  static final CameraPosition _kBangladesh = const CameraPosition(
      target: LatLng(23.8041, 90.415),
      zoom: 14,
  );

  List<Marker> _mapMarker = [];
  List<Marker> _mapMarkerList = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(23.8041, 90.415),
      infoWindow: InfoWindow(
        title: 'Dhaka',
      )
    ),
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(23.7612, 90.4208),
        infoWindow: InfoWindow(
          title: 'Rampura',
        )
    ),
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(23.7685, 90.4255),
        infoWindow: InfoWindow(
          title: 'East West University',
        )
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _mapMarker.addAll(_mapMarkerList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kBangladesh,
        markers: Set<Marker>.of(_mapMarker),
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
      // floatingActionButton: FloatingActionButton(
      // ),
    );
  }
}

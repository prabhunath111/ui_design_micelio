import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ui_design_demo/screens/map/map_drawer.dart';
import 'package:ui_design_demo/screens/map/top_search_section.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.9061, 77.5845),
    zoom: 15,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void handleDrawer() {
    setState(() {
      print("line23");
      _scaffoldKey.currentState.openDrawer();
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MapDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated,
            trafficEnabled: true,
            // myLocationEnabled: true,
            // myLocationButtonEnabled: true,
            markers: Set<Marker>.of(markers.values),
          ),
          TopSearchSection(handleDrawer: handleDrawer)
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ui_design_demo/screens/map/map_drawer.dart';
import 'package:ui_design_demo/screens/map/top_search_section.dart';
import 'package:http/http.dart' as http;
import 'package:ui_design_demo/screens/map/widgets/bottom_card.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var nearbyChargers;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.9061, 77.5845),
    zoom: 15,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void handleDrawer() {
    setState(() {
      _scaffoldKey.currentState.openDrawer();
    });
  }

  createMarker(lat, lng) {
    // creating a new MARKER
    var markerIdVal = markers.length + 1;
    String mar = markerIdVal.toString();
    final MarkerId markerId = MarkerId(mar);
    final Marker marker =
        Marker(markerId: markerId, position: LatLng(lat, lng));
    setState(() {
      markers[markerId] = marker;
      getNearbyCharger(lat, lng);
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
          TopSearchSection(
              handleDrawer: handleDrawer, createMarker: createMarker
          ),
          BottomCard(nearbyChargers: nearbyChargers, createMarker: createMarker),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }

  Future getNearbyCharger(lat, lng) async {
    var uri = 'https://micelio.herokuapp.com/chargers/nearcharger';
    final headers = {'Content-Type': 'application/json'};
    var body = {
      "location": {
        "type": "Point",
        "coordinates": [lat, lng]
      }
    };
    final jsonBody = jsonEncode(body);
    http.post(
        Uri.parse(uri),
        body: jsonBody, headers: headers).then((response) {
      final body1 = json.decode(response.body);
      print("line89 $body1");
      setState(() {
        nearbyChargers = body1;
      });
    });
  }
}

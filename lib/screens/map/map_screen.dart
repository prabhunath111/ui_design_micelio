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
  var origin = [];
  var dest = [];
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

  createMarker(lat, lng, isOrigin) {
    // creating a new MARKER
    var markerIdVal = markers.length + 1;
    String mar = markerIdVal.toString();
    final MarkerId markerId = MarkerId(mar);
    final Marker marker =
        Marker(markerId: markerId, position: LatLng(lat, lng));
    setState(() {
      if (isOrigin) {
        origin.add(lat);
        origin.add(lng);
      } else {
        dest.add(lat);
        dest.add(lng);
      }
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
              handleDrawer: handleDrawer, createMarker: createMarker),
          BottomCard(
              nearbyChargers: nearbyChargers,
              createMarker: createMarker,
              updateCameraLocation: updateCameraLocation),
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
    http
        .post(Uri.parse(uri), body: jsonBody, headers: headers)
        .then((response) {
      final body1 = json.decode(response.body);
      print("line89 $body1");
      setState(() {
        nearbyChargers = body1;
      });
    });
  }

  Future<void> updateCameraLocation() async {
    LatLng source = LatLng(origin[0], origin[1]);
    LatLng destination = LatLng(dest[0], dest[1]);
    print("line112 $source  $destination");
    print("line114 $mapController");
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);

  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }
}

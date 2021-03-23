import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ui_design_demo/screens/map/map_drawer.dart';
import 'package:ui_design_demo/screens/map/top_search_section.dart';
import 'package:http/http.dart' as http;
import 'package:ui_design_demo/screens/map/widgets/bottom_card.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> _polylines = {};
  String googleAPIKey = "AIzaSyAFfkk5FtmXgIsbHQzmEXsyFOACA4Jj_oY";

  var nearbyChargers;
  var origin = [];
  var dest = [];
  var userIcon;
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

  createMarker(lat, lng, isOrigin) async {
    // creating a new MARKER
    var markerIdVal = markers.length + 1;
    String mar = markerIdVal.toString();
    final MarkerId markerId = MarkerId(mar);
    if (isOrigin) {
      await createIconFromIconData(lat, lng, markerId, true);
    } else {
      await createIconFromIconData(lat, lng, markerId, false);
    }
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
            polylines: _polylines,
          ),
          TopSearchSection(
              handleDrawer: handleDrawer, createMarker: createMarker),
          BottomCard(
              nearbyChargers: nearbyChargers,
              createMarker: createMarker,
              updateCameraLocation: updateCameraLocation,
              setPolylines: setPolylines),
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
      setState(() {
        nearbyChargers = body1;
      });
    });
  }

  Future<void> updateCameraLocation() async {
    LatLng source = LatLng(origin[0], origin[1]);
    LatLng destination = LatLng(dest[0], dest[1]);
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

  Future setPolylines() async {
    if (polylineCoordinates.length > 0) {
      polylineCoordinates.clear();
    }
    PolylineResult result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(origin[0], origin[1]),
        PointLatLng(dest[0], dest[1]),
        travelMode: TravelMode.driving);
    if (result != null) {
      result.points.forEach((point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Colors.blue,
          width: 8,
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }

  Future createIconFromIconData(lat, lng, markerId, isOrigin) async {
    final iconData = (isOrigin)?Icons.directions_bike_sharp:Icons.electrical_services;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // calculate marker dimensions
    double _markerSize = 120;
    double _circleStrokeWidth = _markerSize / 10.0;
    double _circleOffset = _markerSize / 2;
    double _outlineCircleWidth = _circleOffset - (_circleStrokeWidth / 2);
    double _fillCircleWidth = _markerSize / 2;
    final outlineCircleInnerWidth = _markerSize - (2 * _circleStrokeWidth);
    double _iconSize = sqrt(pow(outlineCircleInnerWidth, 2) / 2);
    final rectDiagonal = sqrt(2 * pow(_markerSize, 2));
    final circleDistanceToCorners = (rectDiagonal - outlineCircleInnerWidth) / 2;
    double _iconOffset = sqrt(pow(circleDistanceToCorners, 2) / 2);
    _paintCircleFill(canvas, Colors.amber, _circleOffset, _fillCircleWidth);
    _paintCircleStroke(canvas, Colors.green, _circleStrokeWidth, _circleOffset, _outlineCircleWidth);
    _paintIcon(canvas, Colors.red, iconData, _iconSize, _iconOffset);
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(_markerSize.round(), _markerSize.round());
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    final bitmapDescriptor =
        BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
    setState(() {
      if (isOrigin) {
        origin.add(lat);
        origin.add(lng);
        userIcon = bitmapDescriptor;
      } else {
        dest.add(lat);
        dest.add(lng);
        userIcon = bitmapDescriptor;
      }
      final Marker marker = Marker(
          markerId: markerId, position: LatLng(lat, lng), icon: userIcon);
      markers[markerId] = marker;
      getNearbyCharger(lat, lng);
    });
  }

  /// Paints the icon background
  void _paintCircleFill(Canvas canvas, Color color, double _circleOffset, double _fillCircleWidth) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawCircle(Offset(_circleOffset, _circleOffset), _fillCircleWidth, paint);
  }
  /// Paints a circle around the icon
  void _paintCircleStroke(Canvas canvas, Color color, double _circleStrokeWidth, double _circleOffset, double _outlineCircleWidth) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = _circleStrokeWidth;
    canvas.drawCircle(Offset(_circleOffset, _circleOffset), _outlineCircleWidth, paint);
  }

  /// Paints the icon
  void _paintIcon(Canvas canvas, Color color, IconData iconData, double _iconSize, double _iconOffset) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: _iconSize,
          fontFamily: iconData.fontFamily,
          color: color,
        )
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(_iconOffset, _iconOffset));
  }
}

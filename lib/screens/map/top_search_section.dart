import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';

class TopSearchSection extends StatefulWidget {
  final handleDrawer;
  final createMarker;
  const TopSearchSection({Key key, this.handleDrawer, this.createMarker}) : super(key: key);

  @override
  _TopSearchSectionState createState() => _TopSearchSectionState();
}

class _TopSearchSectionState extends State<TopSearchSection> {
  static const kGoogleApiKey = "AIzaSyAUDJWykw7T79Tftb8EmXFaYRkAwr3SGRk";
  var searchedLocation = 'Your Location';
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  // const kGoogleApiKey = "My key";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
        top: screenHeight * 0.06,
        left: 0.0,
        right: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black87,
                  size: 22,
                ),
                onPressed: () {
                  widget.handleDrawer();
                }),
            Expanded(
              child: GestureDetector(
                onTap: searchLocation,
                child: Container(
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(searchedLocation)),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.black87,
                      size: 20,
                    ),
                    onPressed: null)),
          ],
        ));
  }

  Future searchLocation() async {
    // should show search screen here
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.overlay,
        // Mode.fullscreen
        language: "en",
        components: [Component(Component.country, "in")]);
    setState(() {
      searchedLocation = p.description.toString();
      print("line91 $searchedLocation");
    });
    if (searchedLocation != 'Your Location') {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      var placeId = p.placeId;
      print("line101 $placeId");
      print("line98 ${detail.result.geometry.location}");
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      // var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print("line108$lat");
      print("line109 $lng");
      widget.createMarker(lat, lng, true);
    }
  }
}

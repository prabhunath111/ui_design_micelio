import 'package:geolocator/geolocator.dart';
class GetCurrentLocation {
  Position currPosition;
  Future getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((Position position) {
      print("position, $position");
      currPosition=position;
    }).catchError((e) {
      print(e);
    });
  }
}
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final _geolocation = Geolocator();

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }

    return await Geolocator.getCurrentPosition();
  }
}
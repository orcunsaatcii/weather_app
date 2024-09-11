import 'package:location/location.dart';

class LocationService {
  static final Location _location = Location();

  static Future<LocationData?> getCurrentLocation() async {
    if (!await _location.serviceEnabled()) {
      if (!await _location.requestService()) {
        return null;
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await _location.getLocation();
  }
}

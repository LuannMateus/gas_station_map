import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class GasStationController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String error = '';

  GasStationController() {
    getPosition();
  }

  Future<void> getPosition() async {
    try {
      Position position = await _actualPosition();
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _actualPosition() async {
    LocationPermission permission;

    bool activate = await Geolocator.isLocationServiceEnabled();

    if (!activate) {
      return Future.error('Please, turn on the smartphone locator');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'Please, Do you need authorize the smartphone locator');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Do you need authorize the access of location');
    }

    return await Geolocator.getCurrentPosition();
  }
}

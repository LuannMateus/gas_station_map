import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation_gas_station/pages/gas_station_screen/gas_station_screen.dart';
import 'package:geolocation_gas_station/repositories/gas_station_repository.dart';
import 'package:geolocation_gas_station/widgets/StationDetails.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GasStationController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String error = '';
  Set<Marker> markers = Set<Marker>();
  late GoogleMapController _mapsController;

  get mapController => _mapsController;

  Future<void> onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosition();
    loadStations();
  }

  Future<void> getPosition() async {
    try {
      Position position = await _actualPosition();
      lat = position.latitude;
      long = position.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }

  loadStations() {
    final stations = GasStationRepository().stations;

    stations.forEach((station) async {
      markers.add(
        Marker(
          markerId: MarkerId(station.name),
          position: LatLng(station.latitude, station.longitude),
          onTap: () {
            showModalBottomSheet(
              context: appKey.currentState!.context,
              builder: (context) => StationDetails(station: station),
            );
          },
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(),
            'images/posto.png',
          ),
        ),
      );
    });

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

import 'package:flutter/material.dart';
import 'package:geolocation_gas_station/pages/gas_station_screen/gas_station_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gas Station - Geolocation',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: GasStationScreen(),
    );
  }
}

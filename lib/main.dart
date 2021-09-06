import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:geolocation_gas_station/pages/gas_station_screen/gas_station_controller.dart';
import 'package:geolocation_gas_station/pages/gas_station_screen/gas_station_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    ChangeNotifierProvider<GasStationController>(
      create: (_) => GasStationController(),
      child: MyApp(),
    ),
  );
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

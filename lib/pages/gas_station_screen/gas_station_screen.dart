import 'package:flutter/material.dart';
import 'package:geolocation_gas_station/pages/gas_station_screen/gas_station_controller.dart';
import 'package:provider/provider.dart';

class GasStationScreen extends StatefulWidget {
  GasStationScreen({Key? key}) : super(key: key);

  @override
  _GasStationScreenState createState() => _GasStationScreenState();
}

class _GasStationScreenState extends State<GasStationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Place'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<GasStationController>(
        create: (context) => GasStationController(),
        child: Builder(
          builder: (context) {
            final local = context.watch<GasStationController>();

            String message = local.error == ''
                ? 'Latituded: ${local.lat} | Longitude ${local.long}'
                : local.error;

            return Center(
              child: Text(message),
            );
          },
        ),
      ),
    );
  }
}

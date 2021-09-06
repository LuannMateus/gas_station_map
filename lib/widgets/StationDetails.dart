import 'package:flutter/material.dart';
import 'package:geolocation_gas_station/models/gas_station.dart';

class StationDetails extends StatelessWidget {
  GasStation station;

  StationDetails({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Image.network(
          station.photo,
          height: 250,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            station.name,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 24),
          child: Text(station.address),
        )
      ],
    );
  }
}

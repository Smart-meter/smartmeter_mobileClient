

import 'package:flutter/material.dart';

class Meter extends StatelessWidget {
   Meter({super.key, required this.meterReading});

  String meterReading;

  @override
  Widget build(BuildContext context) {
    return  Center(child: Padding(
      padding: const EdgeInsets.all(8),
      child: Text(meterReading, style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),),
    ));
  }
}

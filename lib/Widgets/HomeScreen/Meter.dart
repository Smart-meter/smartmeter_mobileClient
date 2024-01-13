

import 'package:flutter/material.dart';

class Meter extends StatelessWidget {
  const Meter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Padding(
      padding: EdgeInsets.all(16),
      child: Text("000000000", style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),),
    ));
  }
}

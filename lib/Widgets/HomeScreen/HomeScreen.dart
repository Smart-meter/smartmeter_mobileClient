import 'package:flutter/material.dart';
import 'package:smartmeter/Meter.dart';
import 'package:smartmeter/Widgets/HomeScreen/Greet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Greet(),
        SizedBox(
          height: 16,
        ),
        Text(
          "Your Current meter reading",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        Meter(),
      ]),
    );
  }
}

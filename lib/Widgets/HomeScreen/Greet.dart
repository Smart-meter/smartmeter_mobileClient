

import 'package:flutter/material.dart';

class Greet extends StatelessWidget{
  const Greet({super.key});




  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    print(now);
    Widget w;
    var hour = int.parse(now.hour.toString());
    print(hour);
    if(hour>=5 && hour<=12){
      w = const Text("Good Morning,\nChiruhas", style: TextStyle(color: Colors.blueAccent, fontSize: 32, fontWeight: FontWeight.w700));
    }
    else if(hour>=12 && hour<18){
      w = const Text("Good Afternoon,\nChiruhas", style: TextStyle(color: Colors.blueAccent, fontSize: 32, fontWeight: FontWeight.w700));
    }
    else{
      w = const Text("Good Evening,\nChiruhas", style: TextStyle(color: Colors.blueAccent, fontSize: 32, fontWeight: FontWeight.w700));
    }


       return w;

  }

}
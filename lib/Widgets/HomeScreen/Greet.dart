

import 'package:flutter/material.dart';

class Greet extends StatelessWidget{
   Greet({super.key, required this.userName});

  String userName;




  @override
  Widget build(BuildContext context) {

    userName = userName.trim();
    userName = userName[0]+userName.substring(1).toLowerCase();

    DateTime now = DateTime.now();

    Widget w;
    var hour = int.parse(now.hour.toString());

    if(hour>=5 && hour<=12){
      w =  Text("Good Morning,\n$userName",maxLines: 2, style: const TextStyle(color: Colors.blueAccent, fontSize: 32, fontWeight: FontWeight.w700, ));
    }
    else if(hour>=12 && hour<18){
      w =  Text("Good Afternoon,\n$userName",maxLines: 2, style: const TextStyle(color: Colors.blueAccent, fontSize: 32, fontWeight: FontWeight.w700));
    }
    else{
      w =  Text("Good Evening,\n$userName",maxLines: 2, style: const TextStyle(color: Colors.blueAccent, fontSize: 32, fontWeight: FontWeight.w700));
    }


       return w;

  }

}
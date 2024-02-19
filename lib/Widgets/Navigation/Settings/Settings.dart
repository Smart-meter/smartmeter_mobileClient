

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class Settings extends StatefulWidget{
  const Settings({super.key});


  @override
  State<StatefulWidget> createState() {
   return _SettingsState();
  }

}


class _SettingsState extends State<Settings>{

   void _clearData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      // clear shared prefs and navigate to main page
      _clearData();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }, child: Text("Logout"));
  }

}
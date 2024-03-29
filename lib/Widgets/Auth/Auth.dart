import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/Auth/Login.dart';
import 'package:smartmeter/helpers/SharedPrefHelper.dart';

import '../Navigation/Navigation.dart';

class Auth extends StatefulWidget {
   Auth({super.key});

  bool authStatus = false;

  @override
  State<StatefulWidget> createState()  {

    return _AuthState();
  }
}

class _AuthState extends State<Auth> {


  bool _isAuthenticated =false;
 void authStatus(bool status){
   setState(() {
     _isAuthenticated = status;
   });
  }


  @override
  void initState()  {

   asyncStuff();

  }

  void asyncStuff() async{

   SharedPreferences prefs = await SharedPrefsHelper.getPrefs();

    setState(() {
      _isAuthenticated = prefs.getBool("isAuthenticated") ?? false;
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget loginWidget = Scaffold(
        backgroundColor: Colors.black,
        body:  Login(isAuthenticated: authStatus));

   return _isAuthenticated ? const Navigation():loginWidget;
  }
}

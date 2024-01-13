import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/Auth/Login.dart';

import '../Navigation/Navigation.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});



  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<Auth> {

  //todo
  /// this value must be precomputed depending on the user auth status
  bool _isAuthenticated =true;
 void authStatus(bool status){
   setState(() {
     _isAuthenticated = status;
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

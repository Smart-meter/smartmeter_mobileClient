import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/HomeScreen/Meter.dart';
import 'package:smartmeter/Widgets/HomeScreen/Greet.dart';

import '../../helpers/user_details_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

 String userName="";

  void fetchUserName() async{

  }


 void asyncStuff() async{
   final prefs = await SharedPreferences.getInstance();

   // userDetails is the prefs key i choosed

   if(!prefs.containsKey("userDetails")){
     // make an api call and update the prefs.

     await UserDetailsHelper.fetchUserDetails();
     final prefs = await SharedPreferences.getInstance();

     setState(() {
       userName= prefs.getString("firstName")!;
       print(userName);
     });
   }else{
     if (kDebugMode) {
       print("User details present");
     }
   }


 }


 @override
  void initState() {
    asyncStuff();
//
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Greet(userName:userName),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Your Current meter reading",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        const Meter(),
      ]),
    );
  }
}

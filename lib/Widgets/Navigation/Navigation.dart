import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/HomeScreen/HomeScreen.dart';
import 'package:smartmeter/Widgets/Navigation/Settings/Settings.dart';
import 'package:smartmeter/helpers/user_details_helper.dart';

import 'Camera/Camera.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<Navigation> {
  int currentPage = 0;

  void changePage(int page){
    setState(() {
      currentPage = page;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        indicatorColor: Colors.blueAccent,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPage,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            label: 'Camera',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
        child: currentPage == 0 ? const HomeScreen() : currentPage == 1
            ?  Camera(changePage : changePage)
            : const Settings(),
      ),
      backgroundColor: Colors.black,
    );
  }
}

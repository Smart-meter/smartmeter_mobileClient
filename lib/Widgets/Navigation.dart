import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/HomeScreen/HomeScreen.dart';

import 'History/History.dart';
import 'Settings/Settings.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<Navigation> {
   int currentPage = 0;

  //Widget currentPage= const Home();

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
              Icons.history,
              color: Colors.white,
            ),
            label: 'History',
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
        child: currentPage ==0 ? const HomeScreen() : currentPage==1 ? const History() : Settings(),
      ),
      backgroundColor: Colors.black,
    );
  }
}

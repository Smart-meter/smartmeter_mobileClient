import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/HomeScreen/HomeScreen.dart';
import 'package:smartmeter/Widgets/Navigation/History/History.dart';
import 'package:smartmeter/Widgets/Navigation/Settings/Settings.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<Navigation> {
  int currentPage = 0;

  void changePage(int page) {
    print(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
          child: currentPage == 0
              ? HomeScreen()
              : currentPage == 1
                  ? History()
                  : const Settings(),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

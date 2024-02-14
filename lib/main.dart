import 'package:flutter/material.dart';
import 'package:smartmeter/Widgets/Auth/Auth.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // home: Navigation(),
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Auth(),
    );
  }
}




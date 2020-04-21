import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quarantined/pages/home_screen.dart';
import 'package:quarantined/pages/no_connectivity_view.dart';

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();
const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;
  
  @override
  void initState() { 
    super.initState();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.push(MaterialPageRoute(
          builder: (BuildContext context) => NoConnectivityView()
        ));
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.push(MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen()
        ));
      }
      _previousResult = connectivityResult;
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: nav,
      title: 'quarantineAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: white,
        accentColor: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        accentColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}
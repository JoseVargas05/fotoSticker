// import 'package:clima/screens/experiment.dart';
// import 'package:clima/screens/maps.dart';
// import 'package:clima/screens/startPage.dart';
// import 'package:clima/screens/testPage.dart';
import 'package:clima/screens/AnimatedSplashScreen.dart';
import 'package:flutter/material.dart';

import 'screens/foto_edit.dart';
import 'screens/startPage.dart';
import 'screens/experiment.dart';
import 'screens/testPage.dart';
// import 'screens/maps.dart';
import 'screens/movable_widgets.dart';
import 'screens/code_form.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomeView(),
      // home: CodeForm(),
      home: AnimatedSplashScreen(),
      // home: FotoEditor(),
      // routes: {
      //   '/': (context) => StartPage(),
      //   '/testPage': (context) => TestPage(), does not look right
      //   '/exp': (context) => MainScreen(),
      //   '/mapsView': (context) => MapsScreen()
      // },
    );
  }
}


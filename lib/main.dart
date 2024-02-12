import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/LoginScreen.dart';
import 'package:flutter_application_1/Screen/MoviePage.dart';
import 'package:flutter_application_1/Screen/GenrePage.dart';
import 'package:flutter_application_1/Screen/TrendsPage.dart';
import 'package:flutter_application_1/Screen/YearSearchPage.dart';

import 'package:flutter_application_1/Screen/HomeScreen.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/movies': (context) => MoviePage(),
        '/genres': (context) => GenrePage(),
        '/trends': (context) => TrendsPage(),
        '/year_search': (context) => YearSearchPage(),
      },
    ),
  );
}
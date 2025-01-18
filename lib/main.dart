import 'package:flutter/material.dart';

import 'views/home_view.dart';

import 'views/playlist_view.dart';
import 'views/map_view.dart';
import 'views/login_signup_view.dart';

import 'views/event_view.dart';
import 'views/band_view.dart';

import 'data/test_data.dart';

import 'models/event.dart';
import 'models/band.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> testFirebaseCore() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() async {
  addEventsToBands(eventsList); //TODO: remove when using database.
  await testFirebaseCore();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/event': (context) => EventPage(),
        '/band': (context) => BandPage(),
        '/login_signup': (context) => LoginSignupPage()
      },
    );
  }
}

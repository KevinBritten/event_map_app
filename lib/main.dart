import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/user_stream.dart';

import 'views/home_view.dart';
import 'views/login_signup_view.dart';
import 'views/event_view.dart';
import 'views/add_band_view.dart';
import 'views/band_view.dart';
import 'views/add_venue_view.dart';

import 'data/test_data.dart';

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() async {
  addEventsToBands(eventsList); //TODO: remove when using database.
  await initFirebase();
  runApp(
    StreamProvider<Map<String, dynamic>?>.value(
      value: userStream(),
      initialData: null,
      child: MyApp(),
    ),
  );
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
        '/login_signup': (context) => LoginSignupPage(),
        '/add_band': (context) => AddBandPage(),
        '/add_venue': (context) => AddVenuePage()
      },
    );
  }
}

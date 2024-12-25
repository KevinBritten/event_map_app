// lib/data/dummy_data.dart

import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/band.dart';

// Dummy data for bands
final List<Band> bandsList = [
  Band(
    name: "The Rockers",
    currentSong: "Rock Anthem",
    events: [
      Event(
        venueName: "Rock Arena",
        dateTime: DateTime.now().add(Duration(days: 1)),
        latitude: 40.7128,
        longitude: -74.0060,
        price: 30,
      ),
      Event(
        venueName: "Jazz Club",
        dateTime: DateTime.now().add(Duration(days: 10)),
        latitude: 34.0522,
        longitude: -118.2437,
        price: 25,
      ),
    ],
  ),
  Band(
    name: "Jazz Masters",
    currentSong: "Smooth Jazz",
    events: [
      Event(
        venueName: "Jazz Lounge",
        dateTime: DateTime.now().add(Duration(days: 3)),
        latitude: 51.5074,
        longitude: -0.1278,
        price: 20,
      ),
    ],
  ),
  Band(
    name: "Pop Stars",
    currentSong: "Pop Hit",
    events: [
      Event(
        venueName: "Pop Stadium",
        dateTime: DateTime.now().add(Duration(days: 5)),
        latitude: 48.8566,
        longitude: 2.3522,
        price: 50,
      ),
    ],
  ),
  Band(
    name: "Indie Vibes",
    currentSong: "Indie Song",
    events: [
      Event(
        venueName: "Indie Bar",
        dateTime: DateTime.now().add(Duration(days: 7)),
        latitude: 41.8781,
        longitude: -87.6298,
        price: 15,
      ),
    ],
  ),
  Band(
    name: "Electronic Beats",
    currentSong: "EDM Track",
    events: [
      Event(
        venueName: "EDM Club",
        dateTime: DateTime.now().add(Duration(days: 4)),
        latitude: 35.6895,
        longitude: 139.6917,
        price: 40,
      ),
    ],
  ),
  Band(
    name: "Country Roads",
    currentSong: "Country Tune",
    events: [
      Event(
        venueName: "Country Hall",
        dateTime: DateTime.now().add(Duration(days: 6)),
        latitude: 39.7392,
        longitude: -104.9903,
        price: 20,
      ),
    ],
  ),
  Band(
    name: "Hip Hop Heroes",
    currentSong: "Hip Hop Groove",
    events: [
      Event(
        venueName: "Hip Hop Club",
        dateTime: DateTime.now().add(Duration(days: 2)),
        latitude: 34.0522,
        longitude: -118.2437,
        price: 25,
      ),
    ],
  ),
  Band(
    name: "Metal Heads",
    currentSong: "Metal Riff",
    events: [
      Event(
        venueName: "Metal Arena",
        dateTime: DateTime.now().add(Duration(days: 8)),
        latitude: 37.7749,
        longitude: -122.4194,
        price: 35,
      ),
    ],
  ),
];

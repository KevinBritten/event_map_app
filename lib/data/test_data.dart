import '../models/event.dart';
import '../models/band.dart';

// Existing bands
final bandRockers =
    Band(name: "The Rockers", currentSong: "Rock Anthem", events: []);
final bandJazzMasters =
    Band(name: "Jazz Masters", currentSong: "Smooth Jazz", events: []);
final bandPopStars =
    Band(name: "Pop Stars", currentSong: "Pop Hit", events: []);
final bandIndieVibes =
    Band(name: "Indie Vibes", currentSong: "Indie Song", events: []);
final bandElectronicBeats =
    Band(name: "Electronic Beats", currentSong: "EDM Track", events: []);
final bandCountryRoads =
    Band(name: "Country Roads", currentSong: "Country Tune", events: []);
final bandHipHopHeroes =
    Band(name: "Hip Hop Heroes", currentSong: "Hip Hop Groove", events: []);
final bandMetalHeads =
    Band(name: "Metal Heads", currentSong: "Metal Riff", events: []);

// Additional bands
final bandSoulSingers =
    Band(name: "Soul Singers", currentSong: "Soulful Ballad", events: []);
final bandBluesLegends =
    Band(name: "Blues Legends", currentSong: "Blues Vibe", events: []);
final bandSynthMasters =
    Band(name: "Synth Masters", currentSong: "Synth Wave", events: []);

// Events with updated bands
final List<Event> eventsList = [
  Event(
    venueName: "Rock Arena",
    dateTime: DateTime.now().add(Duration(days: 1)),
    latitude: 40.7128,
    longitude: -74.0060,
    price: 30,
    bands: [bandRockers, bandMetalHeads],
  ),
  Event(
    venueName: "Jazz Club",
    dateTime: DateTime.now().add(Duration(days: 10)),
    latitude: 34.0522,
    longitude: -118.2437,
    price: 25,
    bands: [bandRockers, bandBluesLegends],
  ),
  Event(
    venueName: "Jazz Lounge",
    dateTime: DateTime.now().add(Duration(days: 3)),
    latitude: 51.5074,
    longitude: -0.1278,
    price: 20,
    bands: [bandJazzMasters, bandSoulSingers],
  ),
  Event(
    venueName: "Pop Stadium",
    dateTime: DateTime.now().add(Duration(days: 5)),
    latitude: 48.8566,
    longitude: 2.3522,
    price: 50,
    bands: [bandPopStars, bandSynthMasters],
  ),
  Event(
    venueName: "Indie Bar",
    dateTime: DateTime.now().add(Duration(days: 7)),
    latitude: 41.8781,
    longitude: -87.6298,
    price: 15,
    bands: [bandIndieVibes, bandSoulSingers],
  ),
  Event(
    venueName: "EDM Club",
    dateTime: DateTime.now().add(Duration(days: 4)),
    latitude: 35.6895,
    longitude: 139.6917,
    price: 40,
    bands: [bandElectronicBeats, bandSynthMasters],
  ),
  Event(
    venueName: "Country Hall",
    dateTime: DateTime.now().add(Duration(days: 6)),
    latitude: 39.7392,
    longitude: -104.9903,
    price: 20,
    bands: [bandCountryRoads],
  ),
  Event(
    venueName: "Hip Hop Club",
    dateTime: DateTime.now().add(Duration(days: 2)),
    latitude: 34.0522,
    longitude: -118.2437,
    price: 25,
    bands: [bandHipHopHeroes, bandSynthMasters],
  ),
  Event(
    venueName: "Metal Arena",
    dateTime: DateTime.now().add(Duration(days: 8)),
    latitude: 37.7749,
    longitude: -122.4194,
    price: 35,
    bands: [bandMetalHeads, bandRockers],
  ),
];

// Associate events with their corresponding bands
final List<Band> bandsList = [
  bandRockers,
  bandJazzMasters,
  bandPopStars,
  bandIndieVibes,
  bandElectronicBeats,
  bandCountryRoads,
  bandHipHopHeroes,
  bandMetalHeads,
  bandSoulSingers,
  bandBluesLegends,
  bandSynthMasters,
];

void addEventsToBands(List<Event> eventsList) {
  for (final event in eventsList) {
    for (final band in event.bands) {
      band.events.add(event);
    }
  }
}

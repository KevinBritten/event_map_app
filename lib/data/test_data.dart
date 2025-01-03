import '../models/event.dart';
import '../models/band.dart';
import '../models/venue.dart';

// Venues
final venueRockArena = Venue(
  name: "Rock Arena",
  latitude: 40.7128,
  longitude: -74.0060,
);

final venueJazzClub = Venue(
  name: "Jazz Club",
  latitude: 34.0522,
  longitude: -118.2437,
);

final venueJazzLounge = Venue(
  name: "Jazz Lounge",
  latitude: 51.5074,
  longitude: -0.1278,
);

final venuePopStadium = Venue(
  name: "Pop Stadium",
  latitude: 48.8566,
  longitude: 2.3522,
);

final venueIndieBar = Venue(
  name: "Indie Bar",
  latitude: 41.8781,
  longitude: -87.6298,
);

final venueEDMClub = Venue(
  name: "EDM Club",
  latitude: 35.6895,
  longitude: 139.6917,
);

final venueCountryHall = Venue(
  name: "Country Hall",
  latitude: 39.7392,
  longitude: -104.9903,
);

final venueHipHopClub = Venue(
  name: "Hip Hop Club",
  latitude: 34.0522,
  longitude: -118.2437,
);

final venueMetalArena = Venue(
  name: "Metal Arena",
  latitude: 37.7749,
  longitude: -122.4194,
);

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

// Events with updated venues and bands
final List<Event> eventsList = [
  Event(
    title: "Rock Show",
    venue: venueRockArena,
    dateTime: DateTime.now().add(Duration(days: 1)),
    bands: [bandRockers, bandMetalHeads],
    price: 30,
  ),
  Event(
    title: "Jazz Show",
    venue: venueJazzClub,
    dateTime: DateTime.now().add(Duration(days: 10)),
    bands: [bandRockers, bandBluesLegends],
    price: 25,
  ),
  Event(
    title: "Jazz Nite",
    venue: venueJazzLounge,
    dateTime: DateTime.now().add(Duration(days: 3)),
    bands: [bandJazzMasters, bandSoulSingers],
    price: 20,
  ),
  Event(
    title: "Pop Show of the Month",
    venue: venuePopStadium,
    dateTime: DateTime.now().add(Duration(days: 5)),
    bands: [bandPopStars, bandSynthMasters],
    price: 50,
  ),
  Event(
    title: "Rock Show Vol.2",
    venue: venueIndieBar,
    dateTime: DateTime.now().add(Duration(days: 7)),
    bands: [bandIndieVibes, bandSoulSingers],
    price: 15,
  ),
  Event(
    title: "EDM Show",
    venue: venueEDMClub,
    dateTime: DateTime.now().add(Duration(days: 4)),
    bands: [bandElectronicBeats, bandSynthMasters],
    price: 40,
  ),
  Event(
    title: "Country Show",
    venue: venueCountryHall,
    dateTime: DateTime.now().add(Duration(days: 6)),
    bands: [bandCountryRoads],
    price: 20,
  ),
  Event(
    title: "Hop Hop Show",
    venue: venueHipHopClub,
    dateTime: DateTime.now().add(Duration(days: 2)),
    bands: [bandHipHopHeroes, bandSynthMasters],
    price: 25,
  ),
  Event(
    title: "Metal Show",
    venue: venueMetalArena,
    dateTime: DateTime.now().add(Duration(days: 8)),
    bands: [bandMetalHeads, bandRockers],
    price: 35,
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

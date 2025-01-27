// import '../models/event.dart';
// import '../models/band.dart';
// import '../models/venue.dart';

// // Venues
// final venueRockArena = Venue(
//   ownerUid: '1',
//   name: "Rock Arena",
//   latitude: 40.7128,
//   longitude: -74.0060,
// );

// final venueJazzClub = Venue(
//   ownerUid: '1',
//   name: "Jazz Club",
//   latitude: 34.0522,
//   longitude: -118.2437,
// );

// final venueJazzLounge = Venue(
//   ownerUid: '1',
//   name: "Jazz Lounge",
//   latitude: 51.5074,
//   longitude: -0.1278,
// );

// final venuePopStadium = Venue(
//   ownerUid: '1',
//   name: "Pop Stadium",
//   latitude: 48.8566,
//   longitude: 2.3522,
// );

// final venueIndieBar = Venue(
//   ownerUid: '1',
//   name: "Indie Bar",
//   latitude: 41.8781,
//   longitude: -87.6298,
// );

// final venueEDMClub = Venue(
//   ownerUid: '1',
//   name: "EDM Club",
//   latitude: 35.6895,
//   longitude: 139.6917,
// );

// final venueCountryHall = Venue(
//   ownerUid: '1',
//   name: "Country Hall",
//   latitude: 39.7392,
//   longitude: -104.9903,
// );

// final venueHipHopClub = Venue(
//   ownerUid: '1',
//   name: "Hip Hop Club",
//   latitude: 34.0522,
//   longitude: -118.2437,
// );

// final venueMetalArena = Venue(
//   ownerUid: '1',
//   name: "Metal Arena",
//   latitude: 37.7749,
//   longitude: -122.4194,
// );

// // Existing bands
// final bandRockers = Band(
//     ownerUid: '1',
//     name: "The Rockers",
//     currentSong: "Rock Anthem",
//     eventIds: []);
// final bandJazzMasters = Band(
//     ownerUid: '1',
//     name: "Jazz Masters",
//     currentSong: "Smooth Jazz",
//     eventIds: []);
// final bandPopStars = Band(
//     ownerUid: '1', name: "Pop Stars", currentSong: "Pop Hit", eventIds: []);
// final bandIndieVibes = Band(
//     ownerUid: '1',
//     name: "Indie Vibes",
//     currentSong: "Indie Song",
//     eventIds: []);
// final bandElectronicBeats = Band(
//     ownerUid: '1',
//     name: "Electronic Beats",
//     currentSong: "EDM Track",
//     eventIds: []);
// final bandCountryRoads = Band(
//     ownerUid: '1',
//     name: "Country Roads",
//     currentSong: "Country Tune",
//     eventIds: []);
// final bandHipHopHeroes = Band(
//     ownerUid: '1',
//     name: "Hip Hop Heroes",
//     currentSong: "Hip Hop Groove",
//     eventIds: []);
// final bandMetalHeads = Band(
//     ownerUid: '1',
//     name: "Metal Heads",
//     currentSong: "Metal Riff",
//     eventIds: []);

// // Additional bands
// final bandSoulSingers = Band(
//     ownerUid: '1',
//     name: "Soul Singers",
//     currentSong: "Soulful Ballad",
//     eventIds: []);
// final bandBluesLegends = Band(
//     ownerUid: '1',
//     name: "Blues Legends",
//     currentSong: "Blues Vibe",
//     eventIds: []);
// final bandSynthMasters = Band(
//     ownerUid: '1',
//     name: "Synth Masters",
//     currentSong: "Synth Wave",
//     eventIds: []);

// // Events with updated venues and bands
// final List<Event> eventsList = [
//   Event(
//     title: "Rock Show",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 1)),
//     bandIds: [bandRockers, bandMetalHeads],
//     price: 30,
//   ),
//   Event(
//     title: "Jazz Show",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 10)),
//     bandIds: [bandRockers, bandBluesLegends],
//     price: 25,
//   ),
//   Event(
//     title: "Jazz Nite",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 3)),
//     bandIds: [bandJazzMasters, bandSoulSingers],
//     price: 20,
//   ),
//   Event(
//     title: "Pop Show of the Month",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 5)),
//     bandIds: [bandPopStars, bandSynthMasters],
//     price: 50,
//   ),
//   Event(
//     title: "Rock Show Vol.2",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 7)),
//     bandIds: [bandIndieVibes, bandSoulSingers],
//     price: 15,
//   ),
//   Event(
//     title: "EDM Show",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 4)),
//     bandIds: [bandElectronicBeats, bandSynthMasters],
//     price: 40,
//   ),
//   Event(
//     title: "Country Show",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 6)),
//     bandIds: [bandCountryRoads],
//     price: 20,
//   ),
//   Event(
//     title: "Hop Hop Show",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 2)),
//     bandIds: [bandHipHopHeroes, bandSynthMasters],
//     price: 25,
//   ),
//   Event(
//     title: "Metal Show",
//     venueId: '1',
//     dateTime: DateTime.now().add(Duration(days: 8)),
//     bandIds: [bandMetalHeads, bandRockers],
//     price: 35,
//   ),
// ];

// // Associate events with their corresponding bands
// final List<Band> bandsList = [
//   bandRockers,
//   bandJazzMasters,
//   bandPopStars,
//   bandIndieVibes,
//   bandElectronicBeats,
//   bandCountryRoads,
//   bandHipHopHeroes,
//   bandMetalHeads,
//   bandSoulSingers,
//   bandBluesLegends,
//   bandSynthMasters,
// ];

// void addEventsToBands(List<Event> eventsList) {
//   for (final event in eventsList) {
//     for (final band in event.bands) {
//       band.events.add(event);
//     }
//   }
// }

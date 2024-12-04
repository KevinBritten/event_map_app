import 'package:flutter/material.dart';

class PlaylistView extends StatelessWidget {
  final List<Band> bands = [
    Band(
      name: "Band A",
      currentSong: "Song 1",
      events: [
        Event(
          venueName: "Venue A",
          dateTime: DateTime.now().add(Duration(days: 2)),
          latitude: 45.5017,
          longitude: -73.5673,
          price: 20,
        ),
      ],
    ),
    Band(
      name: "Band B",
      currentSong: "Song 2",
      events: [
        Event(
          venueName: "Venue B",
          dateTime: DateTime.now().add(Duration(days: 5)),
          latitude: 45.5088,
          longitude: -73.5618,
          price: 15,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bands.length,
      itemBuilder: (context, index) {
        final band = bands[index];
        final nextEvent = band.events.first;

        return ListTile(
          title: Text('${band.name} - ${band.currentSong}'),
          subtitle: Text(
              '${nextEvent.venueName} - ${nextEvent.dateTime.toLocal()} - \$${nextEvent.price ?? "Free"}'),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            // Navigate to map or show more details
          },
        );
      },
    );
  }
}

class Band {
  final String name;
  final String currentSong;
  final List<Event> events;

  Band({
    required this.name,
    required this.currentSong,
    required this.events,
  });
}

class Event {
  final String venueName;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final double? price;

  Event({
    required this.venueName,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    this.price,
  });
}

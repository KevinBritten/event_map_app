import 'package:flutter/material.dart';

import '../data/test_data.dart';
import '../models/event.dart';
import '../models/band.dart';
import '../models/venue.dart';

class PlaylistView extends StatelessWidget {
  final List<Band> bands;
  final int currentTrack;
  final Function(int) onTrackSelected;

  const PlaylistView({
    super.key,
    required this.bands,
    required this.currentTrack,
    required this.onTrackSelected,
  });
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
              '${nextEvent.venue.name} - ${nextEvent.dateTime.toLocal()} - \$${nextEvent.price ?? "Free"}'),
          tileColor:
              index == currentTrack ? Colors.blue.withOpacity(0.2) : null,
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/event', // The named route for EventPage
                arguments: nextEvent, // Pass the Event object as an argument
              );
            },
          ),
          onTap: () {
            onTrackSelected(index); // Notify parent widget of selection
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../models/band_event_venue.dart';

class PlaylistView extends StatelessWidget {
  final List<BandEventVenue> items;
  final int currentTrack;
  final Function(int) onTrackSelected;

  const PlaylistView({
    super.key,
    required this.items,
    required this.currentTrack,
    required this.onTrackSelected,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final nextEvent = item.event;
        final venue = item.venue;

        return ListTile(
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: item.band.name,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(
                        context,
                        '/band',
                        arguments: item.band,
                      );
                    },
                ),
                TextSpan(
                  text: ' - ${item.band.currentSong}',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          subtitle: Text(nextEvent != null
              ? '${nextEvent.title} - ${venue!.name} - ${nextEvent.dateTime.toLocal()} - \$${nextEvent.price ?? "Free"}'
              : 'No Upcoming Event'),
          tileColor:
              index == currentTrack ? Colors.blue.withOpacity(0.2) : null,
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/event',
                arguments: item,
              );
            },
          ),
          onTap: () {
            onTrackSelected(index);
          },
        );
      },
    );
  }
}

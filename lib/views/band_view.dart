import 'package:flutter/material.dart';
import '../models/band.dart';

class BandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Band band = ModalRoute.of(context)!.settings.arguments as Band;
    return Scaffold(
      appBar: AppBar(
        title: Text(band.name), // Band's name as the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Song: ${band.currentSong}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            Text(
              "Upcoming Shows",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: band.events.length,
                itemBuilder: (context, index) {
                  final event = band.events[index];
                  return ListTile(
                    title: Text(event.venue.name),
                    subtitle: Text("Date & Time: ${event.dateTime}"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/event', // Navigate to EventPage
                        arguments:
                            event, // Pass the selected event as an argument
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

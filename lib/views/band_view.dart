import 'package:flutter/material.dart';
import '../models/band.dart';

class BandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Band band = ModalRoute.of(context)!.settings.arguments as Band;
    return Scaffold(
      appBar: AppBar(
        title: Text(band.name),
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
                itemCount: band.eventIds.length,
                itemBuilder: (context, index) {
                  final event = band.eventIds[index];
                  return ListTile(
                    // title: Text(event.venue.name),
                    // subtitle: Text("Date & Time: ${event.dateTime}"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/event',
                        arguments: event,
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

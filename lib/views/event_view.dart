import 'package:flutter/material.dart';
import '../models/event.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.venue.name), // Display the venue name as the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Event Details",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text("Venue: ${event.venue.name}"),
            Text(
                "Location: (${event.venue.latitude}, ${event.venue.longitude})"),
            Text("Date & Time: ${event.dateTime}"),
            if (event.price != null)
              Text("Price: \$${event.price!.toStringAsFixed(2)}")
            else
              const Text("Price: Free"),
            const SizedBox(height: 24),
            Text(
              "Performing Bands",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: event.bands.length,
                itemBuilder: (context, index) {
                  final band = event.bands[index];
                  return ListTile(
                    title: Text(band.name),
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

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../models/band_event_venue.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BandEventVenue item =
        ModalRoute.of(context)!.settings.arguments as BandEventVenue;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.event!.title),
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
            Text("Venue: ${item.venue!.name}"),
            Text(
                "Location: (${item.venue!.latitude}, ${item.venue!.longitude})"),
            Text("Date & Time: ${item.event!.dateTime}"),
            if (item.event!.price != null)
              Text("Price: \$${item.event!.price!.toStringAsFixed(2)}")
            else
              const Text("Price: Free"),
            const SizedBox(height: 24),
            Text(
              "Performing Bands",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(item.band.name),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: event.bands.length,
            //     itemBuilder: (context, index) {
            //       final band = event.bands[index];
            //       return ListTile(
            //           title: RichText(
            //         text: TextSpan(
            //           text: band.name,
            //           style: const TextStyle(
            //             color: Colors.blue,
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.underline,
            //           ),
            //           recognizer: TapGestureRecognizer()
            //             ..onTap = () {
            //               Navigator.pushNamed(
            //                 context,
            //                 '/band',
            //                 arguments: band,
            //               );
            //             },
            //         ),
            //       ));
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

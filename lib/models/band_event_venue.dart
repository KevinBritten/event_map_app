import './band.dart';
import './event.dart';
import './venue.dart';

class BandEventVenue {
  final Band band;
  final Event? event;
  final Venue? venue;

  BandEventVenue({
    required this.band,
    required this.event,
    required this.venue,
  });
}

import 'band.dart';
import 'venue.dart';

class Event {
  final Venue venue; // Reference to a Venue object
  final DateTime dateTime;
  final double? price;
  final List<Band> bands;

  Event({
    required this.venue,
    required this.dateTime,
    required this.bands,
    this.price,
  });
}

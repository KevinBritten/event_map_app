import 'band.dart';
import 'venue.dart';

class Event {
  final String? id;
  final String title;
  final String venueId;
  final DateTime dateTime;
  final double? price;
  final List<String> bandIds;

  Event({
    this.id,
    required this.title,
    required this.venueId,
    required this.dateTime,
    required this.bandIds,
    this.price,
  });
}

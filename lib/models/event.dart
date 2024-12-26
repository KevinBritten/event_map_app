import 'band.dart';

class Event {
  final String venueName;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final double? price;
  final List<Band> bands;

  Event({
    required this.venueName,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.bands,
    this.price,
  });
}

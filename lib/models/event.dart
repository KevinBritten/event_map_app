class Event {
  final String venueName;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final double? price;

  Event({
    required this.venueName,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    this.price,
  });
}

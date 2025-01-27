class Venue {
  final String? id;
  final String ownerUid;
  final String name;
  final double latitude;
  final double longitude;

  Venue({
    this.id,
    required this.ownerUid,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Venue && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

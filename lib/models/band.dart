import 'event.dart';

class Band {
  final String? id;
  final String ownerUid;
  final String name;
  final String currentSong;
  final List<String> eventIds;

  Band({
    this.id,
    required this.ownerUid,
    required this.name,
    required this.currentSong,
    required this.eventIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Band && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

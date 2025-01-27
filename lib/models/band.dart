import 'event.dart';

class Band {
  final String ownerUid;
  final String name;
  final String currentSong;
  final List<Event> events;

  Band({
    required this.ownerUid,
    required this.name,
    required this.currentSong,
    required this.events,
  });
}

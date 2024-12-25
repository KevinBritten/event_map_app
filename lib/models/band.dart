import 'event.dart';

class Band {
  final String name;
  final String currentSong;
  final List<Event> events;

  Band({
    required this.name,
    required this.currentSong,
    required this.events,
  });
}

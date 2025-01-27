import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';
import '../models/band.dart';
import '../models/venue.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addEvent(Event event) async {
    try {
      final eventData = {
        'title': event.title,
        'venueId': event.venueId,
        'dateTime': event.dateTime.toIso8601String(),
        'price': event.price,
        'bandIds': event.bandIds
      };

      DocumentReference docRef =
          await _firestore.collection('events').add(eventData);
      print("Created new event: ${event.title} (ID: ${docRef.id})");
      return docRef.id;
    } catch (e) {
      print("Error adding event: $e");
      throw Exception("Failed to add event");
    }
  }

  Future<List<Event>> fetchEvents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('events').get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Event(
            id: doc.id,
            title: data['title'],
            venueId: data['venueId'],
            dateTime: DateTime.parse(data['dateTime']),
            price: data['price']?.toDouble(),
            bandIds: data['bandIds'] as List<String>);
      }).toList();
    } catch (e) {
      print("Error fetching events: $e");
      throw Exception("Failed to fetch events");
    }
  }

  Future<Event?> getEventById(String eventId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('events').doc(eventId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return Event(
          id: docSnapshot.id,
          title: data['title'],
          venueId: data['venueId'],
          dateTime: DateTime.parse(data['dateTime']),
          price: data['price']?.toDouble(),
          bandIds: List<String>.from(data['bandIds']),
        );
      } else {
        print("No event found with ID: $eventId");
        return null;
      }
    } catch (e) {
      print("Error fetching event by ID: $e");
      throw Exception("Failed to fetch event");
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
      print("Deleted event: $eventId");
    } catch (e) {
      print("Error deleting event: $e");
      throw Exception("Failed to delete event");
    }
  }
}

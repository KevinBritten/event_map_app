import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/venue.dart';

class VenueService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Venue?> getVenueById(String venueId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('venues').doc(venueId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return Venue(
          id: docSnapshot.id,
          ownerUid: data['ownerUid'],
          name: data['name'],
          latitude: data['latitude'],
          longitude: data['longitude'],
        );
      } else {
        print("No venue found with ID: $venueId");
        return null;
      }
    } catch (e) {
      print("Error fetching venue by ID: $e");
      throw Exception("Failed to fetch venue");
    }
  }

  Future<List<Venue>> getAllVenues() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('venues').get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Venue(
          id: doc.id,
          ownerUid: data['ownerUid'],
          name: data['name'],
          latitude: data['latitude'],
          longitude: data['longitude'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching venues: $e");
      throw Exception("Failed to fetch venues");
    }
  }

  Future<void> saveVenue(Venue venue) async {
    try {
      final venueData = {
        'ownerUid': venue.ownerUid,
        'name': venue.name,
        'latitude': venue.latitude,
        'longitude': venue.longitude,
      };

      if (venue.id != null) {
        await _firestore.collection('venues').doc(venue.id).set(venueData);
        print("Updated venue: ${venue.name} (ID: ${venue.id})");
      } else {
        DocumentReference docRef =
            await _firestore.collection('venues').add(venueData);
        print("Created new venue: ${venue.name} (ID: ${docRef.id})");
      }
    } catch (e) {
      print("Error saving venue: $e");
      throw Exception("Failed to save venue");
    }
  }
}

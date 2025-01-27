import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/band.dart';
import '../models/event.dart';

class BandService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Band>> fetchBands() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('bands').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Band(
          id: doc.id,
          name: data['name'],
          currentSong: data['currentSong'],
          eventIds: List<String>.from(data['eventIds'] ?? []),
          ownerUid: data['ownerUid'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching bands: $e");
      throw Exception("Failed to fetch bands");
    }
  }

  Future<Band?> getBandById(String bandId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('bands').doc(bandId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return Band(
          id: docSnapshot.id,
          name: data['name'],
          currentSong: data['currentSong'],
          eventIds: List<String>.from(data['eventIds'] ?? []),
          ownerUid: data['ownerUid'],
        );
      } else {
        print("No band found with ID: $bandId");
        return null;
      }
    } catch (e) {
      print("Error fetching band by ID: $e");
      throw Exception("Failed to fetch band");
    }
  }

  Future<void> saveBand(Band band) async {
    try {
      final bandData = {
        'name': band.name,
        'currentSong': band.currentSong,
        'eventIds': band.eventIds,
        'ownerUid': band.ownerUid,
      };

      if (band.id != null) {
        await _firestore.collection('bands').doc(band.id).set(bandData);
        print("Updated band: ${band.name} (ID: ${band.id})");
      } else {
        DocumentReference docRef =
            await _firestore.collection('bands').add(bandData);
        print("Created new band: ${band.name} (ID: ${docRef.id})");
      }
    } catch (e) {
      print("Error saving band: $e");
      throw Exception("Failed to save band");
    }
  }

  Future<void> addEventToBand(Band band, String eventId) async {
    try {
      DocumentReference bandRef = _firestore.collection('bands').doc(band.id);

      await bandRef.update({
        'eventIds': FieldValue.arrayUnion([eventId]),
      });

      print("Updated ${band.name} (id: ${band.id}) with event $eventId");
    } catch (e) {
      print("Error updating band: $e");
      throw Exception("Failed to update band");
    }
  }
}

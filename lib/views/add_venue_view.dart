import 'package:event_map_app/services/venue_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../services/event_service.dart';
import '../models/venue.dart';

class AddVenuePage extends StatefulWidget {
  @override
  _AddVenuePageState createState() => _AddVenuePageState();
}

class _AddVenuePageState extends State<AddVenuePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addVenue(String ownerUid) async {
    final String name = _nameController.text.trim();
    final String latitudeInput = _latitudeController.text.trim();
    final String longitudeInput = _longitudeController.text.trim();

    if (name.isEmpty || latitudeInput.isEmpty || longitudeInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    double? latitude;
    double? longitude;

    try {
      latitude = double.parse(latitudeInput);
      longitude = double.parse(longitudeInput);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Latitude and Longitude must be valid numbers.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Venue venue = new Venue(
          ownerUid: ownerUid,
          name: name,
          latitude: latitude,
          longitude: longitude);
      await VenueService().saveVenue(venue);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Venue added successfully!')));

      _nameController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add venue: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? user = context.watch<Map<String, dynamic>?>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Venue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Venue Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _latitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _longitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _addVenue(user!['uid']);
                    },
                    child: Text('Add Venue'),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}

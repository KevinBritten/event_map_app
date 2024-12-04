import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the Google Maps API key from .env
    final String? googleMapsApiKey = dotenv.env['MAPS_API_KEY'];

    if (googleMapsApiKey == null) {
      return Center(
        child: Text(
          'Error: Missing Google Maps API Key',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }

    // Initial Google Maps widget (you can customize this further)
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(45.5017, -73.5673), // Default coordinates (Montreal)
        zoom: 12,
      ),
    );
  }
}

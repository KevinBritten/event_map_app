import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initial Google Maps widget (you can customize this further)
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(45.5017, -73.5673), // Default coordinates (Montreal)
        zoom: 12,
      ),
    );
  }
}

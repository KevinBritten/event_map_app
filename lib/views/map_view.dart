// lib/views/map_view.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/test_data.dart';
import '../models/event.dart';
import '../models/band.dart';
import '../models/venue.dart';

class MapView extends StatefulWidget {
  final Event? event;

  const MapView({Key? key, this.event}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _addMarker(widget.event!);
    }
  }

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.event != oldWidget.event && widget.event != null) {
      _addMarker(widget.event!);
      _moveCamera(widget.event!);
    }
  }

  void _addMarker(Event event) {
    final marker = Marker(
      markerId: MarkerId(event.venue.name),
      position: LatLng(event.venue.latitude, event.venue.longitude),
      infoWindow: InfoWindow(
        title: event.venue.name,
        snippet: '${event.dateTime.toLocal()} - \$${event.price ?? "Free"}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );

    setState(() {
      _markers.clear(); // Remove existing markers
      _markers.add(marker);
    });
  }

  void _moveCamera(Event event) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(event.venue.latitude, event.venue.longitude),
          zoom: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(45.5017, -73.5673), // Default coordinates (Montreal)
        zoom: 12,
      ),
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        if (widget.event != null) {
          _moveCamera(widget.event!);
        }
      },
    );
  }
}

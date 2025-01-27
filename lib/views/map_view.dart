import 'package:event_map_app/models/band_event_venue.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/test_data.dart';
import '../models/event.dart';
import '../models/band.dart';
import '../models/venue.dart';

class MapView extends StatefulWidget {
  final BandEventVenue item;

  const MapView({Key? key, required this.item}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _addMarker(widget.item!);
    }
  }

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item != oldWidget.item && widget.item != null) {
      _addMarker(widget.item!);
      _moveCamera(widget.item!.venue as Venue);
    }
  }

  void _addMarker(BandEventVenue item) {
    final marker = Marker(
      markerId: MarkerId(item.venue!.name),
      position: LatLng(item.venue!.latitude, item.venue!.longitude),
      infoWindow: InfoWindow(
        title: item.venue!.name,
        snippet:
            '${item.event!.dateTime.toLocal()} - \$${item.event!.price ?? "Free"}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );

    setState(() {
      _markers.clear();
      _markers.add(marker);
    });
  }

  void _moveCamera(Venue venue) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(venue.latitude, venue.longitude),
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
        if (widget.item != null) {
          _moveCamera(widget.item.venue!);
        }
      },
    );
  }
}

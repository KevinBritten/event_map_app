import '../models/band.dart';
import '../models/event.dart';
import '../models/venue.dart';
import '../models/band_event_venue.dart';

import '../services/band_service.dart';
import '../services/event_service.dart';
import '../services/venue_service.dart';

class BandEventVenueService {
  Future<List<BandEventVenue>> getBandEventVenueList() async {
    try {
      List<Band> bands = await BandService().fetchBands();
      List<BandEventVenue> bandEventVenueList = [];

      for (Band band in bands) {
        Event? event = await EventService()
            .getEventById(band.eventIds.isNotEmpty ? band.eventIds.first : '');
        if (event == null) continue;

        Venue? venue = await VenueService().getVenueById(event.venueId);
        if (venue == null) continue;

        bandEventVenueList
            .add(BandEventVenue(band: band, event: event, venue: venue));
      }

      return bandEventVenueList;
    } catch (e) {
      print("Error fetching BandEventVenue list: $e");
      throw Exception("Failed to fetch data");
    }
  }
}

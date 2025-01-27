import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/band.dart';
import '../models/venue.dart';
import '../services/band_service.dart';
import '../services/event_service.dart';
import '../services/venue_service.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime? _selectedDate;
  Venue? _selectedVenue;
  List<Band?> _selectedBands = [null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Event Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              FutureBuilder<List<Venue>>(
                future: VenueService().getAllVenues(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final venues = snapshot.data!;
                  return DropdownButtonFormField<Venue>(
                    decoration: InputDecoration(labelText: "Select Venue"),
                    value: _selectedVenue,
                    items: venues
                        .map((venue) => DropdownMenuItem(
                              value: venue,
                              child: Text(venue.name),
                            ))
                        .toList(),
                    onChanged: (venue) {
                      setState(() {
                        _selectedVenue = venue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a venue";
                      }
                      return null;
                    },
                  );
                },
              ),
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? "Select Date & Time"
                      : _selectedDate!.toString(),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price (Optional)"),
              ),
              for (int i = 0; i < 4; i++)
                FutureBuilder<List<Band>>(
                  future:
                      BandService().fetchBands(), // Fetch bands from database
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final bands = snapshot.data!;
                    return DropdownButtonFormField<Band>(
                      decoration:
                          InputDecoration(labelText: "Select Band ${i + 1}"),
                      value: _selectedBands[i],
                      items: bands
                          .map((band) => DropdownMenuItem(
                                value: band,
                                child: Text(band.name),
                              ))
                          .toList(),
                      onChanged: (band) {
                        setState(() {
                          _selectedBands[i] = band;
                        });
                      },
                    );
                  },
                ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Create Event"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final title = _titleController.text;
      final price = double.tryParse(_priceController.text);

      if (_selectedVenue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a venue")),
        );
        return;
      }

      final bandIds = _selectedBands
          .whereType<Band>()
          .map((band) => band.id)
          .where((id) => id != null)
          .cast<String>()
          .toList();

      final event = Event(
        title: title,
        venueId: _selectedVenue!.id!,
        dateTime: _selectedDate!,
        price: price,
        bandIds: bandIds.isNotEmpty ? bandIds : [],
      );

      String eventId = await EventService().addEvent(event);

      for (final band in _selectedBands.whereType<Band>()) {
        await BandService().addEventToBand(band, eventId);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Event created successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out all required fields")),
      );
    }
  }
}

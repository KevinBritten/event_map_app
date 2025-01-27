import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AddBandPage extends StatefulWidget {
  @override
  _AddBandPageState createState() => _AddBandPageState();
}

class _AddBandPageState extends State<AddBandPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currentSongController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addBand(String ownerUid) async {
    final String name = _nameController.text.trim();
    final String currentSong = _currentSongController.text.trim();

    if (name.isEmpty || currentSong.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('bands').add({
        'ownerUid': ownerUid,
        'name': name,
        'currentSong': currentSong,
        'eventIds': [],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Band added successfully!')),
      );

      _nameController.clear();
      _currentSongController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add band: $e')),
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
        title: Text('Add Band'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Band Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _currentSongController,
              decoration: InputDecoration(
                labelText: 'Current Song',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _addBand(user!['uid']);
                    },
                    child: Text('Add Band'),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentSongController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

import 'views/playlist_view.dart';
import 'views/map_view.dart';

import 'data/test_data.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bands = bandsList;
  int _viewIndex = 0;
  int _trackIndex = 0;
  bool isPlaying = false;

  List<Widget> _views() {
    return [
      PlaylistView(
        bands: bands,
        currentTrack: _trackIndex,
        onTrackSelected: (index) {
          setState(() {
            _trackIndex = index;
          });
        },
      ),
      MapView(event: bands[_trackIndex].events[0]),
    ];
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _next() {
    setState(() {
      _trackIndex = (_trackIndex + 1) % bandsList.length;
    });
  }

  void _previous() {
    setState(() {
      _trackIndex = (_trackIndex - 1 + bandsList.length) % bandsList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Finder'),
      ),
      body: Column(
        children: [
          Expanded(child: _views()[_viewIndex]),
          _buildMediaControls(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _viewIndex,
        onTap: (index) {
          setState(() {
            _viewIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
      ),
    );
  }

  Widget _buildMediaControls() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous),
            iconSize: 30.0,
            onPressed: _previous,
          ),
          IconButton(
            icon: Icon(isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled),
            iconSize: 50.0,
            onPressed: _togglePlayPause,
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            iconSize: 30.0,
            onPressed: _next,
          ),
        ],
      ),
    );
  }
}

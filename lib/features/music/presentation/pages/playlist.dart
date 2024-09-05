import 'package:flutter/material.dart';
import 'package:mind_care/features/music/presentation/pages/music_player.dart';
import 'package:mind_care/theme.dart';

class Playlist extends StatelessWidget {
  Playlist({super.key});

  final List<Map<String, String>> songs = [
    {
      'title': 'demo1 title',
      'artist': 'demo1 artist',
      'thumbnail': 'assets/images/meditation.png',
    },
    {
      'title': 'demo2 title',
      'artist': 'demo2 artist',
      'thumbnail': 'assets/images/meditation.png',
    },
    {
      'title': 'demo3 title',
      'artist': 'demo3 artist',
      'thumbnail': 'assets/images/meditation.png',
    },
    {
      'title': 'demo4 title',
      'artist': 'demo4 artist',
      'thumbnail': 'assets/images/meditation.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chill Playlist",
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        backgroundColor: DefaultColors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: Container(
        color: DefaultColors.white,
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(songs[index]['thumbnail']!),
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                size: 15.0,
              ),
              title: Text(
                songs[index]['title']!,
                style: AppTheme.lightTheme.textTheme.labelMedium,
              ),
              subtitle: Text(
                songs[index]['artist']!,
                style: AppTheme.lightTheme.textTheme.labelSmall,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MusicPlayer()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

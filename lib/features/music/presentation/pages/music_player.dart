import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mind_care/features/music/domain/entities/song.dart';
import 'package:mind_care/theme.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key, required this.song});

  final Song song;

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  bool isLooping = false;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.song.songLink);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seekBackwards() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  void seekForkwards() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    _audioPlayer.seek(newPosition);
  }

  void seekRestart() {
    _audioPlayer.seek(Duration.zero);
  }

  void toggleLoop() {
    setState(() {
      isLooping = !isLooping;
      _audioPlayer.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset("assets/images/down_arrow.png")),
        actions: [
          Image.asset("assets/images/transcript_icon.png"),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: DefaultColors.white,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/meditation.png",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            // Text Title
            Text(
              widget.song.title,
              style: AppTheme.lightTheme.textTheme.labelLarge,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            // Text Author name
            Text(
              "By:${widget.song.author}",
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
            const Spacer(),
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = _audioPlayer.duration ?? Duration.zero;

                return ProgressBar(
                  progress: position,
                  total: total,
                  baseBarColor: DefaultColors.lightpink,
                  thumbColor: DefaultColors.pink,
                  progressBarColor: DefaultColors.pink,
                  onSeek: (duration) {
                    _audioPlayer.seek(duration);
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shuffle,
                    color: DefaultColors.pink,
                  ),
                ),
                IconButton(
                  onPressed: seekBackwards,
                  icon: const Icon(
                    Icons.skip_previous,
                    color: DefaultColors.pink,
                  ),
                ),
                StreamBuilder(
                  stream: _audioPlayer.playerStateStream,
                  builder: (context, snapshot) {
                    final playerSate = snapshot.data;
                    final processingState =
                        playerSate?.processingState ?? ProcessingState.idle;
                    final playing = playerSate?.playing ?? false;

                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: DefaultColors.pink,
                        ),
                      );
                    } else if (!playing) {
                      return IconButton(
                        onPressed: togglePlayPause,
                        iconSize: 80.0,
                        icon: const Icon(
                          Icons.play_circle_filled,
                          color: DefaultColors.pink,
                        ),
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        onPressed: togglePlayPause,
                        iconSize: 80.0,
                        icon: const Icon(
                          Icons.pause_circle_filled,
                          color: DefaultColors.pink,
                        ),
                      );
                    } else {
                      return IconButton(
                        onPressed: seekRestart,
                        iconSize: 80.0,
                        icon: const Icon(
                          Icons.replay_circle_filled,
                          color: DefaultColors.pink,
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  onPressed: seekForkwards,
                  icon: const Icon(
                    Icons.skip_next,
                    color: DefaultColors.pink,
                  ),
                ),
                IconButton(
                  onPressed: toggleLoop,
                  icon: Icon(
                    isLooping ? Icons.repeat_one : Icons.repeat,
                    color: DefaultColors.pink,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

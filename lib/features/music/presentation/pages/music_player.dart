import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/theme.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

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
              "10 Minute meditation music",
              style: AppTheme.lightTheme.textTheme.labelLarge,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            // Text Author name
            Text(
              "By:Sahas Shakya",
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
            const Spacer(),

            // Progress Bar
            ProgressBar(
              progress: const Duration(minutes: 4, seconds: 32),
              total: const Duration(minutes: 10, seconds: 17),
              baseBarColor: DefaultColors.lightpink,
              thumbColor: DefaultColors.pink,
              progressBarColor: DefaultColors.pink,
              onSeek: (duration) {
                print("User selected a new item : $duration");
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous,
                    color: DefaultColors.pink,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 80.0,
                  icon: const Icon(
                    Icons.pause_circle_filled,
                    color: DefaultColors.pink,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next,
                    color: DefaultColors.pink,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.repeat,
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

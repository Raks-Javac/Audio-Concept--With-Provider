import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  void initState() {
    context.read<MusicProvider>().playerInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(builder: (context, musicProvider, _) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Music Page"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
                min: 0,
                max: musicProvider.musicDuration.inSeconds.toDouble(),
                value: musicProvider.musicPosition.inSeconds.toDouble(),
                onChanged: (value) {
                  musicProvider.sliderPosition(value);
                }),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  musicProvider.pausePlayAudio();
                },
                icon: Icon(
                  musicProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

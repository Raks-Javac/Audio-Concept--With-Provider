import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

const String musicPath = "alert.mp3";
List<SingleChildWidget> providerList = [
  ChangeNotifierProvider(create: (context) => MusicProvider()),
];

class MusicProvider extends ChangeNotifier {
  final _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration musicDuration = Duration.zero;
  Duration musicPosition = Duration.zero;

  playerInitState() {
    //listen to states: playing,paused,stopped
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    //listen to audio duration
    _audioPlayer.onDurationChanged.listen((state) {
      musicDuration = state;
      notifyListeners();
    });

    //listen to audio position
    _audioPlayer.onPositionChanged.listen((event) {
      musicPosition = event;
      notifyListeners();
    });
  }



//handles pause and play in the UI
  pausePlayAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(musicPath));
    }
  }

  //handles position
  sliderPosition(double value) async {
    final positon = Duration(seconds: value.toInt());
    await _audioPlayer.seek(positon);

    //optional : Play audio if paused
    // await _audioPlayer.resume();
  }

  // //set music audio on init

  // Future setAudio() async {
  //   //repeast song when completed to loop again , stop , currently on loop
  //   _audioPlayer.setReleaseMode(ReleaseMode.loop);

  //   final player = AudioCache(prefix: '/assets');
  //   final url = await player.load(musicPath);
  //   _audioPlayer.setSourceAsset(url.path);
  // }

  // disposeController() {
  //   _audioPlayer.dispose();
  // }
}

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final _instance = AudioController._();
  AudioController._() {
    log('inside audio controller');
    initializeAudioPlayer();
  }

  void initializeAudioPlayer() async {
    await tap.setSource(AssetSource('sfx/click.wav'));
    await tick.setSource(AssetSource('sfx/tick.wav'));
    await done.setSource(AssetSource('sfx/done.wav'));
    await error.setSource(AssetSource('sfx/error.wav'));
    await correct.setSource(AssetSource('sfx/correct.wav'));

    await correct.setVolume(0.2);
    await error.setVolume(0.2);

    await tap.setReleaseMode(ReleaseMode.stop);
    await tick.setReleaseMode(ReleaseMode.stop);
    await done.setReleaseMode(ReleaseMode.stop);
    await error.setReleaseMode(ReleaseMode.stop);
    await correct.setReleaseMode(ReleaseMode.stop);
  }

  factory AudioController() => _instance;
  AudioPlayer tick = AudioPlayer();
  AudioPlayer tap = AudioPlayer();
  AudioPlayer done = AudioPlayer();
  AudioPlayer error = AudioPlayer();
  AudioPlayer correct = AudioPlayer();
}

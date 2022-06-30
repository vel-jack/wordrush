import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final _instance = AudioController._();
  AudioController._() {
    log('inside audio controller');
    tap.setSource(AssetSource('sfx/click.wav'));
    tick.setSource(AssetSource('sfx/tick.wav'));
    done.setSource(AssetSource('sfx/done.wav'));
    error.setSource(AssetSource('sfx/error.wav'));
    correct.setSource(AssetSource('sfx/correct.wav'));
    correct.setVolume(0.2);
    error.setVolume(0.2);
  }
  factory AudioController() => _instance;
  AudioPlayer tick = AudioPlayer();
  AudioPlayer tap = AudioPlayer();
  AudioPlayer done = AudioPlayer();
  AudioPlayer error = AudioPlayer();
  AudioPlayer correct = AudioPlayer();
}

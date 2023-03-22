import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerAudioController {
  final player = AudioPlayer();

  final playerEnumNotifier = ValueNotifier<PlayerEnum>(PlayerEnum.loading);

  Duration totalDurationAudio = Duration.zero;
  final currentDurationAudioNotifier = ValueNotifier<Duration>(Duration.zero);
  Future<void> setUrlAudio(String urlAudio) async {
    final durationAudio = await player.setUrl(urlAudio);
    if (durationAudio != null) {
      totalDurationAudio = durationAudio;
    }
    _initializeAudio();
  }

  Future<void> setLocalPathAudio(String pathAudio) async {
    final durationAudio = await player.setUrl(pathAudio);
    if (durationAudio != null) {
      totalDurationAudio = durationAudio;
    }
    _initializeAudio();
  }

  void _initializeAudio() {
    player.positionStream.listen((currenteAudio) {
      currentDurationAudioNotifier.value = currenteAudio;
    });

    player.playerStateStream.listen((state) {
      if (!state.playing) {
        playerEnumNotifier.value = PlayerEnum.pause;
      } else {
        switch (state.processingState) {
          case ProcessingState.loading:
            playerEnumNotifier.value = PlayerEnum.loading;
            break;
          case ProcessingState.buffering:
            playerEnumNotifier.value = PlayerEnum.loading;
            break;
          case ProcessingState.idle:
            playerEnumNotifier.value = PlayerEnum.loading;
            break;
          case ProcessingState.ready:
            playerEnumNotifier.value = PlayerEnum.play;
            player.play();
            break;
          case ProcessingState.completed:
            player.seek(Duration.zero);
            player.pause();
            break;
        }
      }
    });
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> seek(double seconds) async {
    await player.seek(Duration(seconds: seconds.toInt()));
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> add() async {
    await player
        .seek(currentDurationAudioNotifier.value + const Duration(seconds: 10));
  }

  Future<void> subtract() async {
    await player
        .seek(currentDurationAudioNotifier.value - const Duration(seconds: 10));
  }

  void dispose() {
    player.dispose();
  }
}

enum PlayerEnum {
  loading,
  play,
  pause,
}

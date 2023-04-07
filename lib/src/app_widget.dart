import 'package:flutter/material.dart';
import 'package:pock_audio_player/src/player/player_audio.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Poc Player de Audio',
      debugShowCheckedModeBanner: false,
    
      home: PlayerAudio(),
    );
  }
}

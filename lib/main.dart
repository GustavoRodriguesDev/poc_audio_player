import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'player_audio_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PlayerAudioController playerAudioController = PlayerAudioController();
  @override
  void initState() {
    super.initState();
    playerAudioController.setUrlAudio(
        'https://elevagroloja-homolog.leobr.net//images/conteudos/podcast/midias/podcast1409.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: 400,
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                ),
                Column(
                  children: [
                    ValueListenableBuilder<Duration>(
                        valueListenable:
                            playerAudioController.currentDurationAudioNotifier,
                        builder: (_, value, __) {
                          return Slider(
                              min: 0,
                              value: value.inSeconds.toDouble(),
                              max: playerAudioController
                                  .totalDurationAudio.inSeconds
                                  .toDouble(),
                              onChanged: (value) {});
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: playerAudioController.subtract,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        ValueListenableBuilder<PlayerEnum>(
                            valueListenable:
                                playerAudioController.playerEnumNotifier,
                            builder: (context, value, child) {
                              if (value == PlayerEnum.loading) {
                                return const CircularProgressIndicator();
                              }
                              if (value == PlayerEnum.play) {
                                return IconButton(
                                  onPressed: () async {
                                    await playerAudioController.pause();
                                  },
                                  icon: const Icon(Icons.stop, size: 25),
                                );
                              }

                              return IconButton(
                                  onPressed: () async {
                                    await playerAudioController.play();
                                  },
                                  icon: const Icon(Icons.play_arrow, size: 25));
                            }),
                        IconButton(
                          onPressed: playerAudioController.add,
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../player_audio_controller.dart';
import 'widget/player_button_widget.dart';
import 'widget/progressbar_widget.dart';

class PlayerAudio extends StatefulWidget {
  const PlayerAudio({super.key});

  @override
  State<PlayerAudio> createState() => _PlayerAudioState();
}

class _PlayerAudioState extends State<PlayerAudio> {
  late PlayerAudioController playerAudioController;

  @override
  void initState() {
    super.initState();
    playerAudioController = PlayerAudioController();
    playerAudioController.setAsssetAudio('assets/audio/metallica_one.mp3');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xFF65687B),
        ),
        title: const Text(
          'Tocando agora',
          style: TextStyle(
            color: Color(0xFF65687B),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Icon(
              Icons.playlist_add,
              color: Color(0xFF65687B),
            ),
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 250,
              width: 250,
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/image/capa.jpeg'),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'One',
                  style: GoogleFonts.robotoMono(
                      color: const Color(0xFF594DA1),
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
                const SizedBox(height: 14),
                Text(
                  'Metallica',
                  style: GoogleFonts.robotoMono(
                      color: const Color(0xFF9DA1AF),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                const SizedBox(height: 14),
                const Icon(
                  Icons.favorite,
                  color: Colors.orange,
                ),
              ],
            ),
            Column(
              children: [
                ValueListenableBuilder(
                    valueListenable:
                        playerAudioController.currentDurationAudioNotifier,
                    builder: (_, progress, ___) {
                      return ProgrssbarWidget(
                        progress: progress,
                        total: playerAudioController.totalDurationAudio,
                        onSeek: (value) {
                          playerAudioController.seek(value);
                        },
                      );
                    }),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.repeat,
                      color: Color(0xFF65687B),
                    ),
                    PlayerButtonWidget(
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Color(0xFF65687B),
                      ),
                      size: 50,
                      onTap: () {},
                    ),
                    ValueListenableBuilder(
                        valueListenable:
                            playerAudioController.playerEnumNotifier,
                        builder: (_, buttonState, ___) {
                          if (buttonState == PlayerEnum.loading) {
                            PlayerButtonWidget(
                              icon: const CircularProgressIndicator(
                                  color: Colors.orange),
                              onTap: () {},
                            );
                          }
                          if (buttonState == PlayerEnum.play) {
                            return PlayerButtonWidget(
                              icon: const Icon(
                                Icons.stop,
                                color: Colors.orange,
                                size: 40,
                              ),
                              onTap: () async {
                                await playerAudioController.pause();
                              },
                            );
                          }
                          return PlayerButtonWidget(
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.orange,
                              size: 40,
                            ),
                            onTap: () {
                              playerAudioController.play();
                            },
                          );
                        }),
                    PlayerButtonWidget(
                      icon: const Icon(
                        Icons.skip_next,
                        color: Color(0xFF65687B),
                      ),
                      size: 50,
                      onTap: () {},
                    ),
                    const Icon(
                      Icons.shuffle,
                      color: Color(0xFF65687B),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

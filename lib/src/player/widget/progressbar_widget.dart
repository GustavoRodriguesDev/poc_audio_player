import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgrssbarWidget extends StatelessWidget {
  final Duration progress;
  final Duration total;
  final Function(Duration)? onSeek;

  const ProgrssbarWidget({
    super.key,
    required this.onSeek,
    required this.progress,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: progress,
      total: total,
      onSeek: onSeek,
      timeLabelLocation: TimeLabelLocation.above,
      timeLabelType: TimeLabelType.remainingTime,
      timeLabelPadding: 10,
      timeLabelTextStyle: GoogleFonts.robotoMono(
        color: const Color(0xFF9DA1AF),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      progressBarColor: Colors.orange,
      baseBarColor: Colors.grey.withOpacity(.2),
      thumbColor: Colors.orange,
    );
  }
}

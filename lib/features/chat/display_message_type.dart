import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/common/video_player_view.dart';
import '../../core/enums/message_enums.dart';

class DisplayMessageType extends StatefulWidget {
  final String message;
  final MessageEnum type;

  const DisplayMessageType({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  _DisplayMessageTypeState createState() => _DisplayMessageTypeState();
}

class _DisplayMessageTypeState extends State<DisplayMessageType> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    isPlaying = false;
    duration = const Duration();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == MessageEnum.text
        ? Text(
            widget.message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : widget.type == MessageEnum.audio
            ? _buildAudioMessage()
            : widget.type == MessageEnum.video
                ? VideoPlayerView(
                    url: widget.message,
                    dataSourceType: DataSourceType.network,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.message,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
  }

  Widget _buildAudioMessage() {
    final timeRemaining = duration - position;
    final timeRemainingMinutes = '${timeRemaining.inMinutes}'.padLeft(2, '0');
    final timeRemainingSeconds =
        '${timeRemaining.inSeconds.remainder(60)}'.padLeft(2, '0');
    final formattedTimeRemaining = '$timeRemainingMinutes:$timeRemainingSeconds';
    return SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              if (isPlaying) {
                await audioPlayer.pause();
                setState(() {
                  isPlaying = false;
                });
              } else {
                await audioPlayer.play(UrlSource(widget.message));
                setState(() {
                  isPlaying = true;
                });
              }
            },
            icon: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 40,
            ),
          ),
          Text(
            formattedTimeRemaining,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

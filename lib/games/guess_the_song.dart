import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:Drinkr/utils/file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:Drinkr/games/game.dart';
import 'package:Drinkr/utils/networking.dart';
import 'package:Drinkr/utils/types.dart';
import 'package:Drinkr/widgets/audio_visualization.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:audiowaveformFlutter/audiowaveformFlutter.dart';

import '../utils/player.dart';

class GuessTheSong extends BasicGame {
  final bool showSolutionButton = true;
  final Color primaryColor = Color.fromRGBO(46, 125, 50, 1);
  final Color secondaryColor = Color.fromRGBO(96, 173, 94, 1);

  final GameType type = GameType.GUESS_THE_SONG;

  final String title = "guessTheSong";
  final int drinkingDisplay = 1;

  GuessTheSong(List<Player> players, int difficulty, String text)
      : super(players, difficulty, text);

  @override
  State<StatefulWidget> createState() => GuessTheSongState();

  @override
  String get mainTitle => JsonDecoder().convert(text)[1];

  @override
  String get solutionText => JsonDecoder().convert(text)[0];
}

class GuessTheSongState extends BasicGameState
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool showSolution = false;
  AudioPlayer audioPlayer;

  // ignore: cancel_subscriptions
  StreamSubscription<Duration> durationSubscription;

  // ignore: cancel_subscriptions
  StreamSubscription<AudioPlayerState> stateSubscription;

  File f;

  @override
  void dispose() {
    this.durationSubscription?.cancel();
    this.stateSubscription?.cancel();
    this.audioPlayer.stop();
    _controller.dispose();
    if (f != null) {
      if (f.existsSync()) {
        f.deleteSync();
      }
    }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void buttonClick() async {
    if (_target == 0 || _target == 1) {
      if (await checkConnection()) {
        await audioPlayer.play(f.path, isLocal: true);
      } else {
        await Fluttertoast.showToast(
            msg: "noConnection".tr(), toastLength: Toast.LENGTH_SHORT);
      }
    }
    if (_target < 1 && _target > 0) {
      if (audioPlayer.state == AudioPlayerState.PAUSED) {
        await audioPlayer.resume();
        audioPlayer.state = AudioPlayerState.PLAYING;
      } else {
        await audioPlayer.pause();
        audioPlayer.state = AudioPlayerState.PAUSED;
      }
    }
  }

  int songDuration;

  AnimationController _controller;
  Tween<double> _tween;
  Animation<double> _animation;
  double _target = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    _tween = Tween(begin: _target, end: _target);
    _animation = _tween.animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ),
    );

    audioPlayer = AudioPlayer();
    this.durationSubscription =
        audioPlayer.onAudioPositionChanged.listen((pos) async {
      if (songDuration == null) {
        songDuration = await audioPlayer.getDuration();
      }
      _updateBar(pos.inMilliseconds / songDuration);
    });
    this.stateSubscription = audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.COMPLETED) {
        _updateBar(1);
      }
    }, onError: (msg) {
      Fluttertoast.showToast(
          msg: "An unexpected Error occurred.",
          toastLength: Toast.LENGTH_SHORT);
      _updateBar(1);
    });
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<SoundData> loadVisData() async {
    f = await createTemporaryFile(getRandomString(32) + ".mp3");

    http.Response response = await http.get(widget.mainTitle);
    await f.writeAsBytes(response.bodyBytes);

    return SoundData(await compute(AudiowaveformFlutter.audioWaveForm, f.path));
  }

  void _updateBar(double newValue) {
    _target = newValue;
    _tween.begin = _tween.end;
    _controller.reset();
    _tween.end = newValue;
    _controller.forward();
  }

  @override
  Widget buildWithoutSolution() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: ShowUpAnimation(
        child: Center(
          child: FutureBuilder<SoundData>(
            future: loadVisData(),
            builder: (BuildContext context, AsyncSnapshot<SoundData> snapshot) {
              if (snapshot.hasData) {
                return InkWell(
                  onTap: buttonClick,
                  child: ClipPath(
                    clipper: WaveformClipper(snapshot.data),
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox.expand(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) => LinearProgressIndicator(
                          value: _animation.value,
                          valueColor:
                              AlwaysStoppedAnimation(Colors.grey.shade900),
                          backgroundColor: widget.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text("An Error has occurred.");
              }
              return SpinKitCircle(
                color: widget.secondaryColor,
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:Drinkr/games/game.dart';
import 'package:Drinkr/utils/types.dart';
import 'package:flutter/material.dart';
import '../utils/player.dart';

class NeverHaveIEver extends BasicGame {
  final String title = "neverHaveIEver";
  final GameType type = GameType.NEVER_HAVE_I_EVER;

  final Color backgroundColor1 = Color.fromRGBO(222, 0, 0, 1);
  final Color backgroundColor2 = Color.fromRGBO(241, 72, 0, 1);

  final int drinkingDisplay = 1;

  NeverHaveIEver(List<Player> players, int difficulty, String text)
      : super(players, difficulty, text);

  @override
  String get mainTitle => text;
}

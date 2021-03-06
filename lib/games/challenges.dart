import 'dart:math';

import 'package:Drinkr/games/game.dart';
import 'package:Drinkr/menus/difficulty.dart';
import 'package:Drinkr/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/drinking.dart';

class Challenges extends BasicGame {
  final Color backgroundColor1 = Color.fromRGBO(110, 65, 239, 1);
  final Color backgroundColor2 = Color.fromRGBO(168, 50, 170, 1);
  final Color buttonColor = Color.fromRGBO(29, 29, 69, .3);
  final int drinkingDisplay = 0;

  Challenges(Player player, DifficultyType difficulty, String text)
      : super(player, difficulty, text);

  final String title = "challenges";

  @override
  String get mainTitle => text;
}

import 'package:Drinkr/games/game.dart';
import 'package:Drinkr/utils/types.dart';
import 'package:flutter/material.dart';

class Opinion extends BasicGame {
  final String title = "wouldYouRather";

  final Color backgroundColor1 = Color.fromRGBO(255, 135, 8, 1);
  final Color backgroundColor2 = Color.fromRGBO(231, 182, 56, 1);

  final int drinkingDisplay = 1;

  final GameType type = GameType.OPINION;

  Opinion(players, difficulty, text) : super(players, difficulty, text);

  @override
  String get mainTitle => text;
}

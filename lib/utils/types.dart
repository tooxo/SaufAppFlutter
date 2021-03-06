import 'package:Drinkr/games/challenges.dart';
import 'package:Drinkr/games/game.dart';
import 'package:Drinkr/games/guess_the_song.dart';
import 'package:Drinkr/games/guessing.dart';
import 'package:Drinkr/games/never_have_i_ever.dart';
import 'package:Drinkr/games/opinion.dart';
import 'package:Drinkr/games/quiz.dart';
import 'package:Drinkr/games/truth_or_dare.dart';
import 'package:Drinkr/games/who_would_rather.dart';
import 'package:Drinkr/menus/difficulty.dart';
import 'package:Drinkr/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum GameType {
  QUIZ,
  CHALLENGES,
  NEVER_HAVE_I_EVER,
  OPINION,
  GUESS,
  GUESS_THE_SONG,
  TRUTH,
  DARE,
  WHO_WOULD_RATHER,
  UNDEFINED
}

class BaseType {}

abstract class TypeClass<T extends BaseType> {
  Color get primaryColor;

  Color get secondaryColor;

  String get translatedTitle;

  String get filePrefix;

  bool get hasSolution;

  GameType get type;

  String get text1;

  String get text2;

  bool get includesPlayers;

  bool get singlePlayerActivity;

  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction;
}

class QuizType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(2, 119, 189, 1);

  Color secondaryColor = Color.fromRGBO(88, 165, 240, 1);

  String get translatedTitle => "bigBrainQuiz".tr();
  String filePrefix = "qui";
  bool hasSolution = true;
  GameType type = GameType.QUIZ;

  String get text1 => "quizText1".tr();

  String get text2 => "quizText2".tr();

  bool includesPlayers = true;
  bool singlePlayerActivity = true;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction =>
          (player, difficulty, message) => Quiz(player, difficulty, message);
}

class TruthType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(255, 23, 68, 1);

  Color secondaryColor = Color.fromRGBO(255, 89, 104, 1);

  String get translatedTitle => "truth".tr();
  String filePrefix = "tru";

  bool hasSolution = false;
  GameType type = GameType.TRUTH;

  String get text1 => "truthText1".tr();

  String get text2 => "truthText2".tr();

  bool includesPlayers = true;
  bool singlePlayerActivity = true;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          TruthOrDare(players, difficulty, message);
}

class DareType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(255, 23, 68, 1);
  Color secondaryColor = Color.fromRGBO(255, 89, 104, 1);

  String get translatedTitle => "dare".tr();
  String filePrefix = "dar";

  bool hasSolution = false;
  GameType type = GameType.DARE;

  String get text1 => "dareText1".tr();

  String get text2 => "dareText2".tr();

  bool includesPlayers = true;
  bool singlePlayerActivity = true;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => throw UnimplementedError();
}

class ChallengesType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(0, 150, 136, 1);
  Color secondaryColor = Color.fromRGBO(82, 199, 184, 1);

  String get translatedTitle => "challenges".tr();
  String filePrefix = "cha";

  bool hasSolution = false;
  GameType type = GameType.CHALLENGES;

  String get text1 => "challengesText1".tr();

  String get text2 => "challengesText2".tr();

  bool includesPlayers = true;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          Challenges(players, difficulty, message);
}

class NeverHaveIEverType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(211, 47, 47, 1);

  Color secondaryColor = Color.fromRGBO(255, 102, 89, 1);

  String get translatedTitle => "neverHaveIEver".tr();
  String filePrefix = "nhi";

  bool hasSolution = false;
  GameType type = GameType.NEVER_HAVE_I_EVER;

  String get text1 => "neverHaveIEverText1".tr();

  String get text2 => "neverHaveIEverText2".tr();

  bool includesPlayers = false;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction =>
          (Player player, DifficultyType difficulty, String text) =>
              NeverHaveIEver(player, difficulty, text);
}

class WouldYouRatherType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(253, 216, 53, 1);

  Color secondaryColor = Color.fromRGBO(255, 255, 107, 1);

  String get translatedTitle => "wouldYouRather".tr();
  String filePrefix = "opi";

  bool hasSolution = false;
  GameType type = GameType.OPINION;

  String get text1 => "opinionText1".tr();

  String get text2 => "opinionText2".tr();

  bool includesPlayers = false;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          Opinion(players, difficulty, message);
}

class OpinionType extends WouldYouRatherType {
  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          Opinion(players, difficulty, message);
}

class GuessingType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(156, 39, 176, 1);

  Color secondaryColor = Color.fromRGBO(208, 92, 227, 1);

  String get translatedTitle => "guessing".tr();
  String filePrefix = "gue";

  bool hasSolution = true;
  GameType type = GameType.GUESS;

  String get text1 => "guessingText1".tr();

  String get text2 => "guessingText2".tr();

  bool includesPlayers = false;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          Guessing(players, difficulty, message);
}

class WhoWouldRatherType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(156, 39, 176, 1);

  Color secondaryColor = Color.fromRGBO(208, 92, 227, 1);

  String get translatedTitle => "whoWouldRather".tr();
  String filePrefix = "wwr";

  bool hasSolution = false;
  GameType type = GameType.WHO_WOULD_RATHER;

  String get text1 => "whoWouldRatherText1".tr();

  String get text2 => "whoWouldRatherText2".tr();

  bool includesPlayers = false;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          WhoWouldRather(players, difficulty, message);
}

class GuessTheSongType extends TypeClass<BaseType> {
  Color primaryColor = Color.fromRGBO(46, 125, 50, 1);
  Color secondaryColor = Color.fromRGBO(96, 173, 94, 1);

  String get translatedTitle => "guessTheSong".tr();
  String filePrefix = "gts";

  bool hasSolution = false;
  GameType type = GameType.GUESS_THE_SONG;

  String get text1 => "guessTheSongText1".tr();

  String get text2 => "guessTheSongText2".tr();

  bool includesPlayers = false;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => (players, difficulty, message) =>
          GuessTheSong(players, difficulty, message);
}

class UnknownType extends TypeClass<BaseType> {
  Color primaryColor = Colors.black;
  Color secondaryColor = Colors.black;

  String get translatedTitle => "";
  String filePrefix =
      "jquBefzYYCgFerAjnt9XUahnATF4GbsFyQXuKrPejmMJwmGWtVsuJ6x94marBPty";

  bool hasSolution = false;
  GameType type = GameType.UNDEFINED;

  String get text1 => "";

  String get text2 => "";

  bool includesPlayers = false;
  bool singlePlayerActivity = false;

  @override
  BasicGame Function(Player player, DifficultyType difficulty, String text)
      get constructorFunction => throw UnimplementedError();
}

TypeClass<BaseType> gameTypeToGameTypeClass(GameType gameType) {
  switch (gameType) {
    case GameType.QUIZ:
      return QuizType();
    case GameType.CHALLENGES:
      return ChallengesType();
    case GameType.NEVER_HAVE_I_EVER:
      return NeverHaveIEverType();
    case GameType.OPINION:
      return OpinionType();
    case GameType.GUESS:
      return GuessingType();
    case GameType.GUESS_THE_SONG:
      return GuessTheSongType();
    case GameType.TRUTH:
      return TruthType();
    case GameType.DARE:
      return DareType();
    case GameType.WHO_WOULD_RATHER:
      return WhoWouldRatherType();
    case GameType.UNDEFINED:
      return UnknownType();
    default:
      return UnknownType();
  }
}

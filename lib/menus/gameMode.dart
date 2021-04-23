import 'dart:convert';
import 'dart:math';

import 'package:Drinkr/menus/difficulty.dart';
import 'package:Drinkr/utils/shapes.dart';
import 'package:Drinkr/utils/types.dart';
import 'package:Drinkr/widgets/BasicTile.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/file.dart';
import 'name_select.dart';
import '../utils/player.dart';
import 'setting.dart';
import '../utils/types.dart';

ScrollController _scrollControl = ScrollController();

class GameMode extends StatefulWidget {
  @override
  GameState createState() => GameState();
}

class GameState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(21, 21, 21, 1),
          title: Text(
            "Wähle deinen Spielmodus",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ).tr(),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              BasicTile(
                mainColor: Color.fromRGBO(255, 27, 24, 1),
                secondaryColor: Color.fromRGBO(241, 61, 180, 1),
                title: "Party",
                description: "Spaß für die ganze Familie",
                icon: Icons.icecream,
                games: "\u2022 Wahrheit oder Pflicht\n"
                    "\u2022 Wer würde eher\n"
                    "\u2022 Entweder ... oder...?\n"
                    "\u2022 Challenges\n"
                    "\u2022 Ich hab noch nie...?",
                enabledGames: [
                  GameType.DARE,
                  GameType.TRUTH,
                  GameType.CHALLENGES,
                  GameType.NEVER_HAVE_I_EVER,
                  GameType.OPINION,
                  GameType.QUIZ,
                  GameType.GUESS,
                  GameType.GUESS_THE_SONG
                ],
              ),
              BasicTile(
                mainColor: Color.fromRGBO(79, 44, 208, 1),
                secondaryColor: Color.fromRGBO(7, 149, 199, 1),
                title: "Quiz",
                description: "Teste dein Wissen!",
                icon: Icons.lightbulb_outline,
                games: "\u2022 Big brain Quiz\n"
                    "\u2022 Schätzfragen",
                enabledGames: [
                  GameType.QUIZ,
                  GameType.GUESS,
                ],
              ),
              BasicTile(
                mainColor: Color.fromRGBO(118, 13, 123, 1),
                secondaryColor: Color.fromRGBO(220, 15, 17, 1),
                title: "Dirty",
                description: "Intime Fragen",
                icon: Icons.warning_amber_rounded,
                games: "\u2022 Wahrheit oder Pflicht(+18)\n"
                    "\u2022 Wer würde eher(+18)",
                enabledGames: [
                  GameType.NEVER_HAVE_I_EVER,
                  GameType.DARE,
                  GameType.TRUTH,
                ],
              ),
              BasicTile(
                mainColor: Color.fromRGBO(15, 125, 97, 1),
                secondaryColor: Color.fromRGBO(140, 203, 40, 1),
                title: "Lieder raten",
                description: "Errate das Lied als erstes!",
                icon: Icons.music_note_outlined,
                games: "\u2022 Rate den Song",
                enabledGames: [
                  GameType.GUESS_THE_SONG
                ],
              ),
              BasicTile(
                mainColor: Color.fromRGBO(255, 27, 24, 1).withOpacity(0.5),
                secondaryColor:
                    Color.fromRGBO(241, 61, 180, 1).withOpacity(0.5),
                title: "Custom",
                description: "Wähle zwischen allen Spielen!",
                icon: Icons.star_border,
                textColor: Colors.white.withOpacity(0.5),
                topIcon: Icons.lock_outline,
                games: "Kauf pls I need money",
              )
            ],
          ),
        ));
  }
}

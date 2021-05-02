import 'dart:convert';

import 'package:Drinkr/games/game.dart';
import 'package:Drinkr/widgets/text_widget.dart';
import 'package:Drinkr/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import '../utils/player.dart';

class TruthOrDare extends BasicGame {
  final String title = "truthOrDare";

  final Color backgroundColor1 = Color.fromRGBO(112, 13, 129, 1);
  final Color backgroundColor2 = Color.fromRGBO(222, 15, 15, 1);

  final GameType type = GameType.TRUTH;

  final int drinkingDisplay = 1;

  TruthOrDare(Player player, int difficulty, String text)
      : super(player, difficulty, text);

  @override
  String get mainTitle => text;

  @override
  State<StatefulWidget> createState() => TruthOrDareState();
}

const _kFontFam = 'Icons';
const _kFontPkg = null;
const IconData dice =
    IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);

class TruthOrDareState extends BasicGameState {
  bool truth = false;
  bool showSolution = false;

  @override
  Widget buildWithoutSolution() {
    return !showSolution
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextWidget(
                    widget.selectedPlayer.name,
                    textColor: widget.textColor,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 32, right: 32, top: 10),
                          child: SizedBox.expand(
                            child: ShowUpAnimation(
                              offset: 0,
                              child: MaterialButton(
                                color: widget.buttonColor,
                                onPressed: () {
                                  showSolution = true;
                                  truth = true;
                                  setState(() {});
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                child: FittedBox(
                                  child: Text(
                                    "truth",
                                    style: GoogleFonts.nunito(
                                      textStyle:
                                          TextStyle(color: widget.textColor),
                                      fontSize: 45,
                                    ),
                                  ).tr(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                        ),
                                        child: Center(
                                            child: IconButton(
                                                icon: Icon(dice),
                                                color: widget.buttonColor,
                                            )
                                        ),
                                    ),
                                ),*/
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 32, right: 32, top: 10),
                          child: SizedBox.expand(
                            child: ShowUpAnimation(
                              offset: 0,
                              child: MaterialButton(
                                color: widget.buttonColor,
                                onPressed: () {
                                  showSolution = true;
                                  truth = false;
                                  setState(() {});
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                child: FittedBox(
                                  child: Text(
                                    "dare",
                                    style: GoogleFonts.nunito(
                                      textStyle:
                                          TextStyle(color: widget.textColor),
                                      fontSize: 45,
                                    ),
                                  ).tr(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : TextWidget(
            this.truth
                ? "truth".tr() + ": " + jsonDecode(widget.mainTitle)["truth"]
                : "dare".tr() + ": " + jsonDecode(widget.mainTitle)["dare"],
            textColor: widget.textColor,
          );
  }
}

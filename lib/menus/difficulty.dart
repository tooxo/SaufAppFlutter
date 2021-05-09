import 'dart:ui';
import 'package:Drinkr/games/game_controller.dart';
import 'package:Drinkr/utils/player.dart';
import 'package:Drinkr/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Difficulty extends StatefulWidget {
  static const int EASY = 0;
  static const int MIDDLE = 1;
  static const int HARD = 2;

  final List<Player> players;
  final int rounds;

  final List<GameType> enabledGames;

  const Difficulty(this.players, this.rounds, this.enabledGames);

  static const IconData mediumIcon =
      IconData(0xe800, fontFamily: "DifficultyIcons", fontPackage: null);
  static const IconData hardIcon =
      IconData(0xe801, fontFamily: "DifficultyIcons", fontPackage: null);
  static const IconData easyIcon =
      IconData(0xe802, fontFamily: "DifficultyIcons", fontPackage: null);

  @override
  State<StatefulWidget> createState() => DifficultyState();
}

class DifficultyState extends State<Difficulty> {
  GameController controller;
  int displayState =
      1; // 1 Difficulty Selection, 2 Loading indicator, 3 Just Orange

  @override
  void initState() {
    super.initState();
    controller = GameController(
        widget.rounds, widget.enabledGames, widget.players, context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  final AdRequest targetingInfo = AdRequest(
    keywords: ["trinken", "drinking", "alkohol", "alcohol"],
    nonPersonalizedAds: false,
    testDevices: [],
  );

  BannerAd bannerAd;

  @override
  void dispose() {
    if (bannerAd != null) {
      bannerAd.dispose().then((value) => bannerAd = null);
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    super.dispose();
  }

  selectDifficulty(int selectedDifficulty) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    this.displayState = 2;
    setState(() {});
    controller.start(selectedDifficulty);
  }

  int linearProgress = 1;
  int linearMax = 2;

  bool wantSchluck = true;
  bool wantShots = true;

  int startSchluck = 0;
  int endSchluck = 0;

  int startShots = 0;
  int endShots = 0;

  void incrementStartSchluck() {
    setState(() {
      startSchluck++;
    });
  }

  void decrementStartSchluck() {
    setState(() {
      startSchluck--;
    });
  }

  void incrementEndSchluck() {
    setState(() {
      endSchluck++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return displayState == 1
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color.fromRGBO(21, 21, 21, 1),
              title: Text(
                "selectDifficulty",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ).tr(),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            backgroundColor: Color.fromRGBO(21, 21, 21, 1),
            body: Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 180,
                      width: 350.0,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 8,
                              offset:
                                  Offset(2, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: ListTile(
                          onTap: () => selectDifficulty(Difficulty.EASY),
                          leading: Icon(
                            Difficulty.easyIcon,
                            size: 60,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Leicht",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ).tr(),
                          subtitle: Text(
                            "1-2 Schlücke | 5 shots",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ).tr(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 180,
                      width: 350.0,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 8,
                              offset:
                                  Offset(2, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: ListTile(
                          onTap: () => selectDifficulty(Difficulty.EASY),
                          leading: Icon(
                            Difficulty.mediumIcon,
                            size: 60,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Normal",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ).tr(),
                          subtitle: Text(
                            "1-2 Schlücke | 5 shots",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ).tr(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 180,
                      width: 350.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 8,
                              offset:
                                  Offset(2, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: ListTile(
                          onTap: () => selectDifficulty(Difficulty.HARD),
                          leading: Icon(
                            Difficulty.hardIcon,
                            size: 60,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Absturz",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ).tr(),
                          subtitle: Text(
                            "1-2 Schlücke | 5 shots",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ).tr(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => addCustomDifficulty(context),
              child: Icon(
                Icons.add,
                size: 25,
              ),
            ),
          )
        : Container(
            height: 20,
            color: Color.fromRGBO(21, 21, 21, 1),
            child: LinearProgressIndicator(
              value: linearProgress / linearMax,
              backgroundColor: Color.fromRGBO(21, 21, 21, 1),
              valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
            ),
          );
  }

  void addCustomDifficulty(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            backgroundColor: Color.fromRGBO(21, 21, 21, 1),
            title: TextField(
              style: GoogleFonts.nunito(
                fontSize: 20,
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: "Name der Schwierigkeit...".tr(),
                hintStyle: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 2,
                      child: Checkbox(
                        value: true,
                        focusColor: Colors.white,
                        checkColor: Colors.white,
                        activeColor: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      "Schlück(e)",
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(),
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ).tr(),
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: incrementStartSchluck),
                            Text(
                              startSchluck.toString(),
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(),
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: decrementStartSchluck),
                          ],
                        ),
                        Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: incrementStartSchluck),
                            Text(
                              startSchluck.toString(),
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(),
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: decrementStartSchluck),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 2,
                      child: Checkbox(
                        value: true,
                        focusColor: Colors.white,
                        checkColor: Colors.white,
                        activeColor: Colors.deepOrange,
                        onChanged: (bool value) {},
                      ),
                    ),
                    Text(
                      "Shot(s)",
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(),
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ).tr(),
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: incrementStartSchluck),
                            Text(
                              startSchluck.toString(),
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(),
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: decrementStartSchluck),
                          ],
                        ),
                        Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: incrementStartSchluck),
                            Text(
                              startSchluck.toString(),
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(),
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: decrementStartSchluck),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Color.fromRGBO(21, 21, 21, 1),
                    child: Container(
                      height: 50,
                      width: 350.0,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 8,
                              offset:
                                  Offset(2, 10), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Schwierigkeit auswählen",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ).tr(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

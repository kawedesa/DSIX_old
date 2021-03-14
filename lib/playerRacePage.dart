import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerRace.dart';
import 'dart:math';
import 'playerBackgroundPage.dart';
import 'package:dsixv02app/models/game/game.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bonus.dart';

class PlayerRacePage extends StatefulWidget {
  static const String routeName = "/playerRacePage";

  final Dsix dsix;

  const PlayerRacePage({Key key, this.dsix}) : super(key: key);

  @override
  _PlayerRacePageState createState() => new _PlayerRacePageState();
}

class _PlayerRacePageState extends State<PlayerRacePage> {
  static List<PlayerRace> races = [
    PlayerRace(
        'human',
        'HUMAN',
        'Humans are everywhere. They are flexible and adapt to most circumstances, so you get an extra action point to spend anyway you want.',
        [
          Bonus(
              '+ ACTION POINT  ',
              'actionPoint',
              'Each action point allows you to permanently improve the chance of success of an action.',
              1)
        ]),
    PlayerRace(
        'orc',
        'ORC',
        'Orcs are tall and strong, making them good fighters but easy targets. They can carry more weight, but have a harder time moving around.',
        [
          Bonus('+ ATTACK  ', 'attack',
              'You use this action when you attack a target.', 1),
          Bonus(
              '- MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              -1),
          Bonus(
              '+ WEIGHT  ',
              'maxWeight',
              'This represents the total amount of weight you can carry. Because of your strength, you can carry +6 weight.',
              6)
        ]),
    PlayerRace(
        'goblin',
        'GOBLIN',
        'Goblins are small, vicious creatures with sharp teeth and quick feet. They are not really strong, but are still very dangerous.',
        [
          Bonus('+ ATTACK  ', 'attack',
              'You use this action when you attack a target.', 1),
          Bonus(
              '+ MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              1),
          Bonus(
              '- WEIGHT  ',
              'maxWeight',
              'This represents the total amount of weight you can carry. Because you are weak, you carry -6 weight.',
              -6)
        ]),
    PlayerRace(
        'dwarf',
        'DWARF',
        'Dwarfs are sturdy, allowing them to take more blows before going down. \nHowever, their small size and stubborn personality limits their perception.',
        [
          Bonus('+ DEFENSE  ', 'defense',
              'You use this action when you protect yourself or others.', 1),
          Bonus('- PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', -1),
          Bonus(
              '+ Health  ',
              'maxHealth',
              'This represents your total health and you die when it reaches zero. Because of your sturdy nature you have +6 HP.',
              6)
        ]),
    PlayerRace(
        'halfling',
        'HALFLING',
        'Halflings are small curious creatures, always looking for something new to learn. They are not really good at fighting and try to solve most problems without violence.',
        [
          Bonus('- ATTACK  ', 'attack',
              'You use this action when you attack a target.', -1),
          Bonus('+ PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', 1),
          Bonus(
              '+ TALK  ',
              'talk',
              'You use this action when you talk to someone that can understand you.',
              1)
        ]),
    PlayerRace(
        'elf',
        'ELF',
        'Elves have slim bodies and sharp senses, making them very perceptive and agile. Because of their frail constitution, they rely on their reflexes to avoid danger.',
        [
          Bonus('- DEFENSE  ', 'defense',
              'You use this action when you protect yourself or others.', -1),
          Bonus('+ PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', 1),
          Bonus(
              '+ MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              1)
        ]),
    PlayerRace(
      '',
      'RACES',
      'There are many races that live in this world. They vary in size, culture and color. Click on the icons above to choose your race.',
      [
        Bonus(
            'BONUS',
            'bonus',
            'Each race is unique and has different bonuses. Some are good, while others are bad. They affect how the game plays and the outcome of your actions.',
            0)
      ],
    ),

    //PlayerRace('gnome','GNOME','Gnomes are small and curious creatures, that are always working on a crazy project.',Bonus(0,'INVENTION', 'Choose your invention:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('darkElf','DARK ELF','Dark elfs are smarter than most people, making them quite arrogant.',Bonus(1,'INTELLIGENCE', 'Intelligence represents how much you know about the world.',[])),
    //PlayerRace('machine','MACHINE','Machines are created with the ability to perform a task. They are everywhere, but only a few of them are conscious.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('elemental','ELEMENTAL','Elementals are powerful magical beings, that live in nature and protect their habitat.',Bonus(2,'MAGIC ARMOR', 'You have a defensive layer that protects against magic attacks.',[])),
    //PlayerRace('lizard','LIZARD','Lizards are covered with beautiful scales that offer protection.',Bonus(2,'ARMOR', 'Your scales protect against physical attacks.',[])),
    //PlayerRace('beast','BEAST','Beasts vary in size and power. Each one has a different ability that helps them survive in nature.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
  ];

  String infoIcon = 'help';

  PlayerRace displayRace = races[6];

  int displaySex = 0;

  List<String> selectedRace = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  List<IconData> sex = [];

  void raceSelection(index) {
    selectedRace = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];

    selectedRace.replaceRange(index, index + 1, [races[index].icon]);
    widget.dsix.getCurrentPlayer().race = races[index];
    displayRace = widget.dsix.getCurrentPlayer().race;
  }

  void confirm() {
    // ASSIGN RACES BONUSES TO PLAYER

    // RESET MAX life, MAX Weight and Action Points

    widget.dsix.getCurrentPlayer().maxHealth = 12;
    widget.dsix.getCurrentPlayer().maxWeight = 12;
    widget.dsix.getCurrentPlayer().actionPoint = 3;

    // RESET Actions value.

    int check = 0;

    while (check < widget.dsix.getCurrentPlayer().playerAction.length) {
      widget.dsix.getCurrentPlayer().playerAction[check].value = 0;
      check++;
    }

    // ASSIGN BONUSES

    if (widget.dsix.getCurrentPlayer().race.race == 'HUMAN') {
      widget.dsix.getCurrentPlayer().actionPoint = 4; //ACTION POINT
    } else if (widget.dsix.getCurrentPlayer().race.race == 'ORC') {
      widget.dsix.getCurrentPlayer().playerAction[0].value = 1; //ATTACK
      widget.dsix.getCurrentPlayer().playerAction[4].value = -1; //MOVE
      widget.dsix.getCurrentPlayer().maxWeight = 18; //WEIGHT
    } else if (widget.dsix.getCurrentPlayer().race.race == 'GOBLIN') {
      widget.dsix.getCurrentPlayer().playerAction[0].value = 1; //ATTACK
      widget.dsix.getCurrentPlayer().playerAction[4].value = 1; //MOVE
      widget.dsix.getCurrentPlayer().maxWeight = 6; //WEIGHT
    } else if (widget.dsix.getCurrentPlayer().race.race == 'DWARF') {
      widget.dsix.getCurrentPlayer().playerAction[1].value = 1; //DEFENSE
      widget.dsix.getCurrentPlayer().playerAction[2].value = -1; //PERCEIVE
      widget.dsix.getCurrentPlayer().maxHealth = 18; //HEALTH
    } else if (widget.dsix.getCurrentPlayer().race.race == 'HALFLING') {
      widget.dsix.getCurrentPlayer().playerAction[0].value = -1; //ATTACK
      widget.dsix.getCurrentPlayer().playerAction[2].value = 1; //PERCEIVE
      widget.dsix.getCurrentPlayer().playerAction[3].value = 1; //TALK
    } else if (widget.dsix.getCurrentPlayer().race.race == 'ELF') {
      widget.dsix.getCurrentPlayer().playerAction[1].value = -1; //DEFENCE
      widget.dsix.getCurrentPlayer().playerAction[2].value = 1; //PERCEIVE
      widget.dsix.getCurrentPlayer().playerAction[4].value = 1; //MOVE
    }

    //ASSIGN CURRENT WEIGHT AND HEALTH

    widget.dsix.getCurrentPlayer().currentHealth =
        widget.dsix.getCurrentPlayer().maxHealth;
    widget.dsix.getCurrentPlayer().currentWeight = 0;

    //MOVE TO NEXT PAGE

    Navigator.of(context).push(_createRouteBackground());
  }

  void chooseSex() {
    if (widget.dsix.getCurrentPlayer().playerSex == 1) {
      widget.dsix.getCurrentPlayer().playerSex = 2;
    } else if (widget.dsix.getCurrentPlayer().playerSex == 2) {
      widget.dsix.getCurrentPlayer().playerSex = 1;
    } else {
      widget.dsix.getCurrentPlayer().playerSex = Random().nextInt(2) + 1;
    }

    displaySex = widget.dsix.getCurrentPlayer().playerSex;
  }

  showAlertDialog(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          displayRace.bonus[index].name,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 30.0,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    displayRace.bonus[index].description,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 22,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  double _size = 0;

  void _updateState() {
    setState(() {
      _size = 50;
    });
  }

  Route _createRouteBackground() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayerBackgroundPage(
        dsix: widget.dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          backgroundColor:
              widget.dsix.getCurrentPlayer().playerColor.primaryColor,
          centerTitle: true,
          title: new Text(
            'Race and Gender',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Headline',
              height: 1.1,
              fontSize: 25.0,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: AnimatedContainer(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 400),
                width: _size,
                height: _size,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.lightGreenAccent,
                    size: 40,
                  ),
                  onPressed: () {
                    confirm();
                  },
                ),
              ),
            ),
          ],
        ),
        body: new SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
                    child: Stack(
                      children: <Widget>[
                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SvgPicture.asset(
                                'assets/race/${races[index].icon}.svg',
                                color: Colors.white,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            );
                          }),
                        ),
                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _updateState();
                                    raceSelection(index);
                                    chooseSex();
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/race/${selectedRace[index]}.svg',
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 2,
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
              ),
              Expanded(
                flex: 13,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                displayRace.race,
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1.3,
                                  fontSize: 50,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  letterSpacing: 2,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              //   child: SizedBox(
                              //       height: 45,
                              //       child: TextButton(
                              //           onPressed: () {
                              //             setState(() {
                              //               chooseSex();
                              //             });
                              //           },
                              //           child: Image.asset(
                              //               // 'images/player/sex${widget.dsix.getCurrentPlayer().playerIndex}$displaySex.png')
                              //               )
                              //               ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            displayRace.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1.3,
                              letterSpacing: 1.1,
                              fontSize: 22,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height *
                              displayRace.bonus.length *
                              0.08,
                          child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              itemCount: displayRace.bonus.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  style: TextButton.styleFrom(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context, index);
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 12, 12, 0),
                                              child: SvgPicture.asset(
                                                'assets/ui/$infoIcon.svg',
                                                color: widget.dsix
                                                    .getCurrentPlayer()
                                                    .playerColor
                                                    .primaryColor,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.055,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: widget.dsix
                                                .getCurrentPlayer()
                                                .playerColor
                                                .primaryColor,
                                            width:
                                                2.5, //                   <--- border width here
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Center(
                                            child: Text(
                                              displayRace.bonus[index].name,
                                              style: TextStyle(
                                                height: 1.5,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
                                                fontFamily: 'Calibri',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

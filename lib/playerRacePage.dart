import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerBackgroundPage.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerRacePage extends StatefulWidget {
  static const String routeName = "/playerRacePage";

  final Dsix dsix;

  const PlayerRacePage({Key key, this.dsix}) : super(key: key);

  @override
  _PlayerRacePageState createState() => new _PlayerRacePageState();
}

class _PlayerRacePageState extends State<PlayerRacePage> {
  int displaySex = 0;

  List<String> selectedRace = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  void raceSelection(index) {
    selectedRace = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];

    widget.dsix.getCurrentPlayer().chooseRace(index);

    selectedRace.replaceRange(
        index, index + 1, [widget.dsix.getCurrentPlayer().races[index].icon]);
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
                          widget.dsix.getCurrentPlayer().race.bonus[index].name,
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
                    widget.dsix
                        .getCurrentPlayer()
                        .race
                        .bonus[index]
                        .description,
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
                    Navigator.of(context).push(_createRouteBackground());
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
                                'assets/race/${widget.dsix.getCurrentPlayer().races[index].icon}.svg',
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
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                widget.dsix.getCurrentPlayer().race.race,
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.dsix
                                            .getCurrentPlayer()
                                            .chooseSex();
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'assets/player/${widget.dsix.getCurrentPlayer().playerSex}.svg',
                                      color: widget.dsix
                                          .getCurrentPlayer()
                                          .playerColor
                                          .primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            widget.dsix.getCurrentPlayer().race.description,
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
                              widget.dsix.getCurrentPlayer().race.bonus.length *
                              0.08,
                          child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              itemCount: widget.dsix
                                  .getCurrentPlayer()
                                  .race
                                  .bonus
                                  .length,
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
                                                'assets/ui/help.svg',
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
                                              widget.dsix
                                                  .getCurrentPlayer()
                                                  .race
                                                  .bonus[index]
                                                  .name,
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

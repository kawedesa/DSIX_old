import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'playerSkillPage.dart';

class PlayerBackgroundPage extends StatefulWidget {
  static const String routeName = "/playerBackgroundPage";

  final Dsix dsix;

  const PlayerBackgroundPage({Key key, this.dsix}) : super(key: key);

  @override
  _PlayerBackgroundPageState createState() => new _PlayerBackgroundPageState();
}

class _PlayerBackgroundPageState extends State<PlayerBackgroundPage> {
  List<String> selectedBackground = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  void backgroundSelection(index) {
    selectedBackground = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];

    selectedBackground.replaceRange(index, index + 1,
        [widget.dsix.getCurrentPlayer().availableBackgrounds[index].icon]);
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                    child: Center(
                      child: Text(
                        widget.dsix
                            .getCurrentPlayer()
                            .playerBackground
                            .bonus[index]
                            .name,
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 25.0,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    widget.dsix
                        .getCurrentPlayer()
                        .playerBackground
                        .bonus[index]
                        .description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 19,
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

  Route _createRouteSkill() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerSkillPage(
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
              color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
              size: 40,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          backgroundColor:
              widget.dsix.getCurrentPlayer().playerColor.primaryColor,
          centerTitle: true,
          title: new Text(
            'Background ',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Headline',
              height: 1.1,
              fontSize: 25.0,
              color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
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
                    Navigator.of(context).push(_createRouteSkill());
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
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
                  child: Stack(
                    children: <Widget>[
                      GridView.count(
                        crossAxisCount: 6,
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: SvgPicture.asset(
                              'assets/player/background/${widget.dsix.getCurrentPlayer().availableBackgrounds[index].icon}.svg',
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                      GridView.count(
                        crossAxisCount: 6,
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.dsix
                                      .getCurrentPlayer()
                                      .chooseBackground(index);
                                  backgroundSelection(index);
                                  _updateState();
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                              ),
                              child: SvgPicture.asset(
                                'assets/player/background/${selectedBackground[index]}.svg',
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
              Divider(
                height: 0,
                thickness: 2,
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
              ),
              Expanded(
                flex: 13,
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                widget.dsix
                                    .getCurrentPlayer()
                                    .playerBackground
                                    .background,
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1.3,
                                  fontSize: 45,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                widget.dsix
                                    .getCurrentPlayer()
                                    .playerBackground
                                    .description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  height: 1.3,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                itemCount: widget.dsix
                                    .getCurrentPlayer()
                                    .playerBackground
                                    .bonus
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                    ),
                                    onPressed: () {
                                      showAlertDialog(context, index);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.058,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: widget.dsix
                                              .getCurrentPlayer()
                                              .playerColor
                                              .primaryColor,
                                          width:
                                              2, //                   <--- border width here
                                        ),
                                      ),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 10, 0),
                                                child: SvgPicture.asset(
                                                  'assets/ui/help.svg',
                                                  color: widget.dsix
                                                      .getCurrentPlayer()
                                                      .playerColor
                                                      .primaryColor,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: Text(
                                              widget.dsix
                                                  .getCurrentPlayer()
                                                  .playerBackground
                                                  .bonus[index]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
                                                fontFamily: 'Calibri',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

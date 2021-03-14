import 'playerUI.dart';
import 'option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/game.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'playerAction.dart';

class PlayerAttributePage extends StatefulWidget {
  final Dsix dsix;

  const PlayerAttributePage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playerAttributePage";

  @override
  _PlayerAttributePageState createState() => new _PlayerAttributePageState();
}

class _PlayerAttributePageState extends State<PlayerAttributePage> {
  PlayerAction displayedAction = PlayerAction(
      'action',
      'ACTION',
      'These are the actions your character can make throughout the game. Use the arrows on the left to add or remove points from a specific action. The more points you have, the easier it will be to get a good result on that action.',
      [
        Option(
            'OPTIONS',
            'Some actions have more than one option or effect to choose from.',
            '',
            '',
            '')
      ],
      0,
      false);

  String infoIcon = 'help';

  List<String> selectedAction = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  List<int> displayActionValue = [];

  int originalActionPoint;
  List<int> originalActionValue = [];

  void actionSelection(index) {
    selectedAction = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];
    selectedAction.replaceRange(index, index + 1,
        [widget.dsix.getCurrentPlayer().playerAction[index].icon]);
    displayedAction = widget.dsix.getCurrentPlayer().playerAction[index];
  }

  void increase() {
    if (widget.dsix.getCurrentPlayer().actionPoint == 0) {
      return;
    }

    for (int check = 0;
        check < widget.dsix.getCurrentPlayer().playerAction.length;
        check++) {
      if (displayedAction.name ==
              widget.dsix.getCurrentPlayer().playerAction[check].name &&
          widget.dsix.getCurrentPlayer().playerAction[check].value < 3) {
        widget.dsix.getCurrentPlayer().playerAction[check].value++;
        widget.dsix.getCurrentPlayer().actionPoint--;
      }
    }
  }

  void decrease() {
    for (int check = 0;
        check < widget.dsix.getCurrentPlayer().playerAction.length;
        check++) {
      if (displayedAction.name ==
          widget.dsix.getCurrentPlayer().playerAction[check].name) {
        if (widget.dsix.getCurrentPlayer().playerAction[check].value !=
            originalActionValue[check]) {
          widget.dsix.getCurrentPlayer().playerAction[check].value--;
          widget.dsix.getCurrentPlayer().actionPoint++;
        }
      }
    }
  }

  void reset() {
    widget.dsix.getCurrentPlayer().actionPoint = originalActionPoint;

    for (int check = 0;
        check < widget.dsix.getCurrentPlayer().playerAction.length;
        check++) {
      widget.dsix.getCurrentPlayer().playerAction[check].value =
          originalActionValue[check];
    }
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
                          displayedAction.option[index].name,
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
                    displayedAction.option[index].description,
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
    if (widget.dsix.getCurrentPlayer().actionPoint == 0) {
      setState(() {
        _size = 50;
      });
    } else {
      setState(() {
        _size = 0;
      });
    }
  }

  final myController = TextEditingController();

  void confirm() {
    widget.dsix.getCurrentPlayer().name = myController.text;

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PlayerUI(
          dsix: widget.dsix,
        ),
      ),
    );
  }

  showAlertDialogName(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
            width: 2.5, //                   <--- border width here
          ),
        ),
        width: 300,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter your Name',
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
              padding: const EdgeInsets.fromLTRB(35, 35, 25, 5),
              child: TextField(
                  autofocus: true,
                  cursorColor:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  textAlign: TextAlign.center,
                  onEditingComplete: confirm,
                  onSubmitted: (value) {
                    widget.dsix.getCurrentPlayer().name = value;
                    Navigator.of(context).push(_createRouteUI());
                  },
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontFamily: 'Calibri',
                    color: Colors.white,
                  ),
                  controller: myController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.dsix
                            .getCurrentPlayer()
                            .playerColor
                            .primaryColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.dsix
                            .getCurrentPlayer()
                            .playerColor
                            .primaryColor,
                        width: 1.5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.dsix
                            .getCurrentPlayer()
                            .playerColor
                            .primaryColor,
                        width: 1.5,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Route _createRouteUI() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerUI(
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
  void initState() {
    super.initState();

    for (int check = 0;
        check < widget.dsix.getCurrentPlayer().playerAction.length;
        check++) {
      originalActionValue
          .add(widget.dsix.getCurrentPlayer().playerAction[check].value);
    }

    originalActionPoint = widget.dsix.getCurrentPlayer().actionPoint;

    _size = 0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                reset();

                Navigator.of(context).pop();
              }),
          titleSpacing: 0,
          backgroundColor:
              widget.dsix.getCurrentPlayer().playerColor.primaryColor,
          centerTitle: true,
          title: new Text(
            'Action ',
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
                    showAlertDialogName(context);
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
                        //ACTION ICON

                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SvgPicture.asset(
                                'assets/action/${widget.dsix.getCurrentPlayer().playerAction[index].icon}.svg',
                                color: Colors.white,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            );
                          }),
                        ),

                        //ACTION VALUE

                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SvgPicture.asset(
                                'assets/action/${widget.dsix.getCurrentPlayer().playerAction[index].value}.svg',
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
                                    actionSelection(index);
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/action/${selectedAction[index]}.svg',
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: 65,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    increase();
                                    _updateState();
                                  });
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    decrease();
                                    _updateState();
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
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
                                displayedAction.name,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                              child: Text(
                                'Points left: ${widget.dsix.getCurrentPlayer().actionPoint}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  letterSpacing: 3,
                                  fontSize: 20,
                                  fontFamily: 'Headline',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Text(
                                displayedAction.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  height: 1.3,
                                  fontSize: 22,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.0 +
                                  displayedAction.option.length * 58,
                              child: ListView.builder(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  itemCount: displayedAction.option.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 10),
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
                                                    width:
                                                        MediaQuery.of(context)
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 8),
                                              child: Center(
                                                child: Text(
                                                  displayedAction
                                                      .option[index].name,
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

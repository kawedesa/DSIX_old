import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CharacterPage extends StatefulWidget {
  final Dsix dsix;

  const CharacterPage({Key key, this.dsix}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  TextEditingController myController;

  void confirm() {
    widget.dsix.gm.getCurrentPlayer().playerBackground.description =
        myController.text;
    Navigator.of(context).pop(true);
  }

  void showEffect(int index) {
    widget.dsix.gm.getCurrentPlayer().selectEffect(index);

    showAlertDialogAlert(context);
  }

  showAlertDialogAlert(
    BuildContext context,
  ) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.dsix.gm.getCurrentPlayer().effect.name,
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: new TextSpan(
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                      children:
                          (widget.dsix.gm.getCurrentPlayer().effect.permanent)
                              ? <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${widget.dsix.gm.getCurrentPlayer().effect.description}'),
                                ]
                              : <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${widget.dsix.gm.getCurrentPlayer().effect.description} Turns left: '),
                                  TextSpan(
                                      text:
                                          '${widget.dsix.gm.getCurrentPlayer().effect.duration}',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: widget.dsix.gm
                                              .getCurrentPlayer()
                                              .playerColor
                                              .primaryColor)),
                                ],
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

  showAlertDialogDescription(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
            width: 2.5, //                   <--- border width here
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                child: Center(
                  child: Text(
                    'WRITE A STORY',
                    style: TextStyle(
                      fontFamily: 'Santana',
                      height: 1,
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    autofocus: true,
                    cursorColor: widget.dsix.gm
                        .getCurrentPlayer()
                        .playerColor
                        .primaryColor,
                    textAlign: TextAlign.center,
                    onEditingComplete: confirm,
                    onSubmitted: (value) {
                      widget.dsix.gm
                          .getCurrentPlayer()
                          .playerBackground
                          .description = value;
                    },
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                    controller: myController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: 1.5,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: 1.5,
                        ),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
              child: GestureDetector(
                onTap: () {
                  confirm();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: 2, //                   <--- border width here
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Icon(
                              Icons.check,
                              color: widget.dsix.gm
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          'CONFIRM',
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
              ),
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

  @override
  void initState() {
    super.initState();

    myController = new TextEditingController(
        text: widget.dsix.gm.getCurrentPlayer().playerBackground.description);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
          //     child: Stack(
          //       children: <Widget>[
          //         //ACTION ICON

          //         GridView.count(
          //           crossAxisCount: 6,
          //           children: List.generate(6, (index) {
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 17),
          //               child: SvgPicture.asset(
          //                 'assets/player/action/${widget.dsix.gm.getCurrentPlayer().playerAction[index + 1].icon}.svg',
          //                 color: widget.dsix.gm
          //                     .getCurrentPlayer()
          //                     .playerColor
          //                     .primaryColor,
          //               ),
          //             );
          //           }),
          //         ),

          //         //ACTION VALUE

          //         GridView.count(
          //           crossAxisCount: 6,
          //           children: List.generate(6, (index) {
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 5),
          //               child: SvgPicture.asset(
          //                 'assets/player/action/${widget.dsix.gm.getCurrentPlayer().playerAction[index + 1].value}.svg',
          //                 color: Colors.white,
          //               ),
          //             );
          //           }),
          //         ),
          //       ],
          //     ),
          //   ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          flex: 13,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 20, 0, 0),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      child: GridView.count(
                        crossAxisCount: 1,
                        children: List.generate(
                            widget.dsix.gm.getCurrentPlayer().effects.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                showEffect(index);
                              },
                              child: SvgPicture.asset(
                                'assets/player/effect/${widget.dsix.gm.getCurrentPlayer().effects[index].icon}.svg',
                                color: widget.dsix.gm
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              widget.dsix.gm
                                  .getCurrentPlayer()
                                  .playerColor
                                  .name,
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 45,
                                color: widget.dsix.gm
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                letterSpacing: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                              child: Container(
                                height: 30,
                                width: 30,
                                child: SvgPicture.asset(
                                  'assets/player/${widget.dsix.gm.getCurrentPlayer().playerSex}.svg',
                                  color: widget.dsix.gm
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: double.infinity,
                          minWidth: double.infinity,
                          maxHeight: 225,
                          minHeight: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              widget.dsix.gm
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
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              ),
                              onPressed: () {
                                showAlertDialogDescription(context);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
                                    width:
                                        2, //                   <--- border width here
                                  ),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 15, 0),
                                          child: Icon(
                                            Icons.title,
                                            color: widget.dsix.gm
                                                .getCurrentPlayer()
                                                .playerColor
                                                .primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        'EDIT',
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
    );
  }
}

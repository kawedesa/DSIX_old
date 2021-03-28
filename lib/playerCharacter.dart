import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
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
    widget.dsix.getCurrentPlayer().playerBackground.description =
        myController.text;
    Navigator.of(context).pop(true);
  }

  showAlertDialogDescription(BuildContext context) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text(
                    'Write your story',
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
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    autofocus: true,
                    cursorColor:
                        widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                    textAlign: TextAlign.center,
                    onEditingComplete: confirm,
                    onSubmitted: (value) {
                      widget.dsix
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
              child: GestureDetector(
                onTap: () {
                  confirm();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.058,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.dsix
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: SvgPicture.asset(
                              'assets/ui/check.svg',
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.04,
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
        text: widget.dsix.getCurrentPlayer().playerBackground.description);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: SvgPicture.asset(
                          'assets/action/${widget.dsix.getCurrentPlayer().playerAction[index + 1].icon}.svg',
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                        ),
                      );
                    }),
                  ),

                  //ACTION VALUE

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SvgPicture.asset(
                          'assets/action/${widget.dsix.getCurrentPlayer().playerAction[index + 1].value}.svg',
                          color: Colors.white,
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
                padding: const EdgeInsets.fromLTRB(13, 20, 0, 0),
                child: Container(
                  width: 30,
                  child: GridView.count(
                    crossAxisCount: 1,
                    children: List.generate(
                        widget.dsix.getCurrentPlayer().effectList.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/effect/${widget.dsix.getCurrentPlayer().effectList[index].icon}.svg',
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
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
                            widget.dsix.getCurrentPlayer().playerColor.name,
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                            child: Container(
                              height: 30,
                              width: 30,
                              child: SvgPicture.asset(
                                'assets/player/${widget.dsix.getCurrentPlayer().playerSex}.svg',
                                color: widget.dsix
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
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                                  MediaQuery.of(context).size.height * 0.058,
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
                                alignment: AlignmentDirectional.centerEnd,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 10, 0),
                                        child: SvgPicture.asset(
                                          'assets/ui/text.svg',
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

                            // child: Stack(
                            //   children: <Widget>[
                            //     Container(
                            //       width: double.infinity,
                            //       child: Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: <Widget>[
                            //           Padding(
                            //             padding: const EdgeInsets.fromLTRB(
                            //                 0, 12, 12, 0),
                            //             child: SvgPicture.asset(
                            //               'assets/ui/text.svg',
                            //               color: widget.dsix
                            //                   .getCurrentPlayer()
                            //                   .playerColor
                            //                   .primaryColor,
                            //               width: MediaQuery.of(context)
                            //                       .size
                            //                       .width *
                            //                   0.055,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Container(
                            //       width: double.infinity,
                            //       decoration: BoxDecoration(
                            //         border: Border.all(
                            //           color: widget.dsix
                            //               .getCurrentPlayer()
                            //               .playerColor
                            //               .primaryColor,
                            //           width:
                            //               2.5, //                   <--- border width here
                            //         ),
                            //       ),
                            //       child: Padding(
                            //         padding:
                            //             const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            //         child: Center(
                            //           child: Text(
                            //             'EDIT',
                            //             style: TextStyle(
                            //               height: 1.5,
                            //               fontSize: 17,
                            //               fontWeight: FontWeight.bold,
                            //               letterSpacing: 1.5,
                            //               fontFamily: 'Calibri',
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

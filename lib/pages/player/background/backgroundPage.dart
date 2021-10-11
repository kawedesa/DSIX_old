import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/dialogs/descriptionDialog.dart';
import 'package:dsixv02app/widgets/descriptionTitle.dart';
import 'package:dsixv02app/widgets/buttons/goBackButton.dart';
import 'package:dsixv02app/widgets/buttons/nextButton.dart';
import 'package:dsixv02app/widgets/pageTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'backgroundPageVM.dart';
// import 'playerSkillPage.dart';

class BackgroundPage extends StatefulWidget {
  static const String routeName = "/backgroundPage";

  final Dsix dsix;

  const BackgroundPage({Key key, this.dsix}) : super(key: key);

  @override
  _BackgroundPageState createState() => new _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  BackgroundPageVM backgroundPageVM = BackgroundPageVM();
  double nextButtonSize = 0;

  // List<bool> backgroundSelection;

  // showAlertDialog(BuildContext context, int index) {
  //   AlertDialog alerta = AlertDialog(
  //     backgroundColor: Colors.black,
  //     contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color:
  //                   widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
  //               width: 1.5, //                   <--- border width here
  //             ),
  //           ),
  //           width: MediaQuery.of(context).size.width * 0.7,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: <Widget>[
  //               Container(
  //                 color: widget.dsix.gm
  //                     .getCurrentPlayer()
  //                     .playerColor
  //                     .primaryColor,
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
  //                   child: Center(
  //                     child: Text(
  //                       widget.dsix.gm
  //                           .getCurrentPlayer()
  //                           .playerBackground
  //                           .bonus[index]
  //                           .name,
  //                       style: TextStyle(
  //                         fontFamily: 'Santana',
  //                         height: 1,
  //                         fontSize: 25,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         letterSpacing: 3,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
  //                 child: Text(
  //                   widget.dsix.gm
  //                       .getCurrentPlayer()
  //                       .playerBackground
  //                       .bonus[index]
  //                       .description,
  //                   textAlign: TextAlign.justify,
  //                   style: TextStyle(
  //                     height: 1.25,
  //                     fontSize: 19,
  //                     fontFamily: 'Calibri',
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alerta;
  //     },
  //   );
  // }

  // double _size = 0;

  // void _updateState() {
  //   setState(() {
  //     _size = 50;
  //   });
  // }

  // Route _createRouteSkill() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => PlayerSkillPage(
  //       dsix: widget.dsix,
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(1.0, 0.0);
  //       var end = Offset(0.0, 0.0);
  //       var curve = Curves.ease;
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (backgroundPageVM.selector.items.isEmpty) {
      backgroundPageVM.selector.newSelection(
          backgroundPageVM.availableBackgrounds.backgrounds.length);
    }

    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: GoBackButton(
              buttonColor: widget.dsix.getCurrentPlayer().secondaryColor,
            ),
          ),
          titleSpacing: 10,
          backgroundColor: widget.dsix.getCurrentPlayer().primaryColor,
          centerTitle: true,
          title: PageTitle(
            title: 'background',
            color: widget.dsix.getCurrentPlayer().secondaryColor,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: AnimatedContainer(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 400),
                width: nextButtonSize,
                height: nextButtonSize,
                child: NextButton(
                  onTapAction: () async {
                    backgroundPageVM.goToSkillPage(context, widget.dsix);
                  },
                ),
              ),
            ),
          ],
        ),
        body: new SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
                  child: GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              backgroundPageVM.chooseBackground(
                                  widget.dsix.getCurrentPlayer(), index);
                              nextButtonSize =
                                  MediaQuery.of(context).size.width * 0.06;
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/icon/background/${backgroundPageVM.availableBackgrounds.backgrounds[index].icon}.svg',
                            color: backgroundPageVM.selector.items[index]
                                ? widget.dsix.getCurrentPlayer().primaryColor
                                : AppColors.white01,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 2,
                color: widget.dsix.getCurrentPlayer().primaryColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: DescriptionTitle(
                          title: backgroundPageVM.selectedBackground.name,
                          color: widget.dsix.getCurrentPlayer().primaryColor,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Description(
                              description: backgroundPageVM
                                  .selectedBackground.description)),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          itemCount:
                              backgroundPageVM.selectedBackground.bonus.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Button(
                                onTapAction: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DescriptionDialog(
                                        title: backgroundPageVM
                                            .selectedBackground
                                            .bonus[index]
                                            .name,
                                        description: backgroundPageVM
                                            .selectedBackground
                                            .bonus[index]
                                            .description,
                                        color: widget.dsix
                                            .getCurrentPlayer()
                                            .primaryColor,
                                      );
                                    },
                                  );
                                },
                                buttonText: backgroundPageVM
                                    .selectedBackground.bonus[index].name,
                                buttonColor:
                                    widget.dsix.getCurrentPlayer().primaryColor,
                                buttonIcon: 'help',
                                buttonTextColor: AppColors.white01,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

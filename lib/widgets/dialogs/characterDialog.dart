import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/gm/character/character.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CharacterDialog extends StatelessWidget {
  const CharacterDialog({
    @required this.character,
    @required this.gm,
  });

  final Character character;
  final Gm gm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[700],
                  width: 2.5, //                   <--- border width here
                ),
              ),
              width: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    color: Colors.grey[700],
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Center(
                        child: Text(
                          '${this.character.name}'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 33,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ), //ITEM NAME
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: SvgPicture.asset(
                          'assets/icon/sprite/${this.character.icon}.svg',
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),

                  Divider(thickness: 2, color: Colors.grey[700]),

                  // SizedBox(
                  //   height: 30,
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               'assets/gm/sprite/health.svg',
                  //               color: Colors.grey[700],
                  //               width: MediaQuery.of(context).size.width * 0.045,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  //               child: Text(
                  //                 '${this.character.baseHealth}',
                  //                 style: TextStyle(
                  //                   fontFamily: 'Headline',
                  //                   height: 1,
                  //                   fontSize: 15,
                  //                   color: Colors.white,
                  //                   letterSpacing: 3,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               'assets/item/pDamage.svg',
                  //               color: Colors.grey[700],
                  //               width: MediaQuery.of(context).size.width * 0.055,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                  //               child: Text(
                  //                 '${this.character.pDamage}',
                  //                 style: TextStyle(
                  //                   fontFamily: 'Headline',
                  //                   height: 1,
                  //                   fontSize: 15,
                  //                   color: Colors.white,
                  //                   letterSpacing: 3,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               'assets/item/mDamage.svg',
                  //               color: Colors.grey[700],
                  //               width: MediaQuery.of(context).size.width * 0.065,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                  //               child: Text(
                  //                 '${this.character.mDamage}',
                  //                 style: TextStyle(
                  //                   fontFamily: 'Headline',
                  //                   height: 1,
                  //                   fontSize: 15,
                  //                   color: Colors.white,
                  //                   letterSpacing: 3,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               'assets/item/pArmor.svg',
                  //               color: Colors.grey[700],
                  //               width: MediaQuery.of(context).size.width * 0.055,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                  //               child: Text(
                  //                 '${this.character.pArmor}',
                  //                 style: TextStyle(
                  //                   fontFamily: 'Headline',
                  //                   height: 1,
                  //                   fontSize: 15,
                  //                   color: Colors.white,
                  //                   letterSpacing: 3,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               'assets/item/mArmor.svg',
                  //               color: Colors.grey[700],
                  //               width: MediaQuery.of(context).size.width * 0.055,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                  //               child: Text(
                  //                 '${this.character.mArmor}',
                  //                 style: TextStyle(
                  //                   fontFamily: 'Headline',
                  //                   height: 1,
                  //                   fontSize: 15,
                  //                   color: Colors.white,
                  //                   letterSpacing: 3,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Divider(
                    height: 0,
                    thickness: 2,
                    color: Colors.grey[700],
                  ),

                  // OLD DESCRIPTION

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Character newCharacter = this.character.copy();

                        newCharacter.sprite.location = Offset(
                            -gm.navigation.value.row0.a /
                                    gm.navigation.value.row0.r +
                                (MediaQuery.of(context).size.width * 0.45) /
                                    gm.navigation.value.row0.r -
                                newCharacter.sprite.size / 2,
                            -gm.navigation.value.row1.a /
                                    gm.navigation.value.row0.r +
                                (MediaQuery.of(context).size.height * 0.37) /
                                    gm.navigation.value.row0.r -
                                newCharacter.sprite.size / 2);

                        // newCharacter.sprite.location = Offset(
                        //     MediaQuery.of(context).size.width / 2 -
                        //         gm.navigation.value.row0.a /
                        //             gm.navigation.value.row0.r *
                        //             0.8,
                        //     MediaQuery.of(context).size.height / 2 -
                        //         gm.navigation.value.row1.a /
                        //             gm.navigation.value.row0.r *
                        //             0.1);

                        this.gm.enemy.add(newCharacter);
                        this.gm.buildCanvas();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[700],
                            width:
                                1, //                   <--- border width here
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.grey[700],
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                'CHOOSE',
                                style: TextStyle(
                                  fontSize: 16,
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
          ],
        ),
      ),
    );
  }
}

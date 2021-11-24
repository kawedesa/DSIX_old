import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/pages/player/map/playerMapPageVM.dart';
import 'package:dsixv02app/pages/user/players/playersPage.dart';
import 'package:dsixv02app/pages/user/players/playersPageVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthDialog extends StatefulWidget {
  const HealthDialog({
    @required this.player,
    @required this.dsix,
    @required this.gm,
    @required this.color,
  });

  final Player player;
  final Dsix dsix;
  final Gm gm;
  final Color color;

  @override
  State<HealthDialog> createState() => _HealthDialogState();
}

class _HealthDialogState extends State<HealthDialog> {
  PlayersPageVM _playersPageVM = PlayersPageVM();
  PlayerMapPageVM _playerMapPageVM = PlayerMapPageVM();

  void killPlayer() {
    widget.player.alive = false;
    widget.gm.killPlayer(widget.player);

    widget.dsix.resetPlayer(widget.player.index);
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayersPage(
        dsix: widget.dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
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

    Navigator.of(context).push(newRoute).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        color: AppColors.black01,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.color,
                  width: 1.5, //                   <--- border width here
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: widget.color,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                      child: Center(
                        child: Text('HEALTH',
                            style: AppTextStyles.dialogTitleStyle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                this.widget.player.changeHealth(-1);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                AppImages.arrowLeft,
                                color: widget.color,
                              ),
                            ),
                          ),
                          (widget.player.health < 1)
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    killPlayer();
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.grave,
                                    color: AppColors.white01,
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      this.widget.player.health.toString(),
                                      textAlign: TextAlign.justify,
                                      style: AppTextStyles
                                          .healthAndGoldDialogStyle,
                                    ),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                this.widget.player.changeHealth(1);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                AppImages.arrowRight,
                                color: widget.color,
                              ),
                            ),
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
      ),
    );
  }
}

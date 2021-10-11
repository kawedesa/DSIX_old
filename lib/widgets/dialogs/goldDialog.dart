import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoldDialog extends StatefulWidget {
  const GoldDialog({@required this.player, @required this.color});

  final Player player;
  final Color color;

  @override
  State<GoldDialog> createState() => _GoldDialogState();
}

class _GoldDialogState extends State<GoldDialog> {
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
                        child:
                            Text('GOLD', style: AppTextStyles.dialogTitleStyle),
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
                                this.widget.player.changeGold(-50);
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
                          Text(
                            this.widget.player.gold.toString(),
                            textAlign: TextAlign.justify,
                            style: AppTextStyles.healthAndGoldDialogStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                this.widget.player.changeGold(50);
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

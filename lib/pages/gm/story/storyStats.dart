import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryStats extends StatelessWidget {
  const StoryStats(
      {@required this.color,
      @required this.round,
      @required this.xp,
      @required this.gold});

  final Color color;
  final int round;
  final int xp;
  final int gold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(AppImages.story,
                      color: color,
                      width: MediaQuery.of(context).size.width * 0.07),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      '${this.round}',
                      style: AppTextStyles.menuItemStatStyle,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    AppImages.xp,
                    color: color,
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      '${this.xp}',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.menuItemStatStyle,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    AppImages.gold,
                    color: color,
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '${this.gold}',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.menuItemStatStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

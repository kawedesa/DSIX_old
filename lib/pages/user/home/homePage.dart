import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'homePageVM.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageVM homePageVM = HomePageVM();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.64,
              height: MediaQuery.of(context).size.width * 0.64,
              child: SvgPicture.asset(
                AppImages.logo,
                color: AppColors.logoColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Button(
              buttonText: 'play',
              buttonIcon: 'right',
              onTapAction: () async {
                homePageVM.goToPlayersPage(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstructionMenu extends StatelessWidget {
  InstructionMenu(
      {this.instruction,
      this.subTitle,
      this.action,
      this.nextStep,
      this.ready});

  final String instruction;
  final String subTitle;
  final Function() action;
  final Function() nextStep;
  bool ready;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (this.ready)
            ? GestureDetector(
                onTap: () async {
                  this.nextStep();
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.separatorBlack,
                  child: SvgPicture.asset(
                    AppImages.confirmButton,
                    width: 50,
                    height: 50,
                    color: AppColors.success,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  this.action();
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.separatorBlack,
                  child: SvgPicture.asset(
                    AppImages.addButton,
                    width: 50,
                    height: 50,
                    color: AppColors.neutral05,
                  ),
                ),
              ),
        Container(
            color: AppColors.separatorBlack,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Description(description: this.instruction),
                  (this.subTitle == null)
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: SubTitle(text: '${this.subTitle}'),
                        ),
                ],
              ),
            )),
      ],
    );
  }
}

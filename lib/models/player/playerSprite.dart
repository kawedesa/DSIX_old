// ignore_for_file: must_be_immutable

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerSprite extends StatefulWidget {
  PlayerSprite({
    this.mode,
    @required this.image,
    @required this.color,
    @required this.size,
    this.visionRange,
    this.walkRange,
    this.attackRange,
    this.location,
    this.updateLocation,
    this.refresh,
    this.playerActions,
  });
  String mode;
  List<Widget> image;
  final Color color;
  double size;
  double visionRange;
  double walkRange;
  double attackRange;
  Offset location;
  final Function(Offset) updateLocation;
  Function() refresh;
  List<PlayerAction> playerActions;

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  Widget spriteBody;

  Offset originalLocation;

  double checkWalkDistance() {
    double distance = widget.walkRange -
        (originalLocation - widget.location).distance * 2 +
        2;
    if (distance < 0) {
      distance = widget.walkRange;
    }

    return distance;
  }

  @override
  Widget build(BuildContext context) {
    if (originalLocation == null) {
      originalLocation = widget.location;
    }

    switch (widget.mode) {
      case 'wait':
        spriteBody = Positioned(
          left: widget.location.dx - widget.visionRange / 2 + widget.size / 2,
          top: widget.location.dy - widget.visionRange / 2 + widget.size / 2,
          child: DottedBorder(
            dashPattern: [6, 12],
            borderType: BorderType.Circle,
            color: AppColors.rangeOutline,
            strokeWidth: 1,
            child: Container(
              width: widget.visionRange,
              height: widget.visionRange,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      child: Stack(
                        children: widget.image,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        break;

      case 'walk':
        {
          spriteBody = Positioned(
            left: widget.location.dx - widget.visionRange / 2 + widget.size / 2,
            top: widget.location.dy - widget.visionRange / 2 + widget.size / 2,
            child: TransparentPointer(
              child: DottedBorder(
                dashPattern: [6, 12],
                borderType: BorderType.Circle,
                color: AppColors.rangeOutline,
                strokeWidth: 1,
                child: Container(
                  width: widget.visionRange,
                  height: widget.visionRange,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: checkWalkDistance(),
                          height: checkWalkDistance(),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (checkWalkDistance() < widget.walkRange - 5)
                                ? AppColors.walkRangeActive
                                : AppColors.walkRange,
                            border: Border.all(
                              color: AppColors.rangeOutline,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.mode = 'menu';
                              });
                            },
                            onPanEnd: (details) {
                              setState(() {
                                originalLocation = widget.location;
                                widget.refresh();
                              });
                            },
                            onPanStart: (details) {
                              originalLocation = widget.location;
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                if ((originalLocation - widget.location)
                                        .distance <
                                    widget.walkRange / 2) {
                                  widget.updateLocation(details.delta);
                                  widget.location = Offset(
                                      widget.location.dx + details.delta.dx,
                                      widget.location.dy + details.delta.dy);
                                }
                              });
                            },
                            child: Stack(
                              children: widget.image,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        break;

      case 'menu':
        {
          spriteBody = Positioned(
            left: widget.location.dx - widget.visionRange / 2 + widget.size / 2,
            top: widget.location.dy - widget.visionRange / 2 + widget.size / 2,
            child: Container(
              width: widget.visionRange + 4,
              height: widget.visionRange + 4,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.mode = 'walk';
                        });
                      },
                      child: Container(
                        width: widget.size,
                        height: widget.size,
                        child: Stack(
                          children: widget.image,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 125,
                      height: 125,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.mode = 'attack';
                                });
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/icon/action/${widget.playerActions[0].name}.svg',
                                    color: AppColors.white01,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: widget.color,
                                  shape: BoxShape.circle,
                                ),
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
          );
        }
        break;

      case 'attack':
        {
          spriteBody = Positioned(
            left: widget.location.dx - widget.visionRange / 2 + widget.size / 2,
            top: widget.location.dy - widget.visionRange / 2 + widget.size / 2,
            child: TransparentPointer(
              child: Container(
                width: widget.visionRange + 4,
                height: widget.visionRange + 4,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: widget.attackRange + widget.size,
                        height: widget.attackRange + widget.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(250, 25, 25, 0.15),
                          border: Border.all(
                            color: AppColors.rangeOutline,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.mode = 'menu';
                          });
                        },
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          child: Stack(
                            children: widget.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        break;
    }

    return spriteBody;
  }
}

// ignore_for_file: must_be_immutable

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerSprite extends StatefulWidget {
  PlayerSprite({
    @required this.image,
    @required this.size,
    this.visionRange,
    this.location,
    this.updateLocation,
    this.walkRange,
    this.playerTurn,
    this.refresh,
    @required this.color,
    this.drag,
    this.playerActions,
    this.search,
  });

  List<Widget> image;
  double size;
  double visionRange;
  double walkRange;
  Function() playerTurn;
  Function() refresh;
  Offset location;
  final Color color;
  bool drag;
  Function() search;
  List<PlayerAction> playerActions;

  final Function(Offset) updateLocation;

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  Offset originalLocation;

  Widget menu = Container();
  bool menuOpen = false;

  double checkWalkDistance() {
    double distance =
        widget.walkRange - (originalLocation - widget.location).distance + 1;
    if (distance < 0) {
      distance = 0;
    }

    return distance;
  }

  void openMenu(bool open) {
    if (open) {
      menu = Container(
        width: 125,
        height: 125,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.search();
                    menuOpen = false;
                    openMenu(menuOpen);
                    widget.refresh();
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          'assets/icon/action/${widget.playerActions[2].value}.svg',
                          color: AppColors.white01,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/icon/action/${widget.playerActions[2].name}.svg',
                          color: AppColors.white01,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.color,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      menu = Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.location == null) {
      widget.location = Offset(0, 0);
    }
    if (originalLocation == null) {
      originalLocation = widget.location;
    }

    return Positioned(
      left: widget.location.dx - widget.visionRange / 2 + widget.size / 2,
      top: widget.location.dy - widget.visionRange / 2 + widget.size / 2,
      child: GestureDetector(
        onTap: (widget.drag)
            ? () {
                setState(() {
                  if (menuOpen) {
                    menuOpen = false;
                    openMenu(menuOpen);
                  } else {
                    menuOpen = true;
                    openMenu(menuOpen);
                  }
                });
              }
            : () {},
        onPanEnd: (details) {
          setState(() {
            if ((originalLocation - widget.location).distance > 5) {
              widget.playerTurn();
              widget.refresh();
            }
            originalLocation = widget.location;
          });
        },
        onPanStart: (details) {
          originalLocation = widget.location;
        },
        onPanUpdate: (widget.drag)
            ? (details) {
                setState(() {
                  if ((originalLocation - widget.location).distance <
                      widget.walkRange) {
                    widget.updateLocation(details.delta);
                    widget.location = Offset(
                        widget.location.dx + details.delta.dx,
                        widget.location.dy + details.delta.dy);
                  }
                });
              }
            : (details) {},
        child: Container(
          width: widget.visionRange,
          height: widget.visionRange,
          decoration: (menuOpen == false)
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.selected,
                    width: 1,
                  ),
                )
              : BoxDecoration(
                  shape: BoxShape.circle,
                ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: checkWalkDistance(),
                  height: checkWalkDistance(),
                  decoration: (widget.drag && menuOpen == false)
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.separator,
                          border: Border.all(
                            color: AppColors.selected,
                            width: 0.5,
                          ),
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                ),
              ),
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
              Align(alignment: Alignment.center, child: menu),
            ],
          ),
        ),
      ),
    );
  }
}

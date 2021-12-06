import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spriteImage.dart';

// ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  PlayerTemporaryLocation location;
  Player player;
  bool isPlayerTurn;
  String mode;

  PlayerSprite({
    Key key,
    @required this.location,
    @required this.player,
    @required this.isPlayerTurn,
  }) : super(key: key);

  @override
  _PlayerSpriteState createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  void checkPlayerTurn() {
    if (widget.isPlayerTurn) {
      widget.mode = 'walk';
    } else {
      widget.mode = 'wait';
    }
  }

  Offset spriteCustomOffsetBasedOnVisionRange() {
    return Offset(widget.location.dx - widget.player.vision / 2,
        widget.location.dy - widget.player.vision / 2);
  }

  double totalWalkedDistance() {
    double totalWalkDistance = (Offset(widget.location.dx, widget.location.dy) -
                Offset(widget.player.dx, widget.player.dy))
            .distance *
        2;

    if (widget.player.walkRange - totalWalkDistance < 0) {
      totalWalkDistance = 0;
    } else {
      totalWalkDistance = widget.player.walkRange - totalWalkDistance;
    }
    return totalWalkDistance;
  }

  @override
  Widget build(BuildContext context) {
    final dsix = Provider.of<Dsix>(context);
    final players = Provider.of<List<Player>>(context);
    final turnOrder = Provider.of<List<Turn>>(context);

    checkPlayerTurn();
    return PlayerSpriteMode(
      mode: widget.mode,
      spriteCustomOffset: spriteCustomOffsetBasedOnVisionRange(),
      vision: widget.player.vision,
      walkRange: totalWalkedDistance(),
      startWalking: () {},
      walking: (details) {
        if (totalWalkedDistance() > 0) {
          widget.location
              .changePlayerLocation(details.delta.dx, details.delta.dy);
        }
      },
      onWalkEnd: () {
        dsix.updateSelectedPlayerLocation(
            widget.location.dx, widget.location.dy, widget.player.id);
        widget.mode = 'wait';
        dsix.takeTurn(turnOrder, players, widget.player.id);
      },
      image: widget.player.race,
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteMode extends StatefulWidget {
  Widget rigg;
  String mode;
  Offset spriteCustomOffset;
  double vision;
  double walkRange;
  Function() startWalking;
  Function(DragUpdateDetails) walking;
  Function() onWalkEnd;
  String image;
  PlayerSpriteMode(
      {Key key,
      @required this.mode,
      @required this.spriteCustomOffset,
      @required this.vision,
      @required this.walkRange,
      this.startWalking,
      this.walking,
      this.onWalkEnd,
      @required this.image})
      : super(key: key);

  @override
  State<PlayerSpriteMode> createState() => _PlayerSpriteModeState();
}

class _PlayerSpriteModeState extends State<PlayerSpriteMode> {
  @override
  Widget build(BuildContext context) {
    switch (this.widget.mode) {
      case 'walk':
        widget.rigg = Positioned(
          left: widget.spriteCustomOffset.dx,
          top: widget.spriteCustomOffset.dy,
          child: SizedBox(
            width: widget.vision,
            height: widget.vision,
            child: Stack(
              children: [
                VisionRange(vision: widget.vision),
                Align(
                  alignment: Alignment.center,
                  child: WalkRange(
                    walkRange: widget.walkRange,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            widget.walking(details);
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            widget.onWalkEnd();
                          });
                        },
                        child: SpriteImage(image: widget.image)),
                  ),
                )
              ],
            ),
          ),
        );
        break;

      case 'wait':
        widget.rigg = Positioned(
          left: widget.spriteCustomOffset.dx,
          top: widget.spriteCustomOffset.dy,
          child: SizedBox(
            width: widget.vision,
            height: widget.vision,
            child: Stack(
              children: [
                VisionRange(vision: widget.vision),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                        child: SpriteImage(image: widget.image)),
                  ),
                )
              ],
            ),
          ),
        );
        break;
    }
    return widget.rigg;
  }
}

// ignore: must_be_immutable
class WalkRange extends StatelessWidget {
  double walkRange;

  WalkRange({
    Key key,
    this.walkRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: walkRange,
      height: walkRange,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.playerShadow00,
        border: Border.all(
          color: AppColors.playerRange00,
          width: 0.5,
        ),
      ),
    );
  }
}

class VisionRange extends StatelessWidget {
  final double vision;
  const VisionRange({Key key, this.vision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [2, 4],
      borderType: BorderType.Circle,
      color: AppColors.grey07.withAlpha(75),
      strokeWidth: 0.5,
      child: SizedBox(
        width: vision,
        height: vision,
      ),
    );
  }
}

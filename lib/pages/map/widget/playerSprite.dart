import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spriteImage.dart';

// ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  PlayerTemporaryLocation newLocation;
  Player player;

  PlayerSprite({
    Key key,
    @required this.newLocation,
    @required this.player,
  }) : super(key: key);

  @override
  _PlayerSpriteState createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  Offset calculateSpritePosition() {
    return Offset(widget.newLocation.dx - widget.player.vision / 2,
        widget.newLocation.dy - widget.player.vision / 2);
  }

  double calculateWalkedDistance() {
    double totalWalkDistance =
        (Offset(widget.newLocation.dx, widget.newLocation.dy) -
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
    return PlayerSpriteMode(
      playerID: widget.player.id,
      newLocation: widget.newLocation,
      spritePosition: calculateSpritePosition(),
      vision: widget.player.vision,
      walkRange: calculateWalkedDistance(),
      image: widget.player.race,
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteMode extends StatefulWidget {
  final String playerID;
  PlayerTemporaryLocation newLocation;
  Offset spritePosition;
  double vision;
  double walkRange;
  String image;

  PlayerSpriteMode({
    Key key,
    this.playerID,
    this.newLocation,
    this.spritePosition,
    this.vision,
    this.walkRange,
    this.image,
  }) : super(key: key);

  @override
  _PlayerSpriteModeState createState() => _PlayerSpriteModeState();
}

class _PlayerSpriteModeState extends State<PlayerSpriteMode> {
  String chooseMode(List<Turn> round) {
    if (round.first.id != widget.playerID) {
      return 'wait';
    } else {
      return 'walk';
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final round = Provider.of<List<Turn>>(context);
    switch (chooseMode(round)) {
      case 'walk':
        return PlayerSpriteWalkMode(
          playerID: widget.playerID,
          newLocation: widget.newLocation,
          spritePosition: widget.spritePosition,
          vision: widget.vision,
          walkRange: widget.walkRange,
          image: widget.image,
        );
        break;
      case 'wait':
        return PlayerSpriteWaitMode(
          playerID: widget.playerID,
          newLocation: widget.newLocation,
          spritePosition: widget.spritePosition,
          vision: widget.vision,
          walkRange: 8,
          image: widget.image,
        );
        break;
    }
  }
}

// ignore: must_be_immutable
class PlayerSpriteWaitMode extends StatelessWidget {
  String playerID;
  PlayerTemporaryLocation newLocation;
  Offset spritePosition;
  double vision;
  double walkRange;
  String image;

  PlayerSpriteWaitMode({
    Key key,
    @required this.playerID,
    @required this.newLocation,
    @required this.spritePosition,
    @required this.vision,
    @required this.walkRange,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: this.spritePosition.dx,
      top: this.spritePosition.dy,
      child: SizedBox(
        width: this.vision,
        height: this.vision,
        child: Stack(
          children: [
            VisionRange(playerID: this.playerID, vision: this.vision),
            Align(
              alignment: Alignment.center,
              child: WalkRange(
                playerID: this.playerID,
                walkRange: this.walkRange,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: GestureDetector(
                    onTap: () {}, child: SpriteImage(image: image)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteWalkMode extends StatelessWidget {
  String playerID;

  PlayerTemporaryLocation newLocation;
  Offset spritePosition;
  double vision;
  double walkRange;
  String image;

  PlayerSpriteWalkMode({
    Key key,
    @required this.playerID,
    @required this.newLocation,
    @required this.spritePosition,
    @required this.vision,
    @required this.walkRange,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dsix = Provider.of<Dsix>(context);
    final round = Provider.of<List<Turn>>(context);
    final players = Provider.of<List<Player>>(context);

    return Positioned(
      left: this.spritePosition.dx,
      top: this.spritePosition.dy,
      child: SizedBox(
        width: this.vision,
        height: this.vision,
        child: Stack(
          children: [
            VisionRange(playerID: this.playerID, vision: this.vision),
            Align(
              alignment: Alignment.center,
              child: WalkRange(
                playerID: this.playerID,
                walkRange: this.walkRange,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: GestureDetector(
                    onTap: () {},
                    onPanUpdate: (walkRange < 1)
                        ? (details) {}
                        : (details) {
                            newLocation.changePlayerLocation(
                                details.delta.dx, details.delta.dy);
                          },
                    onPanEnd: (details) {
                      dsix.updateSelectedPlayerLocation(
                          newLocation.dx, newLocation.dy, playerID);
                      dsix.takeTurn(round, players);
                    },
                    child: SpriteImage(image: image)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WalkRange extends StatelessWidget {
  String playerID;
  double walkRange;

  WalkRange({
    Key key,
    @required this.playerID,
    @required this.walkRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return Container(
      width: walkRange,
      height: walkRange,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _uiColor
            .setUIColor(playerID, 'shadow')
            .withAlpha(75 - walkRange.floor()),
        border: Border.all(
          color: _uiColor.setUIColor(playerID, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VisionRange extends StatelessWidget {
  String playerID;
  double vision;
  VisionRange({Key key, @required this.playerID, @required this.vision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    return Container(
      width: vision,
      height: vision,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _uiColor.setUIColor(playerID, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}

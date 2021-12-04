import 'package:dsixv02app/core/app_Characters.dart';
import 'package:dsixv02app/core/app_Maps.dart';
import 'package:dsixv02app/core/widgets/goToPageButton.dart';
import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/mapPageVM.dart';
import 'package:dsixv02app/pages/playerSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    MapPageVM _mapPageVM = MapPageVM();
    final listOfPlayers = Provider.of<List<Player>>(context);
    final dsix = Provider.of<Dsix>(context);
    if (_mapPageVM.canvasController == null) {
      _mapPageVM.setCanvasController(
          context,
          listOfPlayers[dsix.selectedPlayerIndex].dx,
          listOfPlayers[dsix.selectedPlayerIndex].dy);
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GoToPagePageButton(
            goToPage: PlayerSelectionPage(),
            buttonColor:
                listOfPlayers[dsix.selectedPlayerIndex].color.secondary,
          ),
        ),
        backgroundColor: listOfPlayers[dsix.selectedPlayerIndex].color.primary,
      ),
      body: SafeArea(
        child:
            ChangeNotifierProxyProvider<List<Player>, PlayerTemporaryLocation>(
          create: (context) => PlayerTemporaryLocation(),
          update: (context, __, playerNotifier) => playerNotifier
            ..updatePlayerSprite(
              listOfPlayers[dsix.selectedPlayerIndex].dx,
              listOfPlayers[dsix.selectedPlayerIndex].dy,
            ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: InteractiveViewer(
              transformationController: _mapPageVM.canvasController,
              constrained: false,
              panEnabled: true,
              maxScale: _mapPageVM.maxZoom,
              minScale: _mapPageVM.minZoom,
              child: Stack(
                children: [
                  AppMaps.crossroads,
                  Consumer<PlayerTemporaryLocation>(
                      builder: (context, playerNotifier, ___) {
                    return Positioned(
                      left: playerNotifier.dx,
                      top: playerNotifier.dy,
                      child: GestureDetector(
                        onTap: () {},
                        onPanUpdate: (details) {
                          playerNotifier.changePlayerLocation(
                              details.delta.dx, details.delta.dy);
                        },
                        onPanEnd: (details) {
                          dsix.updateSelectedPlayerLocation(
                              playerNotifier.dx,
                              playerNotifier.dy,
                              listOfPlayers[dsix.selectedPlayerIndex].id);
                        },
                        child: Stack(
                          children: [AppCharacters.dwarf],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  PlayerTemporaryLocation location;
  Dsix dsix;
  PlayerSprite({Key key, this.location, this.dsix}) : super(key: key);

  @override
  _PlayerSpriteState createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: GestureDetector(
        onTap: () {},
        onPanUpdate: (details) {
          widget.location
              .changePlayerLocation(details.delta.dx, details.delta.dy);
        },
        onPanEnd: (details) {
          widget.dsix.updateSelectedPlayerLocation(
              widget.location.dx,
              widget.location.dy,
              widget.dsix.listOfPlayers[widget.dsix.selectedPlayerIndex].id);
        },
        child: Stack(
          children: [AppCharacters.dwarf],
        ),
      ),
    );
  }
}

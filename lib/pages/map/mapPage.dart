import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/gameMap.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/map/widget/mapTile.dart';
import 'package:dsixv02app/pages/playerSelection/playerSelectionPage.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/pages/shared/widgets/goToPageButton.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'canvas.dart';
import 'widget/playerSprite.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key key,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  AppCanvas _canvas = AppCanvas();
  UIColor _uiColor = UIColor();

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<Player>>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final dsix = Provider.of<Dsix>(context);
    final map = Provider.of<GameMap>(context);
    if (turnOrder.isEmpty) {
      dsix.newTurnOrder(players);
    }

    _canvas.updateEnemiesAroundPlayer(
        players, players[dsix.selectedPlayerIndex]);
    _canvas.updateCanvasController(
        context,
        players[dsix.selectedPlayerIndex].dx,
        players[dsix.selectedPlayerIndex].dy);

    return Scaffold(
      backgroundColor: AppColors.black00,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        leading: GoToPagePageButton(
          goToPage: PlayerSelectionPage(),
          buttonColor: _uiColor.setUIColor(
              players[dsix.selectedPlayerIndex].id, 'secondary'),
        ),
        backgroundColor: _uiColor.setUIColor(
            players[dsix.selectedPlayerIndex].id, 'primary'),
      ),
      body: SafeArea(
        child:
            ChangeNotifierProxyProvider<List<Player>, PlayerTemporaryLocation>(
          create: (context) => PlayerTemporaryLocation(),
          update: (context, __, playerLocation) => playerLocation
            ..updatePlayerSprite(
              players[dsix.selectedPlayerIndex].dx,
              players[dsix.selectedPlayerIndex].dy,
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.86,
                child: InteractiveViewer(
                  transformationController: _canvas.canvasController,
                  constrained: false,
                  panEnabled: true,
                  maxScale: _canvas.maxZoom,
                  minScale: _canvas.minZoom,
                  child: SizedBox(
                    width: map.mapSize,
                    height: map.mapSize,
                    child: Stack(
                      children: [
                        MapTile(
                          name: map.map,
                        ),
                        Stack(
                          children: _canvas.enemy,
                        ),
                        Consumer<PlayerTemporaryLocation>(
                            builder: (context, playerLocation, ___) {
                          return PlayerSprite(
                            location: playerLocation,
                            player: players[dsix.selectedPlayerIndex],
                            isPlayerTurn: dsix.checkPlayerTurn(
                                turnOrder, players[dsix.selectedPlayerIndex]),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                height: 2,
                color: _uiColor.setUIColor(
                    players[dsix.selectedPlayerIndex].id, 'primary'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: turnOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              dsix.changeToPlayer(players, turnOrder[index].id);
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.03,
                            height: MediaQuery.of(context).size.height * 0.03,
                            color: _uiColor.setUIColor(
                                turnOrder[index].id, 'primary'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                height: 2,
                color: _uiColor.setUIColor(
                    players[dsix.selectedPlayerIndex].id, 'primary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

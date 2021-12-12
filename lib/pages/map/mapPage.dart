import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/models/turnOrder.dart';
import 'package:dsixv02app/models/user.dart';
import 'package:dsixv02app/pages/map/widget/mapTile.dart';
import 'package:dsixv02app/pages/map/widget/playerMenu.dart';
import 'package:dsixv02app/pages/playerSelection/playerSelectionPage.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/pages/shared/app_Icons.dart';
import 'package:dsixv02app/pages/shared/widgets/goToPageButton.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'mapPageVM.dart';
import 'widget/playerSprite.dart';

// ignore: must_be_immutable
class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapPageVM _mapPageVM = MapPageVM();
  UIColor _uiColor = UIColor();

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final user = Provider.of<User>(context);

    _mapPageVM.checkForEndGame(
      context,
      players,
      players[user.selectedPlayerIndex],
    );
    turnController.passTurnForDeadPlayers(turnOrder, players, user);
    turnController.checkForNewTurn(turnOrder, players);

    user.setPlayerModeBasedOnPlayerTurn(
        turnController.isPlayerTurn(turnOrder, user.selectedPlayer.id));
    _mapPageVM.updateEnemyPlayersInSight(
        players, players[user.selectedPlayerIndex]);
    _mapPageVM.createCanvasController(
        context, user.selectedPlayer.dx, user.selectedPlayer.dy);

    return Scaffold(
      backgroundColor: AppColors.black00,
      appBar: AppBar(
        actions: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SvgPicture.asset(
                  AppIcons.life,
                  height: MediaQuery.of(context).size.height * 0.045,
                  color:
                      _uiColor.setUIColor(user.selectedPlayer.id, 'secondary'),
                ),
              ),
              Text(
                '${players[user.selectedPlayerIndex].life}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 27,
                  color:
                      _uiColor.setUIColor(user.selectedPlayer.id, 'secondary'),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 2, 0),
                child: SvgPicture.asset(
                  AppIcons.weight,
                  height: MediaQuery.of(context).size.height * 0.045,
                  color:
                      _uiColor.setUIColor(user.selectedPlayer.id, 'secondary'),
                ),
              ),
              Text(
                '${players[user.selectedPlayerIndex].weight}/${players[user.selectedPlayerIndex].maxWeight}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 27,
                  color:
                      _uiColor.setUIColor(user.selectedPlayer.id, 'secondary'),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              )
            ],
          ),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        leading: GoToPagePageButton(
          goToPage: PlayerSelectionPage(),
          buttonColor: _uiColor.setUIColor(user.selectedPlayer.id, 'secondary'),
        ),
        backgroundColor: _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
      ),
      body: SafeArea(
        child:
            ChangeNotifierProxyProvider<List<Player>, PlayerTemporaryLocation>(
          create: (context) => PlayerTemporaryLocation(),
          update: (context, __, playerLocation) => playerLocation
            ..updatePlayerLocation(
              user.selectedPlayer.dx,
              user.selectedPlayer.dy,
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.86,
                child: Stack(
                  children: [
                    InteractiveViewer(
                      transformationController: _mapPageVM.canvasController,
                      constrained: false,
                      panEnabled: true,
                      maxScale: _mapPageVM.maxZoom,
                      minScale: _mapPageVM.minZoom,
                      child: SizedBox(
                        width: game.mapSize,
                        height: game.mapSize,
                        child: Stack(
                          children: [
                            MapTile(
                              name: game.map,
                            ),
                            Stack(
                              children: _mapPageVM.enemy,
                            ),
                            Consumer<PlayerTemporaryLocation>(
                                builder: (context, playerLocation, ___) {
                              return PlayerSprite(
                                refresh: () => refresh(),
                                temporaryLocation: playerLocation,
                                player: user.selectedPlayer,
                              );
                            }),
                            PlayerMenu(
                              user: user,
                              refresh: () => refresh(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: _mapPageVM.temporaryUI,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                height: 2,
                color: _uiColor.setUIColor(
                    players[user.selectedPlayerIndex].id, 'primary'),
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
                        child: TurnButton(
                          onDoubleTap: () async {
                            user.changeSelectPlayer(
                                players, turnOrder[index].id);

                            user.setPlayerModeBasedOnPlayerTurn(
                                turnController.isPlayerTurn(
                                    turnOrder, user.selectedPlayer.id));
                            _mapPageVM.goToPlayer(context, user.selectedPlayer);
                            _mapPageVM.updateCanvasController(context,
                                user.selectedPlayer.dx, user.selectedPlayer.dy);
                            refresh();
                          },
                          color: _uiColor.setUIColor(
                              turnOrder[index].id, 'primary'),
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
                    players[user.selectedPlayerIndex].id, 'primary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TurnButton extends StatelessWidget {
  final Function() onDoubleTap;
  final Color color;
  const TurnButton({
    Key key,
    this.onDoubleTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        onDoubleTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.03,
        height: MediaQuery.of(context).size.height * 0.03,
        child: SvgPicture.asset(
          AppIcons.turn,
          color: color,
        ),
      ),
    );
  }
}

class Effects {
  List<Widget> effects = [];

  void newDamageEffect(int damage, Offset location) {
    Widget newDamageEffect = Positioned(
        left: location.dx,
        top: location.dy,
        child: DamageEffect(
          damage: damage,
        ));

    this.effects.add(newDamageEffect);
  }

  void clearEffects() {
    this.effects = [];
  }
}

class DamageEffect extends StatefulWidget {
  final int damage;
  const DamageEffect({
    Key key,
    @required this.damage,
  }) : super(key: key);

  @override
  _DamageEffectState createState() => _DamageEffectState();
}

class _DamageEffectState extends State<DamageEffect> {
  Artboard _artboard;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/damage.riv');
    final file = RiveFile.import(bytes);
    setState(() {
      _artboard = file.mainArtboard;
      _playDamageAnimation(widget.damage);
    });
  }

  _playDamageAnimation(int damage) {
    _artboard.addController(SimpleAnimation(
      '$damage',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 20,
      child: Rive(
        artboard: _artboard,
        fit: BoxFit.fill,
      ),
    );
  }
}

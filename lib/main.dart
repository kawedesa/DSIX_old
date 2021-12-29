import 'package:dsixv02app/models/game/gameController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/enemy/enemyController.dart';
import 'models/game/game.dart';
import 'models/loot/loot.dart';
import 'models/loot/lootController.dart';
import 'models/player/player.dart';
import 'models/player/playersController.dart';
import 'models/player/user.dart';
import 'models/turn/turn.dart';
import 'models/turn/turnController.dart';
import 'pages/battleRoyaleSettings/battleRoyaleSettingsPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameController gameController = GameController();
    PlayersController playerController = PlayersController();
    TurnController turnController = TurnController();
    LootController lootController = LootController();
    EnemyController enemyController = EnemyController();
    User user = User();

    return MultiProvider(
      providers: [
        // //Controllers
        Provider(create: (context) => gameController),
        Provider(create: (context) => playerController),
        Provider(create: (context) => turnController),
        Provider(create: (context) => lootController),
        Provider(create: (context) => enemyController),
        Provider(create: (context) => user),

        // Streams
        StreamProvider<Game>(
          initialData: Game.newEmptyGame(),
          create: (context) => gameController.pullGameFromDataBase(),
        ),

        StreamProvider<List<Player>>(
          initialData: [],
          create: (context) =>
              playerController.pullPlayersFromDataBase(gameController.gameID),
        ),

        StreamProvider<List<Turn>>(
          initialData: [],
          create: (context) =>
              turnController.pullTurnOrderFromDataBase(gameController.gameID),
        ),
        StreamProvider<List<Loot>>(
          initialData: [],
          create: (context) =>
              lootController.pullLootFromDataBase(gameController.gameID),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BattleRoyaleSettingsPage(),
      ),
    );
  }
}

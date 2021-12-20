import 'package:dsixv02app/models/gameController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/enemy/enemyController.dart';
import 'models/game.dart';
import 'models/loot/loot.dart';
import 'models/loot/lootController.dart';
import 'models/player/player.dart';
import 'models/player/playerController.dart';
import 'models/turnOrder/turn.dart';
import 'models/player/user.dart';
import 'models/turnOrder/turnController.dart';
import 'pages/settings/battleRoyaleSettingsPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameController gameController = GameController();
    PlayerController playerController = PlayerController();
    TurnController turnController = TurnController();
    LootController lootController = LootController();
    EnemyController enemyController = EnemyController();
    User user = User();

    return MultiProvider(
      providers: [
        //Controllers
        Provider(create: (context) => gameController),
        Provider(create: (context) => playerController),
        Provider(create: (context) => turnController),
        Provider(create: (context) => lootController),
        Provider(create: (context) => enemyController),
        Provider(create: (context) => user),

        //Streams
        StreamProvider<Game>(
          initialData: Game(map: '', mapSize: 0.0),
          create: (context) => gameController.pullGameFromDataBase(),
        ),
        StreamProvider<List<Player>>(
          initialData: [],
          create: (context) => playerController.pullPlayersFromDataBase(),
        ),
        StreamProvider<List<Turn>>(
          initialData: [],
          create: (context) => turnController.pullTurnOrderFromDataBase(),
        ),
        StreamProvider<List<Loot>>(
          initialData: [],
          create: (context) => lootController.pullLootFromDataBase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BattleRoyaleSettingsPage(),
      ),
    );
  }
}

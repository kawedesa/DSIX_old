import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/game.dart';
import 'models/player.dart';
import 'models/turnOrder.dart';
import 'models/user.dart';
import 'pages/settings/battleRoyaleSettingsPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Game game = Game();
    PlayerManager playerManager = PlayerManager();
    TurnManager turnManager = TurnManager();
    User user = User();

    return MultiProvider(
      providers: [
        StreamProvider<Game>(
          initialData: Game(map: '', mapSize: 0.0),
          create: (context) => game.pullGameFromDataBase(),
        ),
        Provider(create: (context) => playerManager),
        StreamProvider<List<Player>>(
          initialData: [],
          create: (context) => playerManager.pullPlayersFromDataBase(),
        ),
        Provider(create: (context) => turnManager),
        StreamProvider<List<Turn>>(
          initialData: [],
          create: (context) => turnManager.pullTurnOrderFromDataBase(),
        ),
        Provider(create: (context) => user),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BattleRoyaleSettingsPage(),
      ),
    );
  }
}

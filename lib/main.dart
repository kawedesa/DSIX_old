import 'package:dsixv02app/models/dsix.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/gameMap.dart';
import 'models/player.dart';
import 'pages/settings/battleRoyaleSettingsPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Dsix dsix = Dsix();

    return MultiProvider(
      providers: [
        StreamProvider<List<Player>>(
          initialData: [],
          create: (context) => dsix.pullPlayersFromDataBase(),
        ),
        StreamProvider<GameMap>(
          initialData: GameMap(map: '', mapSize: 0.0),
          create: (context) => dsix.pullMapFromDataBase(),
        ),
        StreamProvider<List<Turn>>(
          initialData: [],
          create: (context) => dsix.pullTurnOrderFromDataBase(),
        ),
        Provider(create: (context) => dsix),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BattleRoyaleSettingsPage(),
      ),
    );
  }
}

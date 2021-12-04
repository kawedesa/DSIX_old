import 'package:dsixv02app/models/dsix.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/player.dart';
import 'pages/battleRoyaleSettingsPage.dart';

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
          create: (context) => dsix.getAvailablePlayers(),
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

import 'package:flutter/material.dart';
import 'pages/user/home/homePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: HomePage()),
      ),
    );
  }
}

import 'package:dsixv02app/models/dsix/dsixUser.dart';
import 'package:dsixv02app/models/service/auth.dart';
import 'package:dsixv02app/models/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dsixv02app/pages/wrapperPage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: StreamProvider<DsixUser>.value(
            initialData: null,
            value: AuthService().user,
            child: FutureBuilder(
              // Initialize FlutterFire:
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Container(
                    child: Text('Something went wrong!'),
                  );
                }

                // Once complete, show your application
                if (snapshot.hasData) {
                  return WrapperPage();
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return Center(
                  child: Loading(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

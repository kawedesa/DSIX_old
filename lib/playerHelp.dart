import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';

class HelpPage extends StatefulWidget {
  final Dsix dsix;

  const HelpPage({Key key, this.dsix}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

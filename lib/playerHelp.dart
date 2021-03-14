import 'package:flutter/material.dart';
import 'player.dart';


class HelpPage extends StatefulWidget {

  final Player player;

  const HelpPage({Key key, this.player}) : super(key: key);

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
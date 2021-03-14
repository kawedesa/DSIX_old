import 'package:flutter/material.dart';

import 'storyPage.dart';
import 'threatPage.dart';
import 'lootPage.dart';
import 'npcPage.dart';

class GmPage extends StatefulWidget {
  GmPage({Key key}) : super(key: key);


  static const String routeName = "/gmPage";

  @override
  _GmPageState createState() => new _GmPageState();
}

class _GmPageState extends State<GmPage> {


  @override
  Widget build(BuildContext context) {



    return new Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        title: new Text('Choose the power of your threat.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Calibri',
            height: 1.3,
            fontSize: 20.0,
            color: Colors.white,
            letterSpacing: 1,
          ),),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              height: 2.5,
              thickness: 2.5,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new StoryPage(),
                      ),
                    );
                  },
                  child: Text('STORY',
                    style: TextStyle(
                      fontFamily: 'Headliner',
                      color: Colors.white,
                      height: 1.3,
                      fontSize: 32,
                      letterSpacing: 3,
                    ),
                  ),

                ),
              ),
            ),//STORY
            Divider(
              height: 0,
              thickness: 2,
              color: Colors.white,
            ),

            Expanded(
              child: Container(
                color: Colors.black,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ThreatPage(),
                      ),
                    );
                  },
                  child: Text('THREAT',
                    style: TextStyle(
                      fontFamily: 'Headliner',
                      color: Colors.white,
                      height: 1.3,
                      fontSize: 32.0,
                      letterSpacing: 3,
                    ),
                  ),

                ),
              ),
            ),//THREAT
            Divider(
              height: 0,
              thickness: 2,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new NpcPage(),
                      ),
                    );
                  },
                  child: Text('NPC',
                    style: TextStyle(
                      fontFamily: 'Headliner',
                      color: Colors.white,
                      height: 1.3,
                      fontSize: 32.0,
                      letterSpacing: 3,
                    ),
                  ),

                ),
              ),
            ),//NPC
            Divider(
              height: 0,
              thickness: 2,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new LootPage(),
                      ),
                    );
                  },
                  child: Text('LOOT',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Headliner',
                      height: 1.5,
                      fontSize: 32.0,
                      letterSpacing: 3,
                    ),
                  ),

                ),
              ),
            ),//LOOT
            Divider(
              height: 0,
              thickness: 2,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

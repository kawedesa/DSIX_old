import 'package:dsixv02app/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item.dart';
import 'dart:math';
import 'shop.dart';

class LootPage extends StatefulWidget {
  LootPage({Key key}) : super(key: key);

  static const String routeName = "/lootPage";

  @override
  _LootPageState createState() => new _LootPageState();
}




class _LootPageState extends State<LootPage> {

static Shop loot = Shop();
// Item selectedLoot = loot.shopList[0];


// Item rollLoot (){
//
//   Random random = new Random();
//   int randomNumber = random.nextInt(loot.shopList.length);
//   selectedLoot = loot.shopList[randomNumber+1];
//   return selectedLoot;
//
// }






  @override
  Widget build(BuildContext context) {



    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: new Text('Click on the  \' - \'  to roll the loot.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Calibri',
            height: 1.3,
            fontSize: 20.0,
            color: Colors.white,
            letterSpacing: 1,
          ),),
      ),

      body: new SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Divider(
                height: 2.5,
                thickness: 2.5,
                color: Colors.white,
              ),

              Expanded(
                flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(21,30,45,20),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          // rollLoot();
                        });

                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      // child: Image.asset('images/shop/${selectedLoot.itemClass}${selectedLoot.index}.png'),

                      ),
                  ),

                  ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Text(
                  'DESCRIPTION',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Headliner',
                    height: 0.1,
                    fontSize: 45.0,
                    color: Colors.white,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 2,
                color: Colors.white,
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,20,40,20),
                  child: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('selectedLoot.description',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 22.0,
                          color: Colors.white,
                        ),),
                        SizedBox(height: 20,),
                        Text('{selectedLoot.value}',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          fontSize: 30.0,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                        ),
                      ],
                    ),

                  ),
                ),

              ),

            ],
          )
      ),
    );
  }
}

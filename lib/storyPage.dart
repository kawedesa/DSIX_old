import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class StoryPage extends StatefulWidget {
  StoryPage({Key key}) : super(key: key);

  static const String routeName = "/storyPage";

  @override
  _StoryPageState createState() => new _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  int objectiveIMG = 0;
  int targetIMG = 0;
  int raceIMG = 0;
  int occupationIMG = 0;
  int threatIMG = 0;
  int locationIMG = 0;
  int environmentIMG = 0;



  void objectivePress(){

    setState(() {
      objectiveIMG = Random().nextInt(9) + 1;
    });

  }
  void targetPress(){

    setState(() {



      if(objectiveIMG == 1){
        targetIMG = Random().nextInt(5) + 1;
      }else if(objectiveIMG == 2){
        targetIMG = Random().nextInt(3) + 5;
      }else{
        targetIMG = Random().nextInt(7) + 1;
      }

      if (targetIMG == 1 || targetIMG == 4){
        raceIMG = Random().nextInt(8) + 1;
        occupationIMG = Random().nextInt(18) + 1;
      }else{
        occupationIMG = 0;
        raceIMG = 0;
      }

    });

  }
  void racePress(){

    setState(() {
      raceIMG = Random().nextInt(8) + 1;
      if(targetIMG != 1 && targetIMG != 4){
        raceIMG = 0;
      }

    });

  }
  void occupationPress(){

    setState(() {
      occupationIMG = Random().nextInt(18) + 1;
      if(targetIMG != 1 && targetIMG != 4){
        occupationIMG = 0;
      }
    });

  }
  void threatPress(){

    setState(() {

      threatIMG = Random().nextInt(21) + 1;

    });

  }
  void locationPress(){

    setState(() {

      locationIMG = Random().nextInt(21) + 1;

    });

  }
  void environmentPress(){

    setState(() {

      environmentIMG = Random().nextInt(4) + 1;

    });

  }


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
        title: new Text('Click on  \' - \'  to roll the story.',
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
          child:Column(
            children: <Widget>[
              Divider(
                height: 2.5,
                thickness: 2.5,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                      Text(
                        'OBJECTIVE',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 40.0,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          objectivePress();
                        },
                        child: Image.asset('images/objective/objective$objectiveIMG.png'),
                      ),
                    ],
                  ),
                ),
              ), //   OBJECTIVE
              Divider(
                height: 0,
                thickness: 2,
                color: Colors.white,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,20,40,20),
                      child: Text(
                        'TARGET',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 40.0,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(

                        children: <Widget>[
                          Expanded(
                            child: TextButton(
                              child: Image.asset('images/occupation/occupation$occupationIMG.png'),
                              style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(0,10,0,0),
                              ),
                              onPressed: (){

                                occupationPress();

                              },
                            ),
                          ),
                          Expanded(
                           child: TextButton(
                             child: Image.asset('images/race/race$raceIMG.png'),
                             style: TextButton.styleFrom(
                             padding: EdgeInsets.fromLTRB(0,10,0,0),
                             ),
                             onPressed: (){

                               racePress();

                             },
                           ),
                         ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,20,20.0),
                      child: TextButton(
                        onPressed: (){

                          targetPress();


                        },
                        child: Image.asset('images/target/target$targetIMG.png'),
                      ),
                    ),

                  ],
                ),
              ),  //  PLOT
              Divider(
                height: 0,
                thickness: 2,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'LOCATION',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 40.0,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          locationPress();
                        },
                        child: Image.asset('images/location/location$locationIMG.png'),
                      ),
                    ],
                  ),
                ),
              ),  //  LOCATION
              Divider(
                height: 0,
                thickness: 2,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'ENVIRONMENT',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 40.0,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          environmentPress();
                        },
                        child: Image.asset('images/environment/environment$environmentIMG.png'),
                      ),
                    ],
                  ),
                ),
              ),  //  ENVIRONMENT
              Divider(
                height: 0,
                thickness: 2,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'THREAT',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 40.0,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          threatPress();
                        },
                        child: Image.asset('images/threat/threat$threatIMG.png'),
                      ),
                    ],
                  ),
                ),
              ),  //  THREAT

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  static const String routeName = "/mapPage";



  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {


  int skillSelect = 0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(


      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: new Text('Choose your character.',
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
                flex: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                  ],

                ),
              ),
              Divider(
                height: 2.5,
                thickness: 2.5,
                color: Colors.white,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5,10, 0),
                  child: Row(
                    children: <Widget>[
                      
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            ),
                            onPressed: (){

                            },
                            child: Image.asset('images/player/skill13.png')),
                      ),
                      Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                              onPressed: (){
                          },
                              child: Image.asset('images/player/skill14.png')

                          ),
                      ),
                      Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                              onPressed: (){
                              },
                          child: Image.asset('images/player/skill15.png')
                          ),
                      ),
                      Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                              onPressed: (){
                              },
                              child: Image.asset('images/player/skill16.png')
                          ),
                      ),
                      Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                              onPressed: (){
                              },
                              child: Image.asset('images/player/skill17.png')),
                      ),
                      Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            ),
                            onPressed: (){
                            },
                              child: Image.asset('images/player/skill1.png'),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
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


import 'package:dsixv02app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerRacePage.dart';
import 'player.dart';
import 'gmPage.dart';
import 'playerUI.dart';
import 'package:flutter_svg/flutter_svg.dart';



class PlayersPage extends StatefulWidget {

  final Player player;

  const PlayersPage({Key key, this.player}) : super(key: key);

  static const String routeName = "/playersPage";

  @override
  _PlayersPageState createState() => new _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {

  Route _createRouteMain() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -1.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String namePlayer1 = 'PINK';
  String namePlayer2 = 'BLUE';
  String namePlayer3 = 'GREEN';
  String namePlayer4 = 'YELLOW';
  String namePlayer5 = 'PURPLE';

void nameSelect(){
  if(widget.player.name != ''){
    if(widget.player.playerIndex == 1){
      namePlayer1 = widget.player.name;
    }else if(widget.player.playerIndex == 2){
      namePlayer2 = widget.player.name;
    }else if(widget.player.playerIndex == 3){
      namePlayer3 = widget.player.name;
    }else if(widget.player.playerIndex == 4){
      namePlayer4 = widget.player.name;
    }else if(widget.player.playerIndex == 5){
      namePlayer5 = widget.player.name;
    }
  }
}

void setPlayer(int index, Color primaryColor, Color secondaryColor, Color tertiaryColor){


  widget.player.playerIndex = index;
  widget.player.playerColor = primaryColor;
  widget.player.playerSecondaryColor = secondaryColor;
  widget.player.playerTertiaryColor = tertiaryColor;


}


  Route _createRouteRace() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerRacePage(player: widget.player,),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRouteUI() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerUI(player: widget.player,),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1, 0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }







  void navigation(){
  if(widget.player.name != ''){
    Navigator.of(context).push(_createRouteUI());
  }else {
    Navigator.of(context).push(_createRouteRace());
  }
}


  void initState() {

    nameSelect();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(


      backgroundColor: Colors.black,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: new Text('Choose your player',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Headline',
            height: 1.1,
            fontSize: 25.0,
            color: Colors.black,
            letterSpacing: 2,
          ),),
      ),

      body: new SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,55,0,0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[



                    TextButton(
                      style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      ),
                      onPressed: () {

                        setPlayer(1,Colors.pinkAccent,Colors.pink[800],Colors.pink[100]);

                        navigation();
                      },
                      child:  Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right, color: Colors.pinkAccent, size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Center(
                                child: Text(namePlayer1,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   PINK

                    TextButton(
                      style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      ),
                      onPressed: () {


                        setPlayer(2,Colors.indigoAccent,Colors.indigo[800],Colors.indigo[100]);

                        navigation();
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right, color: Colors.indigoAccent, size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.indigoAccent,
                                width: 2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Center(
                                child: Text(namePlayer2,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.indigoAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   BLUE

                    TextButton(
                      onPressed: () {

                        setPlayer(3,Colors.teal,Colors.teal[800],Colors.teal[100]);

                        navigation();
                      },
                      style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right, color: Colors.teal, size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.teal,
                                width: 2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Center(
                                child: Text(namePlayer3,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   GREEN

                    TextButton(
                      onPressed: () {

                        setPlayer(4,Colors.orange,Colors.orange[800],Colors.orange[100]);

                        navigation();
                      },
                      style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right, color: Colors.orange, size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orange,
                                width: 2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Center(
                                child: Text(namePlayer4,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   YELLOW

                    TextButton(
                      onPressed: () {

                        setPlayer(5,Colors.purple,Colors.purple[800],Colors.purple[100]);

                        navigation();
                      },
                      style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right, color: Colors.purple, size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.purple,
                                width: 2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Center(
                                child: Text(namePlayer5,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   PURPLE

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new GmPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right, color: Colors.grey[800], size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:  Colors.grey[800],
                                width: 2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Center(
                                child: Text('GM',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   GM GREY


                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.of(context).push(_createRouteMain());
                },
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 40,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
//Navigator.of(context).push(_createRoute());
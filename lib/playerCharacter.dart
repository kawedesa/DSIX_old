import 'package:flutter/material.dart';
import 'player.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CharacterPage extends StatefulWidget {

  final Player player;

  const CharacterPage({Key key, this.player}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();


}

class _CharacterPageState extends State<CharacterPage> {

  TextEditingController myController;


  void confirm (){
    widget.player.background.description = myController.text;
    Navigator.of(context).pop(true);

  }


  showAlertDialogDescription(BuildContext context) {


    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding:  const EdgeInsets.fromLTRB(0,0,0,0),

      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.player.playerColor,
            width: 2.5, //                   <--- border width here
          ),
        ),
        width: 300,
        height: 325,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: widget.player.playerColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,10,30,10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Write your story',
                      style: TextStyle(
                        fontFamily: 'Headline',
                        height: 1.3,
                        fontSize: 30.0,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),

                  ],
                ),

              ),
            ),
            Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35,15,25,5),
                child: TextField(
                    keyboardType: TextInputType.multiline,

                    maxLines: 5,
                    autofocus: true,
                    cursorColor: widget.player.playerColor,
                    textAlign: TextAlign.center,
                    onEditingComplete: confirm,
                    onSubmitted: (value) {
                      widget.player.background.description = value;
                    },
                    style:TextStyle(
                      height: 1.3,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                    controller: myController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.player.playerColor, width: 1.5,),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.player.playerColor, width: 1.5,),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.player.playerColor, width: 1.5,),
                      ),
                    )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30,30,30,0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.player.playerColor,
                    width: 1.5, //                   <--- border width here
                  ),
                ),
                child: TextButton(
                  onPressed: (){

                    confirm();

                  },
                  style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0,5,0,5),
                  ),
                  child:Center(
                    child: Text('CONFIRM',
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialogDetail(BuildContext context, int index)
  {

    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.player.playerColor,
            width: 1.5, //                   <--- border width here
          ),
        ),
        width: 300,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: widget.player.playerColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,10,30,10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('${widget.player.playerAction[index].name}: ${widget.player.playerAction[index].value}',
                      style: TextStyle(
                        fontFamily: 'Headline',
                        height: 1.3,
                        fontSize: 30.0,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),

                  ],
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35,25,25,15),
              child: Text(widget.player.playerAction[index].description,
                style: TextStyle(
                  height: 1.25,
                  fontSize: 22,
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),

            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }



  @override
  void initState() {
    super.initState();

    myController = new TextEditingController(text: widget.player.background.description);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            width:double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5,10, 0),
              child: Stack(
                children: <Widget>[

                  //ACTION ICON

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),

                        child: SvgPicture.asset(
                          'assets/action/${widget.player.playerAction[index].icon}.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                      );
                    }),
                  ),

                  //ACTION VALUE

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),

                        child: SvgPicture.asset(
                          'assets/action/${widget.player.playerAction[index].value}.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                      );
                    }),
                  ),
                ],

              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.player.playerColor,
        ),
        Expanded(
          flex: 13,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13,25,0,0),
                child: Container(
                  width: 30,
                  child: GridView.count(
                    crossAxisCount: 1,
                    children: List.generate(widget.player.buffList.length, (index) {
                      return GestureDetector(
                        onTap:(){

                        },
                        child: SvgPicture.asset(
                          'assets/action/${widget.player.buffList[index].icon}.svg',
                          color: Colors.deepOrange,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
              padding: const EdgeInsets.fromLTRB(65,15,65,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(widget.player.name,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 50,
                            color: widget.player.playerColor,
                            letterSpacing: 2,
                          ),),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,0,5),
                          child: SizedBox(
                              height: 45,
                              child: Image.asset('images/player/sex${widget.player.playerIndex}${widget.player.playerSex}.png')),
                        ),

                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: double.infinity,
                      minWidth: double.infinity,
                      maxHeight: 225,
                      minHeight: 0,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,15,0,15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(widget.player.background.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 22,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.0+1*55,
                    child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return TextButton(
                              style: TextButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(0,0,0,10),
                              ),
                            onPressed: (){

                              showAlertDialogDescription(context);

                            },

                            child: Stack(
                          children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,12,12,0),
                                  child: SvgPicture.asset(
                                    'assets/ui/text.svg',
                                    color: widget.player.playerColor,
                                    width: MediaQuery.of(context).size.width * 0.055,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                          border: Border.all(
                          color: widget.player.playerColor,
                          width: 2.5, //                   <--- border width here
                          ),
                          ),
                          child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,8),
                          child: Center(
                          child: Text('EDIT',
                          style: TextStyle(
                          height: 1.5,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                          ),
                          ),
                          ),
                          ),
                          ),
                          ],
                          ),

//                          Container(
//                            width: double.infinity,
//                            decoration: BoxDecoration(
//                              border: Border.all(
//                                color: widget.player.playerColor,
//                                width: 2.5, //                   <--- border width here
//                              ),
//                            ),
//                            child: Padding(
//                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
//                              child: Center(
//                                child: Text('EDIT',
//                                  style: TextStyle(
//                                    height: 1.5,
//                                    fontSize: 17,
//                                    fontWeight: FontWeight.bold,
//                                    letterSpacing: 1.5,
//                                    fontFamily: 'Calibri',
//                                    color: Colors.white,
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ),
      ],
    );
  }
}
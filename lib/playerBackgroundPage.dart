import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerBackground.dart';
import 'player.dart';
import 'shop.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bonus.dart';
import 'playerSkillPage.dart';
import 'item.dart';



class PlayerBackgroundPage extends StatefulWidget {


  static const String routeName = "/playerBackgroundPage";

  final Player player;

  const PlayerBackgroundPage({Key key, this.player}) : super(key: key);

  @override
  _PlayerBackgroundPageState createState() => new _PlayerBackgroundPageState();
}

class _PlayerBackgroundPageState extends State<PlayerBackgroundPage> {


  static Shop shop = Shop();

  static List<PlayerBackground> backgrounds = [

    PlayerBackground('noble','NOBLE','Your life is filled with money and gifts. Your family is well known, and most people respect you.',[Bonus('GOLD','gold','You are rich! So you get an extra \$500 gold.',500)],[]),
    PlayerBackground('fighter','FIGHTER','You move around, from place to place, looking for blood and coin. People stay out of your way, by will or by force.',[Bonus('+2 ARMOR   ','pArmor','This represents how much damage you mitigate from attacks.',2),Bonus('GLOVES','item','${shop.armor[1].description}',0),Bonus('BOOTS','item','${shop.armor[0].description}',0)],[shop.armor[0],shop.armor[1],]),
    PlayerBackground('thief','THIEF','You have quick hands and a burning desire for treasure. Some people steal out of necessity, others do it for fun. You do it because you can.',[Bonus('+1 DAMAGE   ','pDamage','This represents how much damage you deal with your attacks.',1),Bonus('+1 ARMOR   ','pArmor','This represents how much damage you mitigate from attacks.',1),Bonus('2x KEYS   ','item','',0)],[shop.resources[0],shop.resources[0],]),
    PlayerBackground('mage','MAGE','You are familiar with magic. Either born with it or taught by a mentor. Most people see you as a freak and keep their distance.',[Bonus('+1 MAGIC DAMAGE   ','mDamage','This represents how much magic damage you deal with your attacks.',1),Bonus('MAGIC ORB','item','${shop.magicWeapons[0].description}',0)],[shop.magicWeapons[0],]),
    PlayerBackground('hunter','HUNTER','You spend most of your time hunting for game. You are not really used to people and feel more comfortable outdoors.',[Bonus('+2 DAMAGE   ','pDamage','This represents how much damage you deal with your attacks.',1),Bonus('AMMO  ','item','',0)],[shop.resources[1],shop.resources[1],]),
    PlayerBackground('medic','MEDIC','You already saved many lives and people respect you. Blood, diseases, guts and bones don\'t bother you.',[Bonus('+1 MAGIC ARMOR   ','mArmor','This represents how much damage you mitigate from magic attacks.',1),Bonus('2x BANDAGES   ','item','',0)],[shop.resources[0],shop.resources[0]]),
    PlayerBackground('','BACKGROUND','This represents your story. How you where raised and how people see you. Click on the icons above to choose your background.',[Bonus('BONUS','bonus','All backgrounds are unique and have different bonuses. They can be items, gold, and passive attributes, like armor and damage.',0)],[]),

    //OLD BACKGROUNDS

    //PlayerBackground(2,'Merchant','You are a successful merchant and know the real value of things. Nobody gets in between you and a good deal.','\$ 400',[]),
    //PlayerBackground(3,'Spy','You have many names, but none of them are real. You leave no footsteps behind.','GLOVES, BOOTS, GEAR',[shop.shopList[80], shop.shopList[67],shop.shopList[65],]),
    //PlayerBackground(4,'Prisoner','You are a criminal and nobody believes in you. You have nothing, but a key and the will to escape.','KEY',[shop.shopList[81]]),
    //PlayerBackground(5,'Pirate','You believe that laws are stupid and nobody can own something they can\'t protect. The world is there for the taking.','HAND CANNON',[shop.shopList[39]]),
    //PlayerBackground(7,'Worker','You are the pillar of any society and do the heavy lifting, while the nobles drink their wine.','TOOL GEAR',[shop.shopList[80],shop.shopList[80],]),
    //PlayerBackground(8,'Cook','You are an alchemist of smells and flavours. There is nothing more powerful than a tasty meal.','CLEAVER GEAR',[shop.shopList[80],shop.shopList[80],]),
    //PlayerBackground(10,'Detective','You are needed, because justice is blind. You can always tell when someone is lying.','WARD, WARD',[shop.shopList[82],shop.shopList[82],]),
    //PlayerBackground(11,'Performer','You are comfortable around people and love to the center of attention. Laughter, music, wine and love are your trade.','LUCKY CHARM, LUCKY CHARM',[shop.shopList[89],shop.shopList[89],]),
    //PlayerBackground(14,'Student','You are very curious about everything and believes that knowledge is power. There is always something new to be learned.','BOOK, BOOK, GEAR',[shop.shopList[78],shop.shopList[78],shop.shopList[80],]),
    //PlayerBackground(15,'Traveler','You wear different clothes and have a different accent. People don\'t know where you came from or where you are going.','SCROLL',[shop.shopList[46],shop.shopList[51],]),
    //PlayerBackground(16,'Assassin','You live a solitary life and trust no one. You are an agent of destruction and death is your only partner. ','DAGGER, KUNAI, ANTIDOTE',[shop.shopList[3],shop.shopList[35],shop.shopList[71],]),
    //PlayerBackground(18,'Fugitive','You are running from your past, and nothing will make you go back. You are going to be fine if you stay one step ahead.','FREE ACTION, BOOTS',[shop.shopList[65],shop.shopList[88],]),

  ];


  List<String> selectedBackground = [
    'null','null','null','null','null','null',
  ];


  PlayerBackground displayBackground = backgrounds[6];

  void backgroundSelection(index){
    selectedBackground = [
      'null','null','null','null','null','null',
    ];
    selectedBackground.replaceRange(index, index+1, [backgrounds[index].icon]);

    widget.player.background = backgrounds[index];
    displayBackground = widget.player.background;

  }

  void confirm(){

    //RESET Inventory, gold, pDamage, mDamage, mArmor and pArmor.


    widget.player.gold = 1000;
    widget.player.pDamage = 0;
    widget.player.mDamage = 0;
    widget.player.pArmor = 0;
    widget.player.mArmor = 0;

    widget.player.inventory.clear();
    widget.player.currentWeight = 0;

    // ASSIGN BONUSES

    if(widget.player.background.background == 'NOBLE'){

      widget.player.gold = 1500; //GOLD

    }else if(widget.player.background.background == 'FIGHTER'){

      widget.player.pArmor = 2;
      for(Item item in widget.player.background.bonusItem){
        widget.player.inventory.add(item.copyItem());
      }


    }else if(widget.player.background.background == 'THIEF'){

      widget.player.pDamage = 1;
      widget.player.pArmor = 1;
      for(Item item in widget.player.background.bonusItem) {
        widget.player.inventory.add(item.copyItem());
      }

    }else if(widget.player.background.background == 'MAGE'){

      widget.player.mDamage = 1;
      for(Item item in widget.player.background.bonusItem) {
        widget.player.inventory.add(item.copyItem());
      }

    }else if(widget.player.background.background == 'HUNTER'){

      widget.player.pDamage = 2;
      for(Item item in widget.player.background.bonusItem) {
        widget.player.inventory.add(item.copyItem());
      }

    }else if(widget.player.background.background == 'MEDIC'){

      widget.player.mArmor = 1;
      for(Item item in widget.player.background.bonusItem) {
        widget.player.inventory.add(item.copyItem());
      }

    }


    //ASSIGN CURRENT WEIGHT

    for(Item item in widget.player.inventory){
      widget.player.currentWeight += item.weight;
    }


    //GO TO NEXT PAGE

      Navigator.of(context).push(_createRouteSkill());

  }


  showAlertDialog(BuildContext context, int index)
  {

    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.player.playerColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
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
                        Text(displayBackground.bonus[index].name,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,15,25,20),
                  child: Text(displayBackground.bonus[index].description,
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
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }


  double _size = 0;

  void _updateState() {
    setState(() {
      _size = 50;
    });
  }

  Route _createRouteSkill() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerSkillPage(player: widget.player,),
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
          backgroundColor: widget.player.playerColor,
          centerTitle: true,
          title: new Text('Background ',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Headline',
              height: 1.1,
              fontSize: 25.0,
              color: Colors.white,
              letterSpacing: 2,
            ),),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,10,0),
              child: AnimatedContainer(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 400),
                width: _size,
                height: _size,
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right, color: Colors.lightGreenAccent,size: 40,),
                  onPressed: () {

                    confirm();

                  },
                ),
              ),
            ),
          ],
        ),

        body: new SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex:4,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5,10, 0),
                    child: Stack(
                      children: <Widget>[
                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: SvgPicture.asset(
                                  'assets/background/${backgrounds[index].icon}.svg',
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.055,
                                ),

                            );
                          }),
                        ),
                        GridView.count(
                          crossAxisCount: 6,

                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: TextButton(
                                  onPressed: (){
                                    setState(() {

                                      backgroundSelection(index);
                                      _updateState();

                                    });
                                  },
                            style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                            ),
                                child: SvgPicture.asset(
                                  'assets/background/${selectedBackground[index]}.svg',
                                  color: widget.player.playerColor,
                                ),
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
                flex: 29,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(65,15,65,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,15),
                          child: Text(displayBackground.background,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.3,
                              fontSize: 50,
                              color: widget.player.playerColor,
                              letterSpacing: 2,
                            ),),
                        ),
                        Text(displayBackground.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 22,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.0+displayBackground.bonus.length*63,
                          child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0,15,0,0),
                              itemCount: displayBackground.bonus.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                    ),
                                  onPressed: (){

                                    showAlertDialog(context,index);
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
                                                'assets/ui/help.svg',
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
                                            child: Text(displayBackground.bonus[index].name,
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
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        )

    );
  }
}

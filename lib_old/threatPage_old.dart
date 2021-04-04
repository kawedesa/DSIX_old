import 'ability.dart';
import 'npc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';



class ThreatPage extends StatefulWidget {
  ThreatPage({Key key}) : super(key: key);

  static const String routeName = "/threatPage";

  @override
  _ThreatPageState createState() => new _ThreatPageState();
}

class _ThreatPageState extends State<ThreatPage> {


int npcLife = 0;
List<Ability> npcAbility = [];

List<Ability> abilityList = [

  Ability(1,1,'Jump'),
  Ability(2,1,'Hide'),
  Ability(3,1,'Climb'),
  Ability(4,1,'Organized'),
  Ability(5,1,'Dig'),
  Ability(6,1,'Armor'),
  Ability(7,1,'Fly'),
  Ability(8,1,'Damage'),
  Ability(9,1,'Swim'),
  Ability(10,1,'Range'),
  Ability(11,2,'Hold'),
  Ability(12,2,'Poison'),
  Ability(13,2,'Push'),
  Ability(14,2,'Ice'),
  Ability(15,2,'Pull'),
  Ability(16,2,'Fire'),
  Ability(17,2,'Heal'),
  Ability(18,2,'Electric'),
  Ability(19,2,'Spin'),
  Ability(20,2,'Holy'),
  Ability(21,3,'Smart'),
  Ability(22,3,'Splash'),
  Ability(23,3,'Strong'),
  Ability(24,3,'Split'),
  Ability(25,3,'Fast'),
  Ability(26,3,'Combine'),
  Ability(27,3,'Perceptive'),
  Ability(28,3,'Adapt'),
  Ability(29,3,'Resistant'),
  Ability(30,3,'Seek'),
  Ability(31,4,'Thorn'),
  Ability(32,4,'Spawn'),
  Ability(33,4,'Ignore'),
  Ability(34,4,'Strategy'),
  Ability(35,4,'Immune'),
  Ability(36,4,'Invisibility'),
  Ability(37,4,'Charm'),
  Ability(38,4,'Fear'),
  Ability(39,4,'Teleport'),
  Ability(40,4,'Swallow'),
];

Npc npcGen(int powerLevel) {

  List<Npc> npcList = [
    Npc(0, 0),
    Npc(1, 1),
    Npc(2, 3),
    Npc(3, 5),
    Npc(4, 7),
    Npc(5, 9),
    Npc(6, 11),
  ];

  Npc newNpc = npcList[powerLevel];

  while(newNpc.npcAbilityPoint > 0) {

    Random random = new Random();
    int randomNumber = random.nextInt(abilityList.length);

    Ability selectAbility = abilityList[randomNumber];

    if (newNpc.npcAbilityPoint >= selectAbility.cost){

      newNpc.abilityList.add(selectAbility);
      newNpc.npcAbilityPoint -= selectAbility.cost;
    }

  }

  return newNpc;

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
      
      body: new SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(
                height: 2.5,
                thickness: 2.5,
                color: Colors.white,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,30),
                  child: Container(
                    child: Image.asset('images/npc/npcLife$npcLife.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'ABILITYS',
                  textAlign: TextAlign.center,
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
                flex: 4,
                child: Container(
                  child: GridView.count(
                    crossAxisCount: 4,

                    children: List.generate(npcAbility.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0,25,0,0),
                        child: Center(

                          child: Image.asset('images/npc/ability${npcAbility[index].index}.png'),

                          //child: Text(npcSkills[index].name,
                          //style: TextStyle(color: Colors.white),)

                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'POWER',
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
              SizedBox(height: 20,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      ),
                      onPressed: (){

                        setState(() {
                          Npc npc = npcGen(1);
                          npcLife = npc.npcLife;
                          npcAbility = npc.abilityList;
                        });

                      },
                      child: Image(
                        image: AssetImage('images/dice/dice1.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      ),
                      onPressed: (){
                        setState(() {
                          Npc npc = npcGen(2);
                          npcLife = npc.npcLife;
                          npcAbility = npc.abilityList;
                        });
                      },
                      child: Image(
                        image: AssetImage('images/dice/dice2.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      ),
                      onPressed: (){

                        setState(() {
                          Npc npc = npcGen(3);
                          npcLife = npc.npcLife;
                          npcAbility = npc.abilityList;
                        });
                      },
                      child: Image(
                        image: AssetImage('images/dice/dice3.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      ),
                      onPressed: (){

                        setState(() {
                          Npc npc = npcGen(4);
                          npcLife = npc.npcLife;
                          npcAbility = npc.abilityList;
                        });
                      },
                      child: Image(
                        image: AssetImage('images/dice/dice4.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      ),
                      onPressed: (){

                        setState(() {
                          Npc npc = npcGen(5);
                          npcLife = npc.npcLife;
                          npcAbility = npc.abilityList;
                        });
                      },
                      child: Image(
                        image: AssetImage('images/dice/dice5.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      ),
                      onPressed: (){

                        setState(() {
                          Npc npc = npcGen(6);
                          npcLife = npc.npcLife;
                          npcAbility = npc.abilityList;
                        });
                      },
                      child: Image(
                        image: AssetImage('images/dice/dice6.png'),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 5,),
            ],
          )
      ),
    );
  }
}

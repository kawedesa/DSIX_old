import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class NpcPage extends StatefulWidget {
  NpcPage({Key key}) : super(key: key);

  static const String routeName = "/NpcPage";

  @override
  _NpcPageState createState() => new _NpcPageState();
}

class _NpcPageState extends State<NpcPage> {
  int objectiveIMG = 0;
  int targetIMG = 0;
  int raceIMG = 10;
  int occupationIMG = 19;
  String race = '-';
  String objective = '-';
  String occupation = '-';
  String personality = '-';
  String description = '-';
  int sexIMG = 0;

  List<String> raceList = [
    'Human',
    'Dwarf',
    'Orc',
    'Elf',
    'Dark Elf',
    'Goblin',
    'Gnome',
    'Halfling',
    'Beast',
  ];

  List<String> occupationList = [
    'Merchant',
    'Noble',
    'Spy',
    'Prisoner',
    'Pirate',
    'Medic',
    'Worker',
    'Chef',
    'Mercenary',
    'Detective',
    'Artist',
    'Wizard',
    'Student',
    'Traveler',
    'Hunter',
    'Assassin',
    'Thief',
    'Scientist',
    'Lawyer',
    'Farmer',
    'Tailor',
    'Gladiator',
    'Sailor',
    'Innkeeper',
    'Stablehand',
    'Soldier',
    'Politician',
    'Bureaucrat',
    'Shaman',
    'Homeless',
    'Knight',
    'Monk',
    'Gardener',
  ];

  List<String> objectiveList = [
    'Hunt',
    'Create',
    'Destroy',
    'Deliver',
    'Steal',
    'Capture',
    'Find',
    'Protect',
    'Save',
    'Flee',
    'Gather',
    'Spread',
    'Win',
    'Learn',
    'Avenge',
    'Control',
    'Report',
    'Perform',
    'Solve',
    'Organize',
    'Investigate',
    'Fight',
  ];

  List<String> descriptionList = [
    'Smelly',
    'Old',
    'Ugly',
    'Weird',
    'Sick',
    'Weak',
    'Strong',
    'Hairy',
    'Mute',
    'Young',
    'Blind',
    'Pale',
    'Tall',
    'Short',
    'Deaf',
    'Bald',
    'Fit',
    'Fat',
    'Gorgeous',
    'Skinny',
    'Tattooed',
    'Unkempt',
  ];

  List<String> personalityList = [
    'Brave',
    'Clever',
    'Coward',
    'Friendly',
    'Generous',
    'Grumpy',
    'Honest',
    'Kind',
    'Lazy',
    'Nervous',
    'Popular',
    'Selfish',
    'Serious',
    'Shy',
    'Stupid',
    'Vain',
    'Religious',
    'Proud',
    'Flamboyant',
    'Stubborn',
    'Obsessed',
    'Greedy',
    'Calm',
    'Slow',
  ];

  void racePress() {
    Random random = new Random();
    int randomNumber = random.nextInt(raceList.length);

    setState(() {
      race = raceList[randomNumber];
      sexIMG = Random().nextInt(2) + 1;
    });
  }

  void occupationPress() {
    Random random = new Random();
    int randomNumber = random.nextInt(occupationList.length);

    setState(() {
      occupation = occupationList[randomNumber];
    });
  }

  void descriptionPress() {
    Random random = new Random();
    int randomNumber = random.nextInt(descriptionList.length);

    setState(() {
      description = descriptionList[randomNumber];
    });
  }

  void personalityPress() {
    Random random = new Random();
    int randomNumber = random.nextInt(personalityList.length);

    setState(() {
      personality = personalityList[randomNumber];
    });
  }

  void objectivePress() {
    Random random = new Random();
    int randomNumber = random.nextInt(objectiveList.length);

    setState(() {
      objective = objectiveList[randomNumber];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: new Text(
          'Click on the  \' - \'  to roll your NPC.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Calibri',
            height: 1.3,
            fontSize: 20.0,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
      body: new SafeArea(
        child: Column(
          children: <Widget>[
            Divider(
              height: 2.5,
              thickness: 2.5,
              color: Colors.white,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      'SEX AND RACE',
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
                            child: SizedBox(
                              child: Image.asset('images/race/sex$sexIMG.png'),
                              height: 30,
                              width: 30,
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(0, 45, 0, 40),
                            ),
                            onPressed: () {
                              racePress();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      ),
                      onPressed: () {
                        racePress();
                      },
                      child: Text(
                        race,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 30,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), //   RACE AND SEX

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'OCCUPATION',
                      style: TextStyle(
                        fontFamily: 'Headliner',
                        height: 1.5,
                        fontSize: 40.0,
                        color: Colors.white,
                        letterSpacing: 2.5,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      ),
                      onPressed: () {
                        occupationPress();
                      },
                      child: Text(
                        occupation,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 30,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //  OCCUPATION
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
                      'DESCRIPTION',
                      style: TextStyle(
                        fontFamily: 'Headliner',
                        height: 1.5,
                        fontSize: 40.0,
                        color: Colors.white,
                        letterSpacing: 2.5,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      ),
                      onPressed: () {
                        descriptionPress();
                      },
                      child: Text(
                        description,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 30,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //  DESCRIPTION
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
                      'PERSONALITY',
                      style: TextStyle(
                        fontFamily: 'Headliner',
                        height: 1.5,
                        fontSize: 40.0,
                        color: Colors.white,
                        letterSpacing: 2.5,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      ),
                      onPressed: () {
                        personalityPress();
                      },
                      child: Text(
                        personality,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 30,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), // PERSONALITY
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
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      ),
                      onPressed: () {
                        objectivePress();
                      },
                      child: Text(
                        objective,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 30,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //  OBJECTIVE
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

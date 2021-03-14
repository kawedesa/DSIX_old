import 'package:dsixv02app/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dsixv02app/models/game/game.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'playerAction.dart';
import 'playerAttributePage.dart';

class PlayerSkillPage extends StatefulWidget {
  final Dsix dsix;

  const PlayerSkillPage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playerSkillPage";

  @override
  _PlayerSkillPageState createState() => new _PlayerSkillPageState();
}

class _PlayerSkillPageState extends State<PlayerSkillPage> {
  static List<PlayerAction> skills = [
    PlayerAction(
        'matterMorph',
        'MATTER MORPH',
        'You affect the environment around you, changing it\'s physical properties. It requires concentration.',
        [
          Option(
              'BRIGHTNESS',
              'You control the brightness of the environment around you, making it bright or dark.',
              'You make a large area bright or dark.',
              'You make a medium area bright or dark.',
              'You fail and something bad happens.'),
          Option(
              'HARDNESS',
              'You control the hardness of things around you, making them hard or soft.',
              'You make things in a medium area around you hard or soft.',
              'You make things in a small area around you hard or soft.',
              'You fail and something bad happens.'),
          Option(
              'FRICTION',
              'You control the friction of everything around you, making them very sticky or slippery.',
              'You make things in a medium area around you slippery or sticky.',
              'You make things in a small area around you slippery or sticky.',
              'You fail and something bad happens.')
        ],
        0,
        true),
    PlayerAction(
        'illusion',
        'ILLUSION',
        'You create an illusion that tricks people\'s senses. Making them see, hear, smell, taste or feel things that are not there. It requires concentration.',
        [
          Option(
              'ILLUSION',
              'You create smells, tastes, sounds, images, or pretty much anything that affect people\'s senses.',
              'You create a powerful illusion that affects everyone in a large area around you. Tricking their senses.',
              'You create an illusion that affects everyone in a medium area around you. Tricking one of their senses.',
              'You fail to create the illusion and something bad happens.'),
        ],
        0,
        true),
    PlayerAction(
        'alchemy',
        'ALCHEMY',
        'You throw a mixture that splashes on contact and causes different effects.',
        [
          Option(
              'SMOKE',
              'It creates a cloud of thick smoke around the impact area.',
              'It creates a large cloud of thick smoke.',
              'It creates a medium cloud of thick smoke.',
              'You miss and something bad happens.'),
          Option(
              'ICE',
              'It splashes around the impact point and freezes anything that it touches.',
              'It splashes on impact and freezes everything in a medium area.',
              'It splashes on impact, freezing a small area.',
              'You miss and something bad happens.'),
          Option(
              'FIRE',
              'It explodes on impact and sets fire to anything that it touches.',
              'It explodes and sets fire to a medium area.',
              'It explodes and sets fire to a small area.',
              'You miss and something bad happens.')
        ],
        0,
        false),
    PlayerAction(
        'callOfNature',
        'CALL OF NATURE',
        'You call for help and nature comes to your aid. It follows your command, but may ask for something in return.',
        [
          Option(
              'ATTACK',
              'You mark a target and nature strikes it.',
              'Nature strikes them on a weak spot. Roll the damage.',
              'Nature strikes them. Roll the damage.',
              'Nature misses the target and something bad happens.'),
          Option(
              'DEFEND',
              'You mark a target and nature defends it.',
              'Nature defends the target in time. Roll the defense.',
              'Nature blocks part of the damage. Roll the defense.',
              'Nature fails to defend the target and it takes full damage.'),
          Option(
              'SCOUT',
              'You ask nature for some information about a specific area.',
              'You receive meaningful information.',
              'You get information, but nature asks for something in return.',
              'You receive bad news.'),
        ],
        0,
        false),
    PlayerAction(
        'faceshifter',
        'FACESHIFTER',
        'You transform into a person of your choice, taking their voice and appearance.',
        [
          Option(
              'TRANSFORM',
              'The transformation varies in strength depending on your luck. An incomplete transformation gives you the appearance, but not the voice.',
              'The transformation is a success. You look and sound exactly like the person of your choice.',
              'The transformation is incomplete. You look like the person of your choice, but your voice remains the same.',
              'The transformation fails and something bad happens.')
        ],
        0,
        false),
    PlayerAction(
        'alterSenses',
        'ALTER SENSES',
        'You can bless or curse anyone you touch. Enhancing or taking away their senses. It requires concentration.',
        [
          Option(
              'ENHANCE',
              'You enhance someone, allowing them to perform incredible feats. \nLike seeing through walls, hearing whispers from far away or tracking a scent.',
              'You bless a person you touch, enhancing two of their senses.',
              'You bless a person you touch, enhancing one of their senses.',
              'You fail and something bad happens.'),
          Option(
              'REMOVE',
              'You curse someone and remove some of their senses. Making them blind, deaf, or numb. ',
              'You curse a person you touch, removing two of their senses.',
              'You curse a person you touch, removing one of their senses.',
              'You fail and something bad happens.')
        ],
        0,
        true),
    PlayerAction(
        'skill',
        'SKILL',
        'This is your signature move and what you are known for. Choose your skill by clicking on the icons above.',
        [
          Option(
              'OPTIONS',
              'Some skills have more than one option or effect to choose from.',
              '',
              '',
              '')
        ],
        0,
        false),
  ];

  //static List<PlayerSkill> skills = [

  //NEW BUT NEEDS WORK
  //PlayerAction('callOfNature', 'CALL OF NATURE', 'You call for help and nature comes to your aid. It follows your command, but may ask for something in return.',[Option('ATTACK','You mark a target and nature strikes anyway it can.','Nature strikes your target with full force.', 'Nature strikes the target.', 'Nature fails and something bad happens.'), Option('DEFEND','You call for help and nature protects you any way it can.a wind to blow your enemies away, vines to hold them down, branches to block their attacks, etc.','Nature protects the target from the attack. Roll to see how much it protects.','Nature gets just in time to block part of the attack. Roll to see how much it protects.','It doesn\'t protect the target in time and something bad happens.' ), Option('SCOUT','You call birds to scout an area, mice to find an exit, snakes to scene a threat, etc.','You get meaningful information.','You get meaningful information, but nature asks for retribution.', 'You uncover an ugly truth.'),],0),
  //PlayerAction('alchemy', 'ALCHEMY', 'You throw a mixture that splashes on contact and causes different effects.',[Option('OIL','It makes the surface slippery and flammable.','You splash a medium area with a flammable fluid, making it slippery.', 'You splash a small area with a flammable fluid, making it slippery.','You miss the target and something bad happens.'), Option('SMOKE','It creates a cloud of thick smoke that blocks vision.','It makes a large cloud of thick smoke around the impact area.', 'It makes a medium cloud of thick smoke around the impact area.', 'You miss the target and something bad happens.'), Option('ICE','It freezes anything it touches.','You freeze a medium area around the impact point.', 'You freeze a small area around the impact point.', 'You miss and something bad happens.'), Option('FIRE','It explodes on impact and sets fire to anything near by.','It explodes on impact, setting fire to a medium area. Roll your damage.', 'It explodes on impact, setting fire to a small area. Roll your damage.', 'You miss and something bad happens.')],0),
  //PlayerAction('controlOverMatter', 'CONTROL OVER MATTER', 'You change the environment around you, changing it\'s physical properties.',[Option(0,'BRIGHTNESS','You make the environment around you bright or dark.',), Option(1,'HARDNESS','You make the things around you soft, hard or liquid.',), Option(2,'FRICTION','You make things around you slippery or sticky.',), Option(3,'VISIBILITY','You make things around you appear or disappear.',)],0),
  //PlayerAction('illusion', 'ILLUSION', 'You create an illusion that tricks people\'s senses. It requires concentration.',[Option(0,'SOUND','You create sounds, noises, voices and music.',), Option(1,'SMELL','You create smells, scents, perfumes, etc.',), Option(2,'VISION','You create figures, shadows, animals, objects, etc.',), Option(3,'TASTE','You make them taste what you want.',), Option(4,'TOUCH','You make them feel any physical sensation, like warmth, cold, pain, pressure, etc.',)],0),
  //PlayerAction('alterSenses', 'ALTER SENSES', 'You can bless or curse anyone you touch. Enhancing or taking away their senses.',[Option(0,'SOUND','ENHANCE - They can hear things from further away, through walls, etc.\nREMOVE - You make them deaf.',), Option(1,'SMELL','ENHANCE - They can smell things from further away, track a scent, detect poisons, etc. \nREMOVE - You remove their sense of smell.',), Option(2,'VISION','ENHANCE - They can see things that are further away, in the dark, through walls, etc. \nREMOVE - You make them blind.',), Option(3,'TASTE','ENHANCE - They can distinguish the smallest variations in the things they taste. Like age, ingredients, where it\'s been, etc. \nREMOVE - You change or remove their sense of taste.',), Option(4,'TOUCH','ENHANCE - They feel the slightest changes in their environment, like vibrations, temperature, wind, etc. \nREMOVE - You make them numb and take away their pain.',)],0),

  //OLD SKILLS

  //PlayerSkill(1,'skill','MATTER CONTROL', 'INT', 'You control the environment around you, changing it’s physical properties.',[Option(0,'BRIGHTNESS','Making it shiny bright or complete darkness.','INT'),Option(1,'HARDNESS','Making it soft, hard, or liquid.','INT',),Option(2,'FRICTION','Making it adherent of frictionless.','INT',),Option(3,'VISIBILITY','Making it visible or invisible.','INT'),], true,),
  //PlayerSkill(2,'skill','ILLUSION', 'INT', 'You create an illusion that tricks people’s senses.',[Option(0,'SIGHT','Making them see or not see things.','INT'),Option(1,'HEARING','Making them hear or not hear things.','INT',),Option(2,'SMELL','Smell or not smell things.','INT',),Option(3,'TOUCH','Touch things that don\'t exist.','INT'),], true,),
  //PlayerSkill(3,'skill','ALCHEMY', 'INT', 'Your create a toxin that can causes different effects.',[Option(0,'CHARM','Making the person follow your orders.','INT'),Option(1,'SLEEP','Making them fall asleep.','INT',),Option(2,'HEAL','Healing them for 1D6 HP.','INT',),Option(3,'DAMAGE','Damaging them for 1D6 HP.','INT'),], false,),
  //PlayerSkill(4,'skill','CALL OF NATURE', 'WIS', 'Nature follows your command.',[Option(0,'ATTACK','It attacks the target.','WIS'),Option(1,'DEFEND','It defends the target.','WIS',),Option(2,'ASSIST','It helps the target with the task at hand.','WIS',),Option(3,'SCOUT','It scouts the area and reports back with useful information.','WIS'),], true,),
  //PlayerSkill(5,'skill','FACESHIFTER', 'CHA', 'You take the appearance of a person you see or remember.',[], false,),
  //PlayerSkill(6,'skill','ALTER SENSES', 'WIS', 'You can affect peoples senses, enhancing or taking them away.',[Option(0,'SIGHT','Make them blind, see through walls, x-ray, etc.','WIS'),Option(1,'HEARING','Make them deaf, sense microwaves, understand different languages, etc.','CON',),Option(2,'TOUCH','Make them unable to move or run faster, etc.','WIS',),Option(3,'VOICE','Make them mute or sing better, shot louder, etc.','WIS'),], true,),
  //PlayerSkill(1,'skill','METAMORPHOSIS', 'CON', 'You transform into a creature of your choice.',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(1,'ARMOR','You receive a bonus of +2 to your armor.','CON',),Option(2,'ABILITY','You receive an ability that matches your new form.','CON',),Option(3,'ATTRIBUTE','You receive a bonus of +1 to the attribute of your choice.','CON'),], false,),
  //PlayerSkill(2,'skill','REGENERATION', 'CON', 'You gain the ability to regenerate.',[Option(0,'REGENERATE','You close your wounds and grow lost limbs. Heal 2D6 HP.','CON')], false,),
  //PlayerSkill(3,'skill','WAR CRY', 'CON', 'Your shouts roar through the battlefield.',[Option(0,'FEAR','You frightened your enemies and they run away.','CON'),Option(1,'TAUNT','You taunt your enemies and they run towards you.','CON',),Option(2,'STOP','Your shout makes your enemies stop.','CON',),Option(3,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),], false,),
  //PlayerSkill(5,'skill','HOLY BLADE', 'WIS', '',[], false,),
  //PlayerSkill(11,'skill','WHISPER', 'CHA', 'Your whispers allow you to affect people’s thoughts.',[Option(0,'DREAMS','You enter their dreams.','CHA'),Option(1,'MEMORY','You change their memory by adding, changing or removing something.','CHA',),Option(2,'OBJECTIVE','You change their immediate objectives.','CHA',),Option(3,'BELIEFS','You change their belief in something or someone.','CHA'),], true,),
  //PlayerSkill(12,'skill','PERFORM', 'CHA', 'Your performance inspire your allies, making them better.',[Option(0,'DAMAGE','They receive a bonus of +2 to their damage.','CHA'),Option(1,'ATTRIBUTE','You receive a bonus of +1 to the attribute of your choice.','CHA',),Option(2,'WAKE UP','They wake up and recover from any mental state.','CHA',),Option(3,'DEFENCE','They receive a bonus of +1 to their armor.','CHA'),], true,),

  // ];

  PlayerAction displaySkill = skills[6];

  List<String> selectedSkill = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  var displayedOptions = List<Widget>.empty(growable: true);

  var alertOptions = List<Widget>.empty(growable: true);

  void skillSelection(index) {
    displayedOptions.clear();
    alertOptions.clear();

    selectedSkill = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];
    selectedSkill.replaceRange(index, index + 1, [skills[index].icon]);

    widget.dsix.getCurrentPlayer().playerAction[5] = skills[index];

    displaySkill = widget.dsix.getCurrentPlayer().playerAction[5];
  }

  showAlertDialogDescription(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          displaySkill.option[index].name,
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
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    displaySkill.option[index].description,
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

  Route _createRouteAttribute() {
    //ROUTE TO ATTRIBUTE PAGE
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayerAttributePage(
        dsix: widget.dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          backgroundColor:
              widget.dsix.getCurrentPlayer().playerColor.primaryColor,
          centerTitle: true,
          title: new Text(
            'Skill   ',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Headline',
              height: 1.1,
              fontSize: 25.0,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: AnimatedContainer(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 400),
                width: _size,
                height: _size,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.lightGreenAccent,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createRouteAttribute());
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
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
                    child: Stack(
                      children: <Widget>[
                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SvgPicture.asset(
                                'assets/action/${skills[index].icon}.svg',
                                color: Colors.white,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            );
                          }),
                        ),
                        GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    skillSelection(index);
                                    _updateState();
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/action/${selectedSkill[index]}.svg',
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
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
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
              ),
              Expanded(
                flex: 13,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${displaySkill.name}',
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 50,
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            displaySkill.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1.3,
                              fontSize: 22,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.0 +
                              displaySkill.option.length * 56,
                          child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              itemCount: displaySkill.option.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  style: TextButton.styleFrom(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  ),
                                  onPressed: () {
                                    showAlertDialogDescription(context, index);
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 12, 12, 0),
                                              child: SvgPicture.asset(
                                                'assets/ui/help.svg',
                                                color: widget.dsix
                                                    .getCurrentPlayer()
                                                    .playerColor
                                                    .primaryColor,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.055,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: widget.dsix
                                                .getCurrentPlayer()
                                                .playerColor
                                                .primaryColor,
                                            width:
                                                2.5, //                   <--- border width here
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Center(
                                            child: Text(
                                              displaySkill.option[index].name,
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
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

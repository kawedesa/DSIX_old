import 'package:dsixv02app/models/player/option.dart';
import 'package:dsixv02app/models/player/playerAction.dart';

class PlayerSkillList {
  List<PlayerAction> skills = [
    PlayerAction(
      icon: 'metamorphosis',
      name: 'METAMORPHOSIS',
      description:
          'You morph into a animal of similar size  and gain new abilities.',
      option: [
        Option(
            'MORPH',
            'Your body and belongings morph into a new shape.',
            'Choose two abilities',
            'Choose one ability',
            'Something bad happens.',
            'ABILITY',
            true),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'illusion',
      name: 'ILLUSION',
      description: 'You create an illusion that tricks people\'s minds.',
      option: [
        Option(
            'ILLUSION',
            'You make everyone in a large area around you see, hear, smell, taste or feel anything you want.',
            'Choose two senses',
            'Choose one sense',
            'Something bad happens.',
            'SENSES',
            true),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'bomber',
      name: 'BOMBER',
      description:
          'You create a bomb that causes different effects on explosion.',
      option: [
        Option(
            'FIRE BOMB',
            'It burns everything in a small area.',
            'You hit the mark.',
            'It lands close.',
            'Something bad happens.',
            'DAMAGE',
            true),
        Option(
            'SMOKE BOMB',
            'It creates a thick cloud over a medium area.',
            'You hit the mark.',
            'It lands close.',
            'Something bad happens.',
            'SMOKE',
            false),
        Option(
            'ICE BOMB',
            'It freezes everything in a small area.',
            'You hit the mark.',
            'It lands close.',
            'Something bad happens.',
            'FREEZE',
            false),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'earthlist',
      name: 'EARTHLIST',
      description: 'You control the ground around you.',
      option: [
        Option(
            'DIG',
            'You create a hole.',
            'You dig a deep hole in a area around you.',
            'You dig a shallow around you.',
            'Something bad happens.',
            'DIG',
            false),
        Option(
            'HOLD',
            'You hold someone.',
            'You hold them completly.',
            'You hold one of their arms or legs. ',
            'Something bad happens.',
            'HOLD',
            false),
        Option(
            'BUILD',
            'You build a simple structure.',
            'Your structure is stable.',
            'Your structure is unstable.',
            'Something bad happens.',
            'BUILD',
            false),
        Option(
            'DESTROY',
            'You destroy an object or structure.',
            'You destroy the target.',
            'You make it weaker. ',
            'Something bad happens.',
            'DESTROY',
            false),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'faceshifter',
      name: 'FACESHIFTER',
      description: 'You change your voice and appearance.',
      option: [
        Option(
            'TRANSFORM',
            'Your body and voice changes to mach the person of your choice.',
            'Choose two options.',
            'Choose one option.',
            'Something bad happens.',
            'TRANSFORM',
            true)
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'alterSenses',
      name: 'ALTER SENSES',
      description:
          'You bless or curse anyone you touch. Enhancing or taking away their senses.',
      option: [
        Option(
            'ENHANCE',
            'You make them see through walls, hear whispers or track a scent from far away.',
            'Choose two senses.',
            'Choose one sense.',
            'Something bad happens.',
            'SENSES',
            true),
        Option(
            'REMOVE',
            'You make them blind, deaf or numb.',
            'Choose two senses.',
            'Choose one sense.',
            'Something bad happens.',
            'SENSES',
            true)
      ],
      value: 0,
      bonus: 0,
    ),

    //OLD SKILLS

    //PlayerAction('callOfNature', 'CALL OF NATURE', 'You call for help and nature comes to your aid. It follows your command, but may ask for something in return.',[Option('ATTACK','You mark a target and nature strikes anyway it can.','Nature strikes your target with full force.', 'Nature strikes the target.', 'Nature fails and something bad happens.'), Option('DEFEND','You call for help and nature protects you any way it can.a wind to blow your enemies away, vines to hold them down, branches to block their attacks, etc.','Nature protects the target from the attack. Roll to see how much it protects.','Nature gets just in time to block part of the attack. Roll to see how much it protects.','It doesn\'t protect the target in time and something bad happens.' ), Option('SCOUT','You call birds to scout an area, mice to find an exit, snakes to scene a threat, etc.','You get meaningful information.','You get meaningful information, but nature asks for retribution.', 'You uncover an ugly truth.'),],0),
    //PlayerAction('alchemy', 'ALCHEMY', 'You throw a mixture that splashes on contact and causes different effects.',[Option('OIL','It makes the surface slippery and flammable.','You splash a medium area with a flammable fluid, making it slippery.', 'You splash a small area with a flammable fluid, making it slippery.','You miss the target and something bad happens.'), Option('SMOKE','It creates a cloud of thick smoke that blocks vision.','It makes a large cloud of thick smoke around the impact area.', 'It makes a medium cloud of thick smoke around the impact area.', 'You miss the target and something bad happens.'), Option('ICE','It freezes anything it touches.','You freeze a medium area around the impact point.', 'You freeze a small area around the impact point.', 'You miss and something bad happens.'), Option('FIRE','It explodes on impact and sets fire to anything near by.','It explodes on impact, setting fire to a medium area. Roll your damage.', 'It explodes on impact, setting fire to a small area. Roll your damage.', 'You miss and something bad happens.')],0),
    //PlayerAction('controlOverMatter', 'CONTROL OVER MATTER', 'You change the environment around you, changing it\'s physical properties.',[Option(0,'BRIGHTNESS','You make the environment around you bright or dark.',), Option(1,'HARDNESS','You make the things around you soft, hard or liquid.',), Option(2,'FRICTION','You make things around you slippery or sticky.',), Option(3,'VISIBILITY','You make things around you appear or disappear.',)],0),
    //PlayerAction('illusion', 'ILLUSION', 'You create an illusion that tricks people\'s senses. It requires focus.',[Option(0,'SOUND','You create sounds, noises, voices and music.',), Option(1,'SMELL','You create smells, scents, perfumes, etc.',), Option(2,'VISION','You create figures, shadows, animals, objects, etc.',), Option(3,'TASTE','You make them taste what you want.',), Option(4,'TOUCH','You make them feel any physical sensation, like warmth, cold, pain, pressure, etc.',)],0),
    //PlayerAction('alterSenses', 'ALTER SENSES', 'You can bless or curse anyone you touch. Enhancing or taking away their senses.',[Option(0,'SOUND','ENHANCE - They can hear things from further away, through walls, etc.\nREMOVE - You make them deaf.',), Option(1,'SMELL','ENHANCE - They can smell things from further away, track a scent, detect poisons, etc. \nREMOVE - You remove their sense of smell.',), Option(2,'VISION','ENHANCE - They can see things that are further away, in the dark, through walls, etc. \nREMOVE - You make them blind.',), Option(3,'TASTE','ENHANCE - They can distinguish the smallest variations in the things they taste. Like age, ingredients, where it\'s been, etc. \nREMOVE - You change or remove their sense of taste.',), Option(4,'TOUCH','ENHANCE - They feel the slightest changes in their environment, like vibrations, temperature, wind, etc. \nREMOVE - You make them numb and take away their pain.',)],0),

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
  ];
}

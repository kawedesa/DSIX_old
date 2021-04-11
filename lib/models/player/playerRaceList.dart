import 'bonus.dart';
import 'package:dsixv02app/models/player/playerRace.dart';

class PlayerRaceList {
  List<PlayerRace> races = [
    PlayerRace(
        'human',
        'HUMAN',
        'Humans are everywhere. They are flexible and adapt to most circumstances, so you get an extra action point to spend anyway you want.',
        [
          Bonus(
              '+ ACTION POINT  ',
              'actionPoint',
              'Each action point allows you to improve the chance of success of an action for ever.',
              1)
        ]),
    PlayerRace(
        'orc',
        'ORC',
        'Orcs are tall and strong, making them good fighters but easy targets. They can carry more weight, but have a harder time moving around.',
        [
          Bonus('+ ATTACK  ', 'attack',
              'You use this action when you attack a target.', 1),
          Bonus(
              '- MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              -1),
          Bonus(
              '+ WEIGHT  ',
              'maxWeight',
              'This represents the total amount of weight you can carry. Because of your strength, you can carry +6 weight.',
              6)
        ]),
    PlayerRace(
        'goblin',
        'GOBLIN',
        'Goblins are small, vicious creatures with sharp teeth and quick feet. They are not really strong, but are still very dangerous.',
        [
          Bonus('+ ATTACK  ', 'attack',
              'You use this action when you attack a target.', 1),
          Bonus(
              '+ MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              1),
          Bonus(
              '- WEIGHT  ',
              'maxWeight',
              'This represents the total amount of weight you can carry. Because you are weak, you carry -6 weight.',
              -6)
        ]),
    PlayerRace(
        'dwarf',
        'DWARF',
        'Dwarfs are sturdy, allowing them to take more blows before going down. However, their small size and stubborn personality limits their perception.',
        [
          Bonus('+ DEFENSE  ', 'defense',
              'You use this action when you protect yourself or others.', 1),
          Bonus('- PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', -1),
          Bonus(
              '+ HEALTH  ',
              'maxHealth',
              'This represents your total health and you die when it reaches zero. Because of your sturdy nature you have +6 HP.',
              6)
        ]),
    PlayerRace(
        'halfling',
        'HALFLING',
        'Halflings are small curious creatures, always looking for something new to learn. They are not really good at fighting and try to solve most problems without violence.',
        [
          Bonus('- ATTACK  ', 'attack',
              'You use this action when you attack a target.', -1),
          Bonus('+ PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', 1),
          Bonus(
              '+ TALK  ',
              'talk',
              'You use this action when you talk to someone that can understand you.',
              1)
        ]),
    PlayerRace(
        'elf',
        'ELF',
        'Elves have slim bodies and sharp senses, making them very perceptive and agile. Because of their frail constitution, they rely on their reflexes to avoid danger.',
        [
          Bonus('- DEFENSE  ', 'defense',
              'You use this action when you protect yourself or others.', -1),
          Bonus('+ PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', 1),
          Bonus(
              '+ MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              1)
        ]),

//PlayerRace('gnome','GNOME','Gnomes are small and curious creatures, that are always working on a crazy project.',Bonus(0,'INVENTION', 'Choose your invention:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('darkElf','DARK ELF','Dark elfs are smarter than most people, making them quite arrogant.',Bonus(1,'INTELLIGENCE', 'Intelligence represents how much you know about the world.',[])),
    //PlayerRace('machine','MACHINE','Machines are created with the ability to perform a task. They are everywhere, but only a few of them are conscious.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('elemental','ELEMENTAL','Elementals are powerful magical beings, that live in nature and protect their habitat.',Bonus(2,'MAGIC ARMOR', 'You have a defensive layer that protects against magic attacks.',[])),
    //PlayerRace('lizard','LIZARD','Lizards are covered with beautiful scales that offer protection.',Bonus(2,'ARMOR', 'Your scales protect against physical attacks.',[])),
    //PlayerRace('beast','BEAST','Beasts vary in size and power. Each one has a different ability that helps them survive in nature.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
  ];
}

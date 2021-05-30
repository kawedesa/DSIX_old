import 'bonus.dart';
import 'package:dsixv02app/models/player/playerRace.dart';

class PlayerRaceList {
  List<PlayerRace> races = [
    PlayerRace(
        'human',
        'HUMAN',
        'Humans are flexible and adapt to anything, because they learn quicker than others.',
        [
          Bonus('+ ACTION POINT  ', 'actionPoint',
              'Action points allow you to do something better.', 1)
        ]),
    PlayerRace(
        'orc',
        'ORC',
        'Orcs are tall and strong, making them good fighters, but easy targets.',
        [
          Bonus('+ ATTACK  ', 'attack', 'You are good at attacking things.', 1),
          Bonus('- MOVE  ', 'move', 'You are slow.', -1),
          Bonus('STRONG  ', 'maxWeight',
              'You are strong and can carry more things.', 6)
        ]),
    PlayerRace('goblin', 'GOBLIN',
        'Goblins are small creatures with sharp teeth and quick feet.', [
      Bonus('+ ATTACK  ', 'attack', 'You are good at attacking things.', 1),
      Bonus('+ MOVE  ', 'move', 'You are fast.', 1),
      Bonus('WEAK  ', 'maxWeight',
          'You are weak and can\'t carry a lot of things.', -6)
    ]),
    PlayerRace('dwarf', 'DWARF',
        'Dwarfs have long beards and are small, tough and stubborn.', [
      Bonus('+ DEFEND  ', 'defense', 'You are good at protecting things.', 1),
      Bonus('- LOOK  ', 'perceive', 'Your size limits your vision.', -1),
      Bonus(
          'TOUGH  ', 'maxHealth', 'You take more blows befores going down.', 6)
    ]),
    PlayerRace(
        'halfling',
        'HALFLING',
        'Halflings are small curious creatures, always looking for something new to learn.',
        [
          Bonus('- ATTACK  ', 'attack',
              'You are not really good at attacking things.', -1),
          Bonus('+ LOOK  ', 'perceive', 'You have amazing senses.', 1),
          Bonus('+ TALK  ', 'talk', 'You are charismatic, and people like you.',
              1)
        ]),
    PlayerRace('elf', 'ELF',
        'Elves have sharp senses, making them very perceptive and agile.', [
      Bonus('- DEFENSE  ', 'defense',
          'You are not really good at protecting things.', -1),
      Bonus('+ LOOK  ', 'perceive', 'You have amazing senses.', 1),
      Bonus('+ MOVE  ', 'move', 'You are fast.', 1)
    ]),

//PlayerRace('gnome','GNOME','Gnomes are small and curious creatures, that are always working on a crazy project.',Bonus(0,'INVENTION', 'Choose your invention:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('darkElf','DARK ELF','Dark elfs are smarter than most people, making them quite arrogant.',Bonus(1,'INTELLIGENCE', 'Intelligence represents how much you know about the world.',[])),
    //PlayerRace('machine','MACHINE','Machines are created with the ability to perform a task. They are everywhere, but only a few of them are conscious.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('elemental','ELEMENTAL','Elementals are powerful magical beings, that live in nature and protect their habitat.',Bonus(2,'MAGIC ARMOR', 'You have a defensive layer that protects against magic attacks.',[])),
    //PlayerRace('lizard','LIZARD','Lizards are covered with beautiful scales that offer protection.',Bonus(2,'ARMOR', 'Your scales protect against physical attacks.',[])),
    //PlayerRace('beast','BEAST','Beasts vary in size and power. Each one has a different ability that helps them survive in nature.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
  ];
}

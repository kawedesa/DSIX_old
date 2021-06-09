import 'bonus.dart';
import 'package:dsixv02app/models/player/playerRace.dart';

class PlayerRaceList {
  List<PlayerRace> races = [
    PlayerRace(
        icon: 'human',
        race: 'HUMAN',
        description:
            'Humans are flexible and can adapt to anything. They have the worlds largest population.',
        maxHealth: 12,
        maxWeight: 12,
        actionPoints: [
          2,
          1,
          1,
          1,
          1,
          1,
          1
        ],
        bonus: [
          Bonus(
            'FLEXIBLE  ',
            'actionPoint',
            'Humans are flexible and can perform any role.',
          )
        ]),
    PlayerRace(
        icon: 'orc',
        race: 'ORC',
        description:
            'Orcs are big and strong, making them good warriors, but easy targets.',
        maxHealth: 12,
        maxWeight: 16,
        actionPoints: [
          3,
          1,
          0,
          0,
          0,
          -1,
          0
        ],
        bonus: [
          Bonus(
            'BIG  ',
            'move',
            'Your size makes it hard for you to move around.',
          ),
          Bonus(
            'STRONG  ',
            'maxWeight',
            'You are strong and can carry more things.',
          ),
          Bonus(
            'WARRIOR  ',
            'attack',
            'You are a warrior and know how to fight.',
          ),
        ]),
    PlayerRace(
        icon: 'goblin',
        race: 'GOBLIN',
        description:
            'Goblins are small vicious creatures with sharp teeth and quick feet.',
        maxHealth: 12,
        maxWeight: 8,
        actionPoints: [
          3,
          1,
          0,
          0,
          0,
          1,
          0
        ],
        bonus: [
          Bonus(
            'VICIOUS  ',
            'attack',
            'You are evil and love hurting others. Sometimes even yourself.',
          ),
          Bonus(
            'QUICK FEET  ',
            'move',
            'You are fast and have quick reflexes.',
          ),
          Bonus(
            'WEAK  ',
            'maxWeight',
            'You are weak and can\'t carry a lot of things.',
          )
        ]),
    PlayerRace(
        icon: 'dwarf',
        race: 'DWARF',
        description:
            'Dwarfs have long beards and love to drink. They are small, tough and stubborn.',
        maxHealth: 16,
        maxWeight: 12,
        actionPoints: [
          3,
          0,
          1,
          -1,
          0,
          0,
          0
        ],
        bonus: [
          Bonus(
            'STUBBORN  ',
            'perceive',
            'Your size and stubborn personality limits your perception of things.',
          ),
          Bonus(
            'TOUGH  ',
            'maxHealth',
            'You can take more blows befores going down.',
          )
        ]),
    PlayerRace(
        icon: 'halfling',
        race: 'HALFLING',
        description:
            'Halflings are small curious creatures, always looking for something new to learn.',
        maxHealth: 12,
        maxWeight: 12,
        actionPoints: [
          3,
          -1,
          0,
          1,
          1,
          0,
          0
        ],
        bonus: [
          Bonus(
            'PEACEFUL  ',
            'attack',
            'You are peaceful and hate violence.',
          ),
          Bonus(
            'CURIOUS  ',
            'perceive',
            'You are always intrigued by your surrounding.',
          ),
          Bonus(
            'CHARISMATIC  ',
            'talk',
            'You are friendly and people usually like you.',
          )
        ]),
    PlayerRace(
        icon: 'elf',
        race: 'ELF',
        description:
            'Elves have quick reflexes and sharp senses, making them very agile and precise.',
        maxHealth: 16,
        maxWeight: 12,
        actionPoints: [
          3,
          0,
          -1,
          1,
          0,
          1,
          0
        ],
        bonus: [
          Bonus(
            'QUICK REFLEXES  ',
            'defense',
            'Your instinct is to get out of the way, instead of holding your ground.',
          ),
          Bonus(
            'KEEN SENSES  ',
            'perceive',
            'You have perfect vision and amazing hearing.',
          ),
        ]),

//PlayerRace('gnome','GNOME','Gnomes are small and curious creatures, that are always working on a crazy project.',Bonus(0,'INVENTION', 'Choose your invention:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('darkElf','DARK ELF','Dark elfs are smarter than most people, making them quite arrogant.',Bonus(1,'INTELLIGENCE', 'Intelligence represents how much you know about the world.',[])),
    //PlayerRace('machine','MACHINE','Machines are created with the ability to perform a task. They are everywhere, but only a few of them are conscious.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('elemental','ELEMENTAL','Elementals are powerful magical beings, that live in nature and protect their habitat.',Bonus(2,'MAGIC ARMOR', 'You have a defensive layer that protects against magic attacks.',[])),
    //PlayerRace('lizard','LIZARD','Lizards are covered with beautiful scales that offer protection.',Bonus(2,'ARMOR', 'Your scales protect against physical attacks.',[])),
    //PlayerRace('beast','BEAST','Beasts vary in size and power. Each one has a different ability that helps them survive in nature.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
  ];
}

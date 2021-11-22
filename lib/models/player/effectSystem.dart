import 'package:dsixv02app/models/player/action/actionOption.dart';
import 'package:dsixv02app/models/dsix/effect.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/action/playerBasicActions.dart';

class EffectSystem {
  void removeAllEffectsFromOrigin(String origin, Player player) {
    List<Effect> effectsToRemove = [];

    player.currentEffects.forEach((element) {
      if (element.origin == origin) {
        effectsToRemove.add(element);
      }
    });

    if (effectsToRemove.length > 0) {
      effectsToRemove.forEach((element) {
        player.currentEffects.remove(element);
        removeTemporaryEffect(element.name, player);
      });
    }
    player.updateStats();
  }

  void addEffect(String type, String name, int duration, Player player) {
    Effect newEffect = Effect();

    switch (type) {
      case 'positive':
        this.positiveEffects.forEach((element) {
          if (element.name == name) {
            newEffect = element;
          }
        });

        break;
      case 'negative':
        this.negativeEffects.forEach((element) {
          if (element.name == name) {
            newEffect = element;
          }
        });
        break;
    }

    newEffect.copyEffect();
    newEffect.duration = duration;
    newTemporaryEffect(name, duration, player);
    player.currentEffects.add(newEffect);
    player.updateStats();
  }

  List<Effect> negativeEffects = [
    Effect(
      icon: 'weak',
      name: 'weak',
      description: 'You are weak.',
      value: 2,
    ),
    Effect(
      icon: 'vulnerable',
      name: 'vulnerable',
      description: 'You are vulnerable.',
      value: 2,
    ),
    Effect(
      icon: 'dull',
      name: 'dull',
      description: 'You are dull.',
      value: 2,
    ),
    Effect(
      icon: 'inconvenient',
      name: 'inconvenient',
      description: 'You are inconvenient.',
      value: 2,
    ),
    Effect(
      icon: 'slow',
      name: 'slow',
      description: 'You are slow.',
      value: 2,
    ),
  ];
  List<Effect> positiveEffects = [
//Actions
    Effect(
      icon: 'powerful',
      name: 'powerful',
      description: 'You are powerful.',
      value: 2,
    ),
    Effect(
      icon: 'defensive',
      name: 'defensive',
      description: 'You are defensive.',
      value: 2,
    ),
    Effect(
      icon: 'perceptive',
      name: 'perceptive',
      description: 'You are perceptive.',
      value: 2,
    ),
    Effect(
      icon: 'charismatic',
      name: 'charismatic',
      description: 'You are charismatic.',
      value: 2,
    ),
    Effect(
      icon: 'fast',
      name: 'fast',
      description: 'You are fast.',
      value: 2,
    ),

//Armor

    Effect(
      icon: 'magicResistance',
      name: 'magic resistance',
      description: 'Increase your magic resistance.',
      value: 2,
    ),

    Effect(
      icon: 'armor',
      name: 'Armor',
      description: 'Increase your armor.',
      value: 2,
    ),

//Damage

    Effect(
      icon: 'empowered',
      name: 'empowered',
      description: 'Increase your magic damage.',
      value: 2,
    ),

    Effect(
      icon: 'powerful',
      name: 'powerful',
      description: 'Increase your phisical damage.',
      value: 2,
    ),

    //Illusion

    Effect(
      icon: 'illusion',
      name: 'large creature',
      description: 'Create the illusion of a large creature.',
      origin: 'illusion',
    ),

    Effect(
      icon: 'illusion',
      name: 'group of people',
      description: 'Create the illusion of a group of people.',
      origin: 'illusion',
    ),
    Effect(
      icon: 'illusion',
      name: 'structure',
      description: 'Create the illusion of a structure.',
      origin: 'illusion',
    ),
    Effect(
      icon: 'illusion',
      name: 'objects',
      description: 'Create the illusion of some objects.',
      origin: 'illusion',
    ),

    Effect(
      icon: 'illusion',
      name: 'obstacle',
      description: 'Create the illusion of a obstacle.',
      origin: 'illusion',
    ),
    Effect(
      icon: 'illusion',
      name: 'animals',
      description: 'Create the illusion of some animals.',
      origin: 'illusion',
    ),
    Effect(
      icon: 'illusion',
      name: 'person',
      description: 'Create the illusion of a person.',
      origin: 'illusion',
    ),

    Effect(
      icon: 'illusion',
      name: 'light',
      description: 'Create a the illusion of a light source.',
      origin: 'illusion',
    ),

    Effect(
      icon: 'illusion',
      name: 'sound',
      description: 'Create the illusion of sounds.',
      origin: 'illusion',
    ),
    Effect(
      icon: 'illusion',
      name: 'small creature',
      description: 'Create the illusion of a small creature.',
      origin: 'illusion',
    ),

//Morph

    Effect(
      icon: 'morphPuma',
      name: 'puma',
      description: 'You morph into a puma.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphCrocodile',
      name: 'crocodile',
      description: 'You morph into a crocodile.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphGorilla',
      name: 'gorilla',
      description: 'You morph into a gorilla.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphRhino',
      name: 'rhino',
      description: 'You morph into a rhino.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphElephant',
      name: 'elephant',
      description: 'You morph into a elephant.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphBear',
      name: 'bear',
      description: 'You morph into a bear.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphCrab',
      name: 'crab',
      description: 'You morph into a crab.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphSnake',
      name: 'snake',
      description: 'You morph into a snake.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphBird',
      name: 'bird',
      description: 'You morph into a bird.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphBull',
      name: 'bull',
      description: 'You morph into a bull.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphBat',
      name: 'bat',
      description: 'You morph into a bat.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphFox',
      name: 'fox',
      description: 'You morph into a fox.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphBug',
      name: 'bug',
      description: 'You morph into a bug.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphTurtle',
      name: 'turtle',
      description: 'You morph into a turtle.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphMonkey',
      name: 'monkey',
      description: 'You morph into a monkey.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphFish',
      name: 'fish',
      description: 'You morph into a fish.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphChameleon',
      name: 'chameleon',
      description: 'You morph into a chameleon.',
      origin: 'morph',
    ),
    Effect(
      icon: 'morphFrog',
      name: 'frog',
      description: 'You morph into a frog.',
      origin: 'morph',
    ),

// Enchant - Bless

    Effect(
      icon: 'enchant',
      name: 'night vision',
      description: 'You see in the dark.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'charisma',
      description: 'You see in the dark.',
      origin: 'enchant',
    ),

    Effect(
      icon: 'enchant',
      name: 'x-ray vision',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'ultrasonic hearing',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'speed',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'power',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'climb',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'fly',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'breath underwater',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
    Effect(
      icon: 'enchant',
      name: 'thick skin',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),

    Effect(
      icon: 'enchant',
      name: 'super strenght',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),

    Effect(
      icon: 'enchant',
      name: 'super jump',
      description: 'You see through objects and walls.',
      origin: 'enchant',
    ),
  ];

//Effects mechanics

  void newTemporaryEffect(String name, int duration, Player player) {
    switch (name) {
      case 'powerful':
        {
          player.actions[0].value++;
          player.actions[0].option.forEach((element) {
            element.value = player.actions[5].value;
          });
        }
        break;
      case 'weak':
        {
          player.actions[0].value--;
          player.actions[0].option.forEach((element) {
            element.value = player.actions[0].value;
          });
        }
        break;
      case 'defensive':
        {
          player.actions[1].value++;
          player.actions[1].option.forEach((element) {
            element.value = player.actions[1].value;
          });
        }
        break;
      case 'vulnerable':
        {
          player.actions[1].value--;
          player.actions[1].option.forEach((element) {
            element.value = player.actions[1].value;
          });
        }
        break;

      case 'perceptive':
        {
          player.actions[2].value++;
          player.actions[2].option.forEach((element) {
            element.value = player.actions[2].value;
          });
        }
        break;
      case 'dull':
        {
          player.actions[2].value--;
          player.actions[2].option.forEach((element) {
            element.value = player.actions[2].value;
          });
        }
        break;
      case 'charismatic':
        {
          player.actions[3].value++;
          player.actions[3].option.forEach((element) {
            element.value = player.actions[4].value;
          });
        }
        break;
      case 'inconvenient':
        {
          player.actions[3].value--;
          player.actions[3].option.forEach((element) {
            element.value = player.actions[4].value;
          });
        }
        break;

      case 'fast':
        {
          player.actions[4].value++;
          player.actions[4].option.forEach((element) {
            element.value = player.actions[5].value;
          });
        }
        break;
      case 'slow':
        {
          player.actions[4].value--;
          player.actions[4].option.forEach((element) {
            element.value = player.actions[5].value;
          });
        }
        break;

      case 'magic resistance':
        {
          player.mArmorEffect += 3;
        }
        break;

      //MORPH EFFECTS

      case 'puma':
        {
          //ADD BITE AND SLASH
          removeActionOption(
              'attack',
              [player.actions[0].option[0], player.actions[0].option[1]],
              player);
          player.actions[0].option[0].name = 'bite';
          player.actions[0].option[1].name = 'slash'; // adds bleed

          //Fast
          player.actions[4].option.forEach((actionOption) {
            actionOption.value += 1;
          });

          if (player.actions[4].value < 3) {
            player.actions[4].value += 1;
          }

          //ADD HIDE
          player.actions[4].option[2].value += 2;

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;
        }
        break;
      case 'rhino':
        {
          //ADD CHARGE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'charge';

          //THICK SKIN
          player.pArmorEffect += 2;
          player.mArmorEffect += 2;

          //THICK SKIN
          player.pArmorEffect += 2;
          player.mArmorEffect += 2;

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;
        }
        break;

      case 'elephant':
        {
          //ADD GRAB AND TRAMPLE
          removeActionOption(
              'attack',
              [player.actions[0].option[0], player.actions[0].option[1]],
              player);
          player.actions[0].option[0].name = 'grab';
          player.actions[0].option[1].name = 'trample'; // adds bleed

          //STRONG
          player.pDamageEffect += 3;

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;
        }
        break;

      case 'crocodile':
        {
          //ADD BITE AND TWIST
          removeActionOption(
              'attack',
              [player.actions[0].option[0], player.actions[0].option[1]],
              player);
          player.actions[0].option[0].name = 'bite';
          player.actions[0].option[1].name = 'twist'; // +5 ON ATTACK

          //ADD SWIM
          player.actions[4].option[5].value += 2;
          //ADD HIDE
          player.actions[4].option[2].value += 2;

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;
        }
        break;

      case 'bear':
        {
          //ADD CONSTRICT AND BITE
          removeActionOption(
              'attack',
              [player.actions[0].option[0], player.actions[0].option[1]],
              player);
          player.actions[0].option[0].name = 'bite';
          player.actions[0].option[1].name = 'slash'; // adds bleed

          //THICK FUR
          player.pArmorEffect += 2;
          player.mArmorEffect += 2;

          //PROTECTIVE INSTINCT
          //DEFENCE +1
          player.actions[1].option.forEach((actionOption) {
            actionOption.value += 1;
          });

          if (player.actions[1].value < 3) {
            player.actions[1].value += 1;
          }

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;
        }
        break;

      case 'gorilla':
        {
          //ADD THROW and GRAB
          player.actions[0].option[0].name = 'grab';
          player.actions[0].option[1].name = 'throw';
          player.actions[0].option[2].name = 'weapon';

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //STRONG
          player.pDamageEffect += 3;

          //ADD CLIMB
          player.actions[4].option[4].value += 2;
        }
        break;

      case 'bull':
        {
          //ADD CHARGE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'charge';

          //add LIFT
          player.actions[1].option[3].value += 2;

          //LARGE
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //ADD LIFT

        }
        break;

      case 'crab':
        {
          //ADD GRAB
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'grab';

          //ADD CLIMB
          player.actions[4].option[4].value += 2;

          //ADD SWIM
          player.actions[4].option[5].value += 2;

          //SHELL
          player.pArmorEffect += 4;
          player.mArmorEffect += 4;
        }
        break;

      case 'snake':
        {
          //ADD CONSTRICT AND BITE
          removeActionOption(
              'attack',
              [player.actions[0].option[0], player.actions[0].option[1]],
              player);
          player.actions[0].option[0].name = 'bite';
          player.actions[0].option[1].name = 'constrict';

          //ADD CLIMB
          player.actions[4].option[4].value += 2;
        }
        break;

      case 'bat':
        {
          //ADD BITE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //SWITCH FLY +2 FOR JUMP
          player.actions[4].option[3].name = 'fly';
          player.actions[4].option[3].value += 2;

          //Perceptive
          player.actions[2].option.forEach((actionOption) {
            actionOption.value += 1;
          });

          if (player.actions[2].value < 3) {
            player.actions[2].value += 1;
          }
        }
        break;

      case 'fox':
        {
          //ADD BITE ATTACK
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //Fast
          player.actions[4].option.forEach((actionOption) {
            actionOption.value += 1;
          });

          if (player.actions[4].value < 3) {
            player.actions[4].value += 1;
          }

          //ESCAPE +2
          player.actions[4].option[1].value += 2;

          //Perceptive
          player.actions[2].option.forEach((actionOption) {
            actionOption.value += 1;
          });

          if (player.actions[2].value < 3) {
            player.actions[2].value += 1;
          }
        }
        break;

      case 'bird':
        {
          //ADD PECK
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'peck';

          //SHARP BEAK
          player.pDamageEffect += 2;

          //SWITCH FLY +2 FOR JUMP
          player.actions[4].option[3].name = 'fly';
          player.actions[4].option[3].value += 2;
        }
        break;

      case 'monkey':
        {
          //ADD BITE BUT KEEP OTHERS
          player.actions[0].option[0].name = 'bite';

          //SHRINK
          player.pDamageEffect -= 2;
          player.pArmorEffect -= 2;
          //ADD CLIMB
          player.actions[4].option[4].value += 2;
        }
        break;
      case 'turtle':
        {
          //ADD BITE ATTACK
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //SHRINK
          player.pDamageEffect -= 2;
          player.pArmorEffect -= 2;

          //SHELL
          player.pArmorEffect += 4;
          player.mArmorEffect += 4;

          //SLOW
          player.actions[4].option.forEach((actionOption) {
            actionOption.value -= 2;
          });
          player.actions[4].value -= 2;
        }
        break;
      case 'chameleon':
        {
          //ADD BITE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //SHRINK
          player.pDamageEffect -= 2;
          player.pArmorEffect -= 2;

          //ADD HIDE
          player.actions[4].option[2].value += 2;
        }
        break;
      case 'fish':
        {
          //ADD BITE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //SHRINK
          player.pDamageEffect -= 2;
          player.pArmorEffect -= 2;

          //ADD SWIM
          player.actions[4].option[5].value += 2;
        }
        break;

      case 'bug':
        {
          //ADD BITE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //SHRINK
          player.pDamageEffect -= 2;
          player.pArmorEffect -= 2;

          //SWITCH FLY+2 FOR SWIM
          player.actions[4].option[5].name = 'fly';
          player.actions[4].option[5].value += 2;
        }
        break;

      case 'frog':
        {
          //ADD BITE
          removeActionOption('attack', [player.actions[0].option[0]], player);
          player.actions[0].option[0].name = 'bite';

          //SHRINK
          player.pDamageEffect -= 2;
          player.pArmorEffect -= 2;

          //ADD JUMP
          player.actions[4].option[3].value += 2;
        }
        break;
    }
  }

//Run Effects

  void runEffects(Player player) {
    List<Effect> effectsToRemove = [];

    player.currentEffects.forEach((element) {
      element.duration--;
      if (element.duration < 1) {
        removeTemporaryEffect(element.name, player);
        effectsToRemove.add(element);
      }
    });

    effectsToRemove.forEach((element) {
      player.currentEffects.remove(element);
    });
  }

  //REMOVE EFFECTS

  void removeTemporaryEffect(String name, Player player) {
    switch (name) {
      case 'powerful':
        {
          player.actions[0].value--;
          player.actions[0].option.forEach((element) {
            element.value = player.actions[5].value;
          });
        }
        break;
      case 'weak':
        {
          player.actions[0].value++;
          player.actions[0].option.forEach((element) {
            element.value = player.actions[0].value;
          });
        }
        break;
      case 'defensive':
        {
          player.actions[1].value--;
          player.actions[1].option.forEach((element) {
            element.value = player.actions[1].value;
          });
        }
        break;
      case 'vulnerable':
        {
          player.actions[1].value++;
          player.actions[1].option.forEach((element) {
            element.value = player.actions[1].value;
          });
        }
        break;

      case 'perceptive':
        {
          player.actions[2].value--;
          player.actions[2].option.forEach((element) {
            element.value = player.actions[2].value;
          });
        }
        break;
      case 'dull':
        {
          player.actions[2].value++;
          player.actions[2].option.forEach((element) {
            element.value = player.actions[2].value;
          });
        }
        break;
      case 'charismatic':
        {
          player.actions[3].value--;
          player.actions[3].option.forEach((element) {
            element.value = player.actions[3].value;
          });
        }
        break;
      case 'inconvenient':
        {
          player.actions[3].value++;
          player.actions[3].option.forEach((element) {
            element.value = player.actions[3].value;
          });
        }
        break;

      case 'fast':
        {
          player.actions[4].value--;
          player.actions[4].option.forEach((element) {
            element.value = player.actions[4].value;
          });
        }
        break;
      case 'slow':
        {
          player.actions[4].value++;
          player.actions[4].option.forEach((element) {
            element.value = player.actions[4].value;
          });
        }
        break;

      case 'magic resistance':
        {
          player.mArmorEffect -= 3;
        }
        break;

      //MORPH EFFECTS

      case 'puma':
        {
          // remove bite and slash
          restoreAction('attack', 0, player);

          //  remove fast and restore hide
          restoreAction('move', -1, player);

          //  shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;

      case 'rhino':
        {
          // remove charge
          restoreAction('attack', 0, player);

          //remove think skin
          player.pArmorEffect -= 2;
          player.mArmorEffect -= 2;

          //remove think skin
          player.pArmorEffect -= 2;
          player.mArmorEffect -= 2;

          //shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;

      case 'elephant':
        {
          // remove trample
          restoreAction('attack', 0, player);
          // remove strong
          player.pDamageEffect -= 3;
          //shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;

      case 'crocodile':
        {
          //remove bite
          restoreAction('attack', 0, player);
          //restore move
          restoreAction('move', 0, player);
          //shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;

      case 'bear':
        {
          //remove bite
          restoreAction('attack', 0, player);
          //restore defence
          restoreAction('defend', -1, player);
          //remove think fur
          player.pArmorEffect -= 2;
          player.mArmorEffect -= 2;

          //shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;
      case 'gorilla':
        {
          //remove throw and grab
          restoreAction('attack', 0, player);

          //remove climb
          restoreAction('move', 0, player);

          // remove strong
          player.pDamageEffect -= 3;

          //shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;
      case 'bull':
        {
          //remove charge
          restoreAction('attack', 0, player);
          //remove LIFT
          restoreAction('defend', 0, player);
          //shrink
          player.pArmorEffect -= 2;
          player.pDamageEffect -= 2;
        }
        break;
      case 'crab':
        {
          //remove grab
          restoreAction('attack', 0, player);

          //remove climb and swim
          restoreAction('move', 0, player);

          //remove shell
          player.pArmorEffect -= 4;
          player.mArmorEffect -= 4;
        }
        break;

      case 'snake':
        {
          //remove constrict
          restoreAction('attack', 0, player);

          //remove climb
          restoreAction('move', 0, player);
        }
        break;

      case 'bat':
        {
          //remove bite
          restoreAction('attack', 0, player);
          //remove climb
          restoreAction('move', 0, player);
          //remove PERCEPTIVE
          restoreAction('look', -1, player);
        }
        break;

      case 'fox':
        {
          //remove bite
          restoreAction('attack', 0, player);

          //remove FAST
          restoreAction('move', -1, player);
          //remove PERCEPTIVE
          restoreAction('look', -1, player);
        }
        break;

      case 'bird':
        {
          //remove PECK
          restoreAction('attack', 0, player);
          //remove FLY
          restoreAction('move', 0, player);
          //remove sharp beak
          player.pDamageEffect -= 2;
        }
        break;

      case 'monkey':
        {
          //remove PECK
          restoreAction('attack', 0, player);

          //remove climb
          restoreAction('move', 0, player);

          //GROW
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;
        }
        break;
      case 'turtle':
        {
          //remove BITE
          restoreAction('attack', 0, player);

          //remove SLOW
          restoreAction('move', 1, player);

          //GROW
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //REMOVE SHELL
          player.pArmorEffect -= 4;
          player.mArmorEffect -= 4;
        }
        break;
      case 'chameleon':
        {
          //GROW
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //remove HIDE
          restoreAction('move', 0, player);

          //RESTORE ATTACK
          restoreAction('attack', 0, player);
        }
        break;

      case 'fish':
        {
          //GROW
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //remove SWIM
          restoreAction('swim', 0, player);

          //RESTORE ATTACK
          restoreAction('attack', 0, player);
        }
        break;
      case 'bug':
        {
          //GROW
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //remove FLY
          restoreAction('move', 0, player);

          //RESTORE ATTACK
          restoreAction('attack', 0, player);
        }
        break;

      case 'frog':
        {
          //GROW
          player.pDamageEffect += 2;
          player.pArmorEffect += 2;

          //remove JUMP
          restoreAction('move', 0, player);

          //RESTORE ATTACK
          restoreAction('attack', 0, player);
        }
        break;
    }
  }
}

//REMOVE ACTION

void removeActionOption(
    String name, List<ActionOption> keepOptions, Player player) {
  for (int i = 0; i < player.actions.length; i++) {
    if (player.actions[i].name == name) {
      player.actions[i].option.clear();
      player.actions[i].option = keepOptions;
      player.actions[i].option.forEach((option) {
        option.value = player.actions[i].value;
      });
    }
  }
}

//RESTORE ACTIONS

PlayerBasicActions basicActions = PlayerBasicActions();

void restoreAction(String action, int value, Player player) {
  switch (action) {
    case 'attack':
      player.actions[0].option.clear();
      player.actions[0].value += value;
      basicActions.basicActions[0].option.forEach((element) {
        player.actions[0].option.add(element.copyOption());
      });
      player.actions[0].option.forEach((element) {
        element.value = player.actions[0].value;
      });

      break;

    case 'defend':
      player.actions[1].option.clear();
      player.actions[1].value += value;
      basicActions.basicActions[1].option.forEach((element) {
        player.actions[1].option.add(element.copyOption());
      });
      player.actions[1].option.forEach((element) {
        element.value = player.actions[1].value;
      });

      break;

    case 'look':
      player.actions[2].option.clear();
      player.actions[2].value += value;
      basicActions.basicActions[2].option.forEach((element) {
        player.actions[2].option.add(element.copyOption());
      });
      player.actions[2].option.forEach((element) {
        element.value = player.actions[2].value;
      });

      break;

    case 'talk':
      player.actions[3].option.clear();
      player.actions[3].value += value;
      basicActions.basicActions[3].option.forEach((element) {
        player.actions[3].option.add(element.copyOption());
      });
      player.actions[3].option.forEach((element) {
        element.value = player.actions[3].value;
      });

      break;

    case 'move':
      player.actions[4].option.clear();
      player.actions[4].value += value;
      basicActions.basicActions[4].option.forEach((element) {
        player.actions[4].option.add(element.copyOption());
      });
      player.actions[4].option.forEach((element) {
        element.value = player.actions[4].value;
      });

      break;
  }
}

// void quickPositiveEffect(String action, String type, String name, Player player) {
//   switch (action) {
//     case 'attack':
    

//       addEffect('positive', 'powerful', 1, player);
     
//       break;
//     case 'defend':
//       newTemporaryEffect('DEFENSIVE', 1, player);
//       break;
//     case 'look':
//       newTemporaryEffect('PERCEPTIVE', 1, player);
//       break;
//     case 'talk':
//       newTemporaryEffect('CHARISMATIC', 1, plyaer);
//       break;
//     case 'move':
//       newTemporaryEffect('FAST', 1);
//       break;
//   }
// }

// void quickNegativeEffect(String action) {
//   switch (action) {
//     case 'attack':
//       newTemporaryEffect('WEAK', 1);
//       break;
//     case 'defend':
//       newTemporaryEffect('VULNERABLE', 1);
//       break;
//     case 'look':
//       newTemporaryEffect('DULL', 1);
//       break;
//     case 'talk':
//       newTemporaryEffect('INCONVENIENT', 1);
//       break;
//     case 'move':
//       newTemporaryEffect('SLOW', 1);
//       break;
//   }
// }


  //  List<Effect> temporary = [

  //   //ABILITY

  //   Effect(
  //     icon: 'swim',
  //     name: 'SWIM',
  //     description: 'You can move in water.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'climb',
  //     name: 'CLIMB',
  //     description: 'You use the environment to move around.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'jump',
  //     name: 'JUMP',
  //     description: 'You can jump long distances',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'fly',
  //     name: 'FLY',
  //     description: 'You can fly.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'fast',
  //     name: 'FAST',
  //     description: 'You are fast.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'slow',
  //     name: 'FAST',
  //     description: 'You are slow.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'applyPoison',
  //     name: 'APPLY POISON',
  //     description: 'You apply poison with your attacks.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'perceptive',
  //     name: 'PERCEPTIVE',
  //     description: 'Nobody can hide from you.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'dull',
  //     name: 'DULL',
  //     description: 'Your don\'t a good sense of perception.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),

  //   Effect(
  //     icon: 'powerful',
  //     name: 'POWERFUL',
  //     description: 'You more powerful.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'weak',
  //     name: 'WEAK',
  //     description: 'You weaker.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'defensive',
  //     name: 'DEFENSIVE',
  //     description: 'Your defense is stronger.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'vulnerable',
  //     name: 'VULNERABLE',
  //     description: 'Your defense is weaker.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'charismatic',
  //     name: 'CHARISMATIC',
  //     description: 'You are more persuasive.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'inconvenient',
  //     name: 'INCONVENIENT',
  //     description: 'You are more inconvinient.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),

  //   Effect(
  //     icon: 'camouflage',
  //     name: 'CAMOUFLAGE',
  //     description: 'You are hidden as long as you stay still.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),

  //   Effect(
  //     icon: 'dig',
  //     name: 'DIG',
  //     description: 'You can move through the terrain.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'swallow',
  //     name: 'SWALLOW',
  //     description: 'You can swallow things that are smaller than you.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),

  //   Effect(
  //     icon: 'thorn',
  //     name: 'THORN',
  //     description: 'You reflect half of the damage you receive.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'faceshifter',
  //     name: 'FACESHIFTER',
  //     description: 'You change your appearance to look like someone else.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'appearance',
  //     name: 'APPEARANCE',
  //     description: 'You change your appearance to look like someone else.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),
  //   Effect(
  //     icon: 'voice',
  //     name: 'VOICE',
  //     description: 'You change your voice to sound like someone else.',
  //     permanent: false,
  //     origin: 'POSITIVE',
  //   ),

  //   //APPLIED EFFECTS

  //   Effect(
  //     icon: 'poison',
  //     name: 'POISON',
  //     description: 'You were poisoned.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'grab',
  //     name: 'GRAB',
  //     description: 'You are stuck.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'disease',
  //     name: 'DISEASE',
  //     description: 'You are sick.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'bleed',
  //     name: 'BLEED',
  //     description: 'You are bleeding.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'help',
  //     name: 'HELP',
  //     description: 'You received help',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'paralize',
  //     name: 'PARALIZE',
  //     description: 'You are paralized.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'charm',
  //     name: 'CHARM',
  //     description: 'You are charmed.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  //   Effect(
  //     icon: 'fear',
  //     name: 'FEAR',
  //     description: 'You are scared.',
  //     permanent: false,
  //     origin: 'NEGATIVE',
  //   ),
  // ];


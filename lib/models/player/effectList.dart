import 'package:dsixv02app/models/player/effect.dart';

class EffectList {
  Effect newPermanentEffect(String name) {
    Effect newEffect = Effect();
    this.permanent.forEach((effect) {
      if (effect.name == name) {
        newEffect = effect.copyEffect();
      }
    });
    return newEffect;
  }

  List<Effect> permanent = [
    Effect(
      icon: 'fame',
      name: 'FAME',
      description: 'You are famous and get extra gold per quest.',
      permanent: true,
      type: 'POSITIVE',
    ),
  ];

  Effect newTemporaryEffect(String name, int duration) {
    Effect newEffect = Effect();
    this.temporary.forEach((effect) {
      if (effect.name == name) {
        newEffect = effect;

        newEffect.duration = duration;
      }
    });
    return newEffect;
  }

  List<Effect> temporary = [
    //ARMOR
    Effect(
      icon: 'mArmor',
      name: 'MAGIC RESISTANCE',
      description: 'Increase your magic resistance.',
      permanent: false,
      type: 'POSITIVE',
    ),

    //ILLUSION
    Effect(
      icon: 'illusion',
      name: 'LARGE CREATURE',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'GROUP OF PEOPLE',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'STRUCTURE',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'OBJECTS',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'OBSTACLE',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'ANIMALS',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'PERSON',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'LIGHT',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'SOUND',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),
    Effect(
      icon: 'illusion',
      name: 'SMALL CREATURE',
      description: '',
      permanent: false,
      type: 'ILLUSION',
    ),

    //MORPH
    Effect(
      icon: 'morphPuma',
      name: 'PUMA',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphCrocodile',
      name: 'CROCODILE',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphGorilla',
      name: 'GORILLA',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphRhino',
      name: 'RHINO',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphElephant',
      name: 'ELEPHANT',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphBear',
      name: 'BEAR',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphCrab',
      name: 'CRAB',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphSnake',
      name: 'SNAKE',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphBird',
      name: 'BIRD',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphBull',
      name: 'BULL',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphBat',
      name: 'BAT',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphFox',
      name: 'FOX',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphBug',
      name: 'BUG',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphTurtle',
      name: 'TURTLE',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphMonkey',
      name: 'MONKEY',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphFish',
      name: 'FISH',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphChameleon',
      name: 'CHAMELEON',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),
    Effect(
      icon: 'morphFrog',
      name: 'FROG',
      description: '',
      permanent: false,
      type: 'MORPH',
    ),

    //ALTER SENSES ENHANCE

    Effect(
      icon: 'alterSenses',
      name: 'NIGHT VISION',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),

    Effect(
      icon: 'alterSenses',
      name: 'INFRARED VISION',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),

    Effect(
      icon: 'alterSenses',
      name: 'X-RAY VISION',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'ULTRASONIC HEARING',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SPEED',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'POWER',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'CLIMB',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'FLY',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'BREATH UNDERWATER',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'THICK SKIN',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SUPER STRENGTH',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SUPER JUMP',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),

    //ALTER SENSES CURSE

    Effect(
      icon: 'alterSenses',
      name: 'WEAK',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'VULNERABLE',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'BLIND',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'MUTE',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'NUMB',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'DEAF',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'PARALIZED',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'CHARM',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'FORGET',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SCARED',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SLOW',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),
    Effect(
      icon: 'alterSenses',
      name: 'UGLY',
      description: '',
      permanent: false,
      type: 'ALTER SENSES',
    ),

    //ABILITY

    Effect(
      icon: 'swim',
      name: 'SWIM',
      description: 'You can move in water.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'climb',
      name: 'CLIMB',
      description: 'You use the environment to move around.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'jump',
      name: 'JUMP',
      description: 'You can jump long distances',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'fly',
      name: 'FLY',
      description: 'You can fly.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'fast',
      name: 'FAST',
      description: 'You are fast.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'slow',
      name: 'FAST',
      description: 'You are slow.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'applyPoison',
      name: 'APPLY POISON',
      description: 'You apply poison with your attacks.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'perceptive',
      name: 'PERCEPTIVE',
      description: 'Nobody can hide from you.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'dull',
      name: 'DULL',
      description: 'Your don\'t a good sense of perception.',
      permanent: false,
      type: 'NEGATIVE',
    ),

    Effect(
      icon: 'powerful',
      name: 'POWERFUL',
      description: 'You more powerful.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'weak',
      name: 'WEAK',
      description: 'You weaker.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'defensive',
      name: 'DEFENSIVE',
      description: 'Your defense is stronger.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'vulnerable',
      name: 'VULNERABLE',
      description: 'Your defense is weaker.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'charismatic',
      name: 'CHARISMATIC',
      description: 'You are more persuasive.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'inconvenient',
      name: 'INCONVENIENT',
      description: 'You are more inconvinient.',
      permanent: false,
      type: 'NEGATIVE',
    ),

    Effect(
      icon: 'camouflage',
      name: 'CAMOUFLAGE',
      description: 'You are hidden as long as you stay still.',
      permanent: false,
      type: 'POSITIVE',
    ),

    Effect(
      icon: 'dig',
      name: 'DIG',
      description: 'You can move through the terrain.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'swallow',
      name: 'SWALLOW',
      description: 'You can swallow things that are smaller than you.',
      permanent: false,
      type: 'POSITIVE',
    ),

    Effect(
      icon: 'thorn',
      name: 'THORN',
      description: 'You reflect half of the damage you receive.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'faceshifter',
      name: 'FACESHIFTER',
      description: 'You change your appearance to look like someone else.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'appearance',
      name: 'APPEARANCE',
      description: 'You change your appearance to look like someone else.',
      permanent: false,
      type: 'POSITIVE',
    ),
    Effect(
      icon: 'voice',
      name: 'VOICE',
      description: 'You change your voice to sound like someone else.',
      permanent: false,
      type: 'POSITIVE',
    ),

    //APPLIED EFFECTS

    Effect(
      icon: 'poison',
      name: 'POISON',
      description: 'You were poisoned.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'grab',
      name: 'GRAB',
      description: 'You are stuck.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'disease',
      name: 'DISEASE',
      description: 'You are sick.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'bleed',
      name: 'BLEED',
      description: 'You are bleeding.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'help',
      name: 'HELP',
      description: 'You received help',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'paralize',
      name: 'PARALIZE',
      description: 'You are paralized.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'charm',
      name: 'CHARM',
      description: 'You are charmed.',
      permanent: false,
      type: 'NEGATIVE',
    ),
    Effect(
      icon: 'fear',
      name: 'FEAR',
      description: 'You are scared.',
      permanent: false,
      type: 'NEGATIVE',
    ),
  ];
}

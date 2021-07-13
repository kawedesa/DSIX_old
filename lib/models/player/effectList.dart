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
      description: 'You are famous and get an extra \$100 per quest.',
      typeOfEffect: 'PERMANENT',
    ),
  ];

  Effect newTemporaryEffect(String name, int duration) {
    Effect newEffect = Effect(
      icon: '',
      name: '',
      description: '',
      value: 0,
      duration: 0,
    );
    this.temporary.forEach((effect) {
      if (effect.name == name) {
        newEffect = effect;
        print(newEffect);
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
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),

    //ABILITY

    Effect(
      icon: 'swim',
      name: 'SWIM',
      description: 'You can move in water.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'climb',
      name: 'CLIMB',
      description: 'You use the environment to move around.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'jump',
      name: 'JUMP',
      description: 'You can jump long distances',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'fly',
      name: 'FLY',
      description: 'You can fly.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'fast',
      name: 'FAST',
      description: 'You are fast.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'applyPoison',
      name: 'APPLY POISON',
      description: 'You apply poison with your attacks.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'perceptive',
      name: 'PERCEPTIVE',
      description: 'Nobody can hide from you.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),

    Effect(
      icon: 'strong',
      name: 'STRONG',
      description: 'You are strong and can lift heavy things.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),

    Effect(
      icon: 'camouflage',
      name: 'CAMOUFLAGE',
      description: 'You are hidden as long as you stay still.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),

    Effect(
      icon: 'dig',
      name: 'DIG',
      description: 'You can move through the terrain.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'swallow',
      name: 'SWALLOW',
      description: 'You can swallow things that are smaller than you.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),

    Effect(
      icon: 'thorn',
      name: 'THORN',
      description: 'You reflect half of the damage you receive.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'faceshifter',
      name: 'FACESHIFTER',
      description: 'You change your appearance to look like someone else.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'appearance',
      name: 'APPEARANCE',
      description: 'You change your appearance to look like someone else.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'voice',
      name: 'VOICE',
      description: 'You change your voice to sound like someone else.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'alterSenses',
      name: 'ALTER SENSES',
      description: 'Your senses are enhanced.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SIGHT',
      description: 'Your sight is enhanced.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'alterSenses',
      name: 'HEARING',
      description: 'Your hearing is enhanced.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'alterSenses',
      name: 'TOUCH',
      description: 'Your touch is enhanced.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'alterSenses',
      name: 'SMELL',
      description: 'Your smell is enhanced.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'alterSenses',
      name: 'TASTE',
      description: 'Your taste is enhanced.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),

    //APPLIED EFFECTS

    Effect(
      icon: 'poison',
      name: 'POISON',
      description: 'You were poisoned.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'grab',
      name: 'GRAB',
      description: 'You are stuck.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'disease',
      name: 'DISEASE',
      description: 'You are sick.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'bleed',
      name: 'BLEED',
      description: 'You are bleeding.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'help',
      name: 'HELP',
      description: 'You received help',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'paralize',
      name: 'PARALIZE',
      description: 'You are paralized.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'charm',
      name: 'CHARM',
      description: 'You are charmed.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
    Effect(
      icon: 'fear',
      name: 'FEAR',
      description: 'You are scared.',
      typeOfEffect: 'TEMPORARY',
      value: 0,
      duration: 0,
    ),
  ];
}

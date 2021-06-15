import 'package:dsixv02app/models/player/effect.dart';

class EffectList {
  List<Effect> permanent = [
    Effect(
        icon: 'fame',
        name: 'FAME',
        description: 'You are famous and get an extra \$100 per quest.',
        typeOfEffect: 'PERMANENT',
        value: 1,
        duration: 0),
  ];

  List<Effect> temporary = [
    Effect(
        icon: 'mArmor',
        name: 'MAGIC RESISTANCE',
        description: 'Increase your magic resistance.',
        typeOfEffect: 'TEMPORARY',
        value: 3,
        duration: 3),
  ];
}

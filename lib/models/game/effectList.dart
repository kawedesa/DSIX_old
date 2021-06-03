import 'package:dsixv02app/models/game/effect.dart';

class EffectList {
  List<Effect> effectList = [
    Effect('fame', 'FAME', 'You are famous and get an extra \$100 per quest.',
        100, 99),
    Effect(
        'mArmor', 'MAGIC RESISTANCE', 'Increase your magic resistance.', 3, 3),
  ];
}

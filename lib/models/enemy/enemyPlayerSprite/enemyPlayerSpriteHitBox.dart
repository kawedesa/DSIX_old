import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnemyPlayerSpriteHitBox extends StatelessWidget {
  bool? isDead;
  final Function()? onTap;
  EnemyPlayerSpriteHitBox({
    Key? key,
    @required this.isDead,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: (isDead!)
          ? SizedBox()
          : Container(
              width: 5,
              height: 10,
              child: GestureDetector(onTap: () {
                onTap!();
              }),
            ),
    );
  }
}

import 'package:flutter/material.dart';

class CharacterSpriteImage extends StatelessWidget {
  const CharacterSpriteImage({
    @required this.name,
    @required this.size,
    @required this.layers,
  });

  final String name;
  final double size;
  final List<Widget> layers;

  CharacterSpriteImage copy() {
    CharacterSpriteImage newCharacterSprite = CharacterSpriteImage(
        name: this.name, layers: this.layers, size: this.size);
    return newCharacterSprite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      child: Stack(
        alignment: Alignment.topLeft,
        children: this.layers,
      ),
    );
  }
}

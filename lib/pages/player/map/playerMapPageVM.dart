import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/shop.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/loot/gmLootSprite.dart';
import 'package:dsixv02app/models/gm/loot/loot.dart';
import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/enemySprite.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerLootSprite.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';
import 'package:dsixv02app/widgets/dialogs/damageDialog.dart';
import 'package:dsixv02app/widgets/dialogs/openLootDialog.dart';
import 'package:dsixv02app/widgets/dialogs/secondRollDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerMapPageVM {
  double canvasZoom = 1.7;

  int rollGoldLoot() {
    int goldAmount = (Random().nextInt(10) + 1) * 50;
    return goldAmount;
  }

  Shop _shop = Shop();

  void spawnLoot(context, Gm gm, Player player, Function() refresh) {
    player.loot = [];
    gm.loot.forEach((element) {
      if ((element.location - player.location).distance <=
          player.visionRange / 2) {
        switch (element.type) {
          case 'grave':
            PlayerLootSprite newLootSprite = PlayerLootSprite(
              type: 'grave',
              location: element.location,
              opened: element.opened,
              size: 15,
              openAction: () async {
                if ((element.location - player.location).distance <= 20) {
                  player.gold += element.gold;
                  element.gold = 0;

                  if (element.item.isNotEmpty) {
                    print(element.item);
                  }

                  element.opened = true;

                  print('opened');
                  refresh();
                } else {
                  print('too far');
                }
              },
            );
            player.loot.add(newLootSprite);
            break;

          case 'item':
            PlayerLootSprite newLootSprite = PlayerLootSprite(
              type: 'item',
              location: element.location,
              opened: element.opened,
              size: 10,
              openAction: () async {
                if ((element.location - player.location).distance <= 20) {
                  element.item = [];
                  for (int i = 0; i < 3; i++) {
                    int chestRarity = (Random().nextInt(20) + 1) * 100;

                    element.item
                        .add(_shop.randomItemRange(100, chestRarity, 'item'));
                  }

                  element.opened = true;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return OpenLootDialog(
                        player: player,
                        loot: element.item,
                      );
                    },
                  ).then((_) {
                    refresh();
                  });

                  print('opened');
                  refresh();
                } else {
                  print('too far');
                }
              },
            );
            player.loot.add(newLootSprite);
            break;

          case 'gold':
            PlayerLootSprite newLootSprite = PlayerLootSprite(
              type: 'gold',
              location: element.location,
              opened: element.opened,
              size: 10,
              openAction: () async {
                print((element.location - player.location).distance);
                if ((element.location - player.location).distance <= 20) {
                  player.gold += rollGoldLoot();

                  element.opened = true;

                  refresh();
                } else {}
              },
            );
            player.loot.add(newLootSprite);
            break;
        }
      }
    });
  }

  void spawnEnemy(context, Gm gm, Player player, Function() refresh) {
    for (int i = 0; i < gm.players.length; i++) {
      //Reset

      gm.players[i].enemy = [];

      //Add Other Enemy Players

      gm.players.forEach((element) {
        if (element != gm.players[i]) {
          Widget newImage;

          switch (element.race.name) {
            case 'human':
              newImage = SvgPicture.asset(
                AppImages.human,
                color: AppColors.enemy,
                width: double.infinity,
                height: double.infinity,
              );
              break;
            case 'orc':
              newImage = SvgPicture.asset(
                AppImages.orc,
                color: AppColors.enemy,
                width: double.infinity,
                height: double.infinity,
              );
              break;
            case 'goblin':
              newImage = SvgPicture.asset(
                AppImages.goblin,
                color: AppColors.enemy,
                width: double.infinity,
                height: double.infinity,
              );
              break;
            case 'dwarf':
              newImage = SvgPicture.asset(
                AppImages.dwarf,
                color: AppColors.enemy,
                width: double.infinity,
                height: double.infinity,
              );
              break;
            case 'hobbit':
              newImage = SvgPicture.asset(
                AppImages.hobbit,
                color: AppColors.enemy,
                width: double.infinity,
                height: double.infinity,
              );
              break;
            case 'elf':
              newImage = SvgPicture.asset(
                AppImages.elf,
                color: AppColors.enemy,
                width: double.infinity,
                height: double.infinity,
              );
              break;
          }

          EnemySprite newEnemy = EnemySprite(
            size: element.race.size,
            location: element.location,
            image: [newImage],
            attacked: () async {
              if (player.sprite.mode == 'attack' &&
                  (player.location - element.location).distance <=
                      (player.attackRange + player.race.size / 2) / 2) {
                print((player.location - element.location).distance);
                print('hit');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DamageDialog(
                      player: player,
                      enemy: element,
                    );
                  },
                ).then((_) {
                  player.sprite.mode = 'walk';
                  if (element.health < 1) {
                    gm.killPlayer(element);
                  }
                  refresh();
                });
              } else {
                print('too far or not in attackmode');
              }
            },
          );

          gm.players[i].enemy.add(newEnemy);
        }
      });
    }
  }

  void setCanvas(context, Player player, Gm gm, Function refresh) {
    //Spawn Loot
    spawnLoot(context, gm, player, refresh);

    //Spawn Enemy
    spawnEnemy(context, gm, player, refresh);

    //Spawn Self

    PlayerSprite newSprite = new PlayerSprite(
      mode: (gm.turnOrder.first == player.race.icon) ? 'walk' : 'wait',
      image: [player.race.icon],
      color: player.tertiaryColor,
      size: player.race.size,
      visionRange: player.visionRange,
      walkRange: player.walkRange,
      attackRange: player.attackRange,
      location: player.location,
      updateLocation: (details) async {
        double x = player.location.dx + details.dx;
        if (x > 625) {
          x = 625;
        }
        if (x < 5) {
          x = 5;
        }

        double y = player.location.dy + details.dy;
        if (y > 625) {
          y = 625;
        }
        if (y < 5) {
          y = 5;
        }

        player.location = Offset(x, y);
      },
      playerActions: player.actions,
      refresh: () async {
        refresh();
      },
    );
    player.sprite = newSprite;

    //Player Navigation
    double navigationX = -player.location.dx * canvasZoom -
        (player.race.size * canvasZoom) / 2 +
        (MediaQuery.of(context).size.width * 0.5);

    if (navigationX > 0) {
      navigationX = 0;
    }
    if (navigationX < -670) {
      navigationX = -670;
    }

    double navigationY = -player.location.dy * canvasZoom -
        (player.race.size * canvasZoom) / 2 +
        (MediaQuery.of(context).size.height * 0.38);

    if (navigationY > 0) {
      navigationY = 0;
    }

    if (navigationY < -530) {
      navigationY = -530;
    }

    player.navigation = TransformationController(Matrix4(canvasZoom, 0, 0, 0, 0,
        canvasZoom, 0, 0, 0, 0, canvasZoom, 0, navigationX, navigationY, 0, 1));

    player.buildCanvas();
  }
}

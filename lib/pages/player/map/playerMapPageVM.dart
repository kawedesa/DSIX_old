import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/loot/gmLootSprite.dart';
import 'package:dsixv02app/models/gm/loot/loot.dart';
import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/enemySprite.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerLootSprite.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerMapPageVM {
  EffectSystem _effectSystem = EffectSystem();
  void addEnemy(Gm gm) {
//Add Player Enemy

    for (int i = 0; i < gm.players.length; i++) {
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
          );

          gm.players[i].enemy.add(newEnemy);
        }
      });
    }
  }

  // void search(Gm gm, Player player, Function() refresh) {
  //   gm.loot.forEach((element) {
  //     if ((element.location - player.location).distance <=
  //         player.visionRange / 2) {
  //       player.visibleLoot.add(element);
  //     }
  //   });

  //   spawnLoot(
  //     gm,
  //     player,
  //     refresh,
  //   );

  //   gm.takeTurn(player);
  //   player.buildCanvas();
  // }

  void spawnLoot(Gm gm, Player player, Function() refresh) {
    gm.loot.forEach((element) {
      if ((element.location - player.location).distance <=
          player.visionRange / 2) {
        switch (element.name) {
          case 'corpse':
            PlayerLootSprite newLootSprite = PlayerLootSprite(
              type: 'corpse',
              gold: element.gold,
              size: element.size,
              location: element.location,
              opened: element.opened,
              open: () async {
                if ((element.location - player.location).distance <= 30) {
                  player.gold += element.gold;
                  element.gold = 0;
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
          case 'chest':
            PlayerLootSprite newLootSprite = PlayerLootSprite(
              type: 'chest',
              gold: element.gold,
              size: element.size,
              location: element.location,
              opened: element.opened,
              open: () async {
                if ((element.location - player.location).distance <= 30) {
                  player.gold += element.gold;
                  element.gold = 0;
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

  void spawnEnemy(Gm gm) {
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
          );

          gm.players[i].enemy.add(newEnemy);
        }
      });
    }
  }

  void setCanvas(context, Player player, Gm gm, Function refresh) {
    //Spawn Self
    PlayerSprite newSprite = new PlayerSprite(
      image: [player.race.icon],
      size: player.race.size,
      visionRange: player.visionRange,
      location: player.location,
      color: player.tertiaryColor,
      walkRange: player.walkRange,
      playerActions: player.actions,
      drag: (gm.turnOrder.first == player.race.icon) ? true : false,
      search: () async {
        // search(gm, player, refresh);
      },
      refresh: () async {
        refresh();
      },
      playerTurn: () async {
        // gm.takeTurn(player);
        // _effectSystem.runEffects(player);
      },
      updateLocation: (details) async {
        player.location = Offset(
            player.location.dx + details.dx, player.location.dy + details.dy);
        //Snap to player token
        // player.navigation = TransformationController(Matrix4(
        //     2,
        //     0,
        //     0,
        //     0,
        //     0,
        //     2,
        //     0,
        //     0,
        //     0,
        //     0,
        //     2,
        //     0,
        //     -player.location.dx * 2 -
        //         (player.race.size * 2) / 2 +
        //         (MediaQuery.of(context).size.width * 0.5),
        //     -player.location.dy * 2 -
        //         (player.race.size * 2) / 2 +
        //         (MediaQuery.of(context).size.height * 0.38),
        //     0,
        //     1));
      },
    );
    player.sprite = newSprite;

    //Spawn Enemy
    spawnEnemy(gm);

    //Spawn Loot
    spawnLoot(gm, player, refresh);

    //Player Navigation
    player.navigation = TransformationController(Matrix4(
        1.5,
        0,
        0,
        0,
        0,
        1.5,
        0,
        0,
        0,
        0,
        1.5,
        0,
        -player.location.dx * 1.5 -
            (player.race.size * 1.5) / 2 +
            (MediaQuery.of(context).size.width * 0.5),
        -player.location.dy * 1.5 -
            (player.race.size * 1.5) / 2 +
            (MediaQuery.of(context).size.height * 0.38),
        0,
        1));

    player.buildCanvas();
  }
}

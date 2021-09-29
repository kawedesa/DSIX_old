import 'dart:math';

import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:dsixv02app/models/gm/draw/drawing_page.dart';
import 'package:flutter/material.dart';
import 'loot.dart';
import 'story.dart';
import 'package:dsixv02app/models/player/player.dart';

import 'package:dsixv02app/models/shared/shop.dart';
import 'character.dart';
import '../shared/exceptions.dart';
import 'locationList.dart';
import 'package:dsixv02app/models/shared/item.dart';

class Gm {
  // Available Players

  List<PlayerColor> playerColors = [
    PlayerColor(
        name: 'PINK',
        primaryColor: Colors.pinkAccent,
        secondaryColor: Colors.pink[100],
        tertiaryColor: Colors.pink[800]),
    PlayerColor(
        name: 'BLUE',
        primaryColor: Colors.indigoAccent,
        secondaryColor: Colors.indigo[100],
        tertiaryColor: Colors.indigo[800]),
    PlayerColor(
        name: 'GREEN',
        primaryColor: Colors.teal,
        secondaryColor: Colors.teal[100],
        tertiaryColor: Colors.teal[800]),
    PlayerColor(
        name: 'YELLOW',
        primaryColor: Colors.orange,
        secondaryColor: Colors.orange[100],
        tertiaryColor: Colors.orange[800]),
    PlayerColor(
        name: 'PURPLE',
        primaryColor: Colors.purple,
        secondaryColor: Colors.purple[100],
        tertiaryColor: Colors.purple[800]),
  ];

  void createPlayers() {
    if (this.players.isEmpty == true) {
      for (PlayerColor playerColor in this.playerColors) {
        this.players.add(new Player(playerColor));
      }
    }
  }

  // SET PLAYERS

  int currentPlayerIndex;

  List<Player> players = [];

  void setCurrentPlayer(int playerIndex) {
    this.currentPlayerIndex = playerIndex;
  }

  Player getCurrentPlayer() {
    return this.players[this.currentPlayerIndex];
  }

  void deleteCurrentPlayer(int playerIndex) {
    switch (playerIndex) {
      case 0:
        this.players.replaceRange(playerIndex, playerIndex + 1, [
          new Player(PlayerColor(
              name: 'PINK',
              primaryColor: Colors.pinkAccent,
              secondaryColor: Colors.pink[100],
              tertiaryColor: Colors.pink[800]))
        ]);

        break;

      case 1:
        this.players.replaceRange(playerIndex, playerIndex + 1, [
          new Player(PlayerColor(
              name: 'BLUE',
              primaryColor: Colors.indigoAccent,
              secondaryColor: Colors.indigo[100],
              tertiaryColor: Colors.indigo[800]))
        ]);
        break;

      case 2:
        this.players.replaceRange(playerIndex, playerIndex + 1, [
          new Player(PlayerColor(
              name: 'GREEN',
              primaryColor: Colors.teal,
              secondaryColor: Colors.teal[100],
              tertiaryColor: Colors.teal[800]))
        ]);
        break;

      case 3:
        this.players.replaceRange(playerIndex, playerIndex + 1, [
          new Player(PlayerColor(
              name: 'YELLOW',
              primaryColor: Colors.orange,
              secondaryColor: Colors.orange[100],
              tertiaryColor: Colors.orange[800]))
        ]);
        break;

      case 4:
        this.players.replaceRange(playerIndex, playerIndex + 1, [
          new Player(PlayerColor(
              name: 'PURPLE',
              primaryColor: Colors.purple,
              secondaryColor: Colors.purple[100],
              tertiaryColor: Colors.purple[800]))
        ]);
        break;
    }
    checkPlayers();
  }

  void newRandomPlayer(int index) {
    this.players[index].createRandomPlayer();
    checkPlayers();
  }

// check Players

  int numberPlayers = 0;

  void checkPlayers() {
    this.numberPlayers = 0;
    this.players.forEach((element) {
      if (element.characterFinished) {
        this.numberPlayers++;
      }
    });
  }

  // TURN

  List<PlayerColor> turnOrder = [];
  void newTurn() {
    turnOrder = [];
    this.players.forEach((element) {
      if (element.characterFinished) {
        this.turnOrder.add(element.playerColor);
      }
    });

    this.turnOrder.shuffle();

    int gmTurn = 0;
    gmTurn = turnOrder.length ~/ 2;
    for (int i = 0; i < gmTurn; i++) {
      this.turnOrder.add(
            PlayerColor(
                name: 'GM',
                icon: 'gm',
                primaryColor: Colors.grey[600],
                secondaryColor: Colors.grey[100],
                tertiaryColor: Colors.grey[800]),
          );
    }
  }

  void nextTurn() {
    this.turnOrder.removeAt(0);
    if (this.turnOrder.isEmpty) newTurn();
  }

  void skipTurn() {
    if (turnOrder.length < 2) {
      return;
    }

    this.turnOrder.add(this.turnOrder.first);
    this.turnOrder.removeAt(0);
  }

  void chooseTurn(int index) {
    if (index < 1) {
      nextTurn();
    }
    List<PlayerColor> temporaryPlayers = [];

    temporaryPlayers.add(this.turnOrder[index].copyPlayerColor());

    this.turnOrder.removeAt(index);
    this.turnOrder.forEach((element) {
      temporaryPlayers.add(element.copyPlayerColor());
    });
    this.turnOrder = [];
    this.turnOrder = temporaryPlayers;
  }

  void removeTurn(int index) {
    chooseTurn(index);
    nextTurn();
  }

  void shuffleTurn() {
    this.turnOrder.shuffle();
  }

  void addGmTurn() {
    List<PlayerColor> temporaryPlayers = [];
    temporaryPlayers.add(
      PlayerColor(
          name: 'GM',
          icon: 'gm',
          primaryColor: Colors.grey[600],
          secondaryColor: Colors.grey[100],
          tertiaryColor: Colors.grey[800]),
    );
    shuffleTurn();
    this.turnOrder.forEach((element) {
      temporaryPlayers.add(element.copyPlayerColor());
    });
    this.turnOrder = [];
    this.turnOrder = temporaryPlayers;
  }

  // SET DIFFICULTY AND STORY

  Story story = Story();

  void deleteStory() {
    this.story.deleteStory();
    this.loot.itemList = [];
    // this.totalXp = 0;
  }

  void newStory() {
    checkPlayers();
    if (numberPlayers < 1) {
      throw new NoPlayersException();
    }
    this.story.newStory(numberPlayers);
  }

  int returnNumberPlayers() {
    checkPlayers();

    return numberPlayers;
  }

//   void newQuest() {
//     checkPlayers();
//     if (numberPlayers < 1) {
//       throw new NoPlayersException();
//     }
//     this.story.newQuest(numberPlayers);
//   }

  void chooseQuest(int index) {
    this.story.chooseQuest(index);

    //New Turn
    this.newTurn();

    //Clear board
    this.clearMap();

    //Spawn Players

    this.spawnPlayers();

    //Spawn Enemy

    this.spawnCharacters();
  }

// //QUESTS

  void startQuest() {
    this.story.startQuest();
    this.selectedCharacter = this.story.quest.threatList.first;
  }

  void finishQuest() {
    checkPlayers();
    this.players.forEach((element) {
      if (element.characterFinished) {
        element.gold += this.story.settings.questGold;
        if (element.fame > 0) {
          element.gold += element.fame * 100;
        }
      }
    });

    this.story.finishQuest();
  }

  List<String> randomReward() {
    List<String> possibleRewards = [
      'gold',
      'item',
      'weapon',
      'armor',
      'rune',
      'fame',
    ];

    List<String> randomRewards = [];

    for (int i = 0; i < 3; i++) {
      int randomNumber = Random().nextInt(possibleRewards.length);
      randomRewards.add(possibleRewards[randomNumber]);
    }

    return randomRewards;
  }

  void chooseReward(String reward) {
    switch (reward) {
      case 'gold':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              element.gold += (this.story.settings.questGold * 1.5).toInt();
              if (element.fame > 0) {
                element.gold += element.fame * 100;
              }
            }
          });
        }
        break;
      case 'item':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              rewardItem('item');
            }
          });
        }
        break;
      case 'weapon':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              rewardItem('weapon');
            }
          });
        }
        break;

      case 'armor':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              rewardItem('armor');
            }
          });
        }

        break;

      case 'rune':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              for (int i = 0; i < this.story.round; i++) {
                element.inventory.add(this.shop.resources[11]);
              }
            }
          });
        }
        break;
      case 'fame':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              for (int i = 0; i < this.story.round; i++) {
                element.newPermanentEffect('FAME');
              }
            }
          });
        }
        break;
      // case 'Favor':
      //   {}
      //   break;
    }
  }

  void newRound() {
    checkPlayers();
    this.story.newRound(numberPlayers);
  }

//NPCS AND MONSTERS
  LocationList locationList = LocationList();
  Character selectedCharacter = Character(
    icon: 'undead',
    image: 'undead',
    name: 'CHARACTER',
    description: 'A character.',
    baseHealth: 1,
    dice: 1,
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    // pSkill: 0,
    // mSkill: 0,
    possibleSkills: [],
    selectedSkills: [],
    baseLoot: 0.25,
    baseXp: 25,
  );

  List<Character> availableCharacters = [];

  List<Sprite> displayCharacters = [];

  void clearMap() {
    this.displayCharacters.clear();
  }

  double canvasSize = 640.0;
  DrawingPage drawingCanvas = DrawingPage(
    canvasSize: 640,
    selectedColor: Colors.black,
    selectedWidth: 10.0,
    lines: [],
    line: null,
  );

  void spawnPlayers() {
    Offset firstSpawn = Offset(
        Random().nextDouble() * this.canvasSize * 0.4 + this.canvasSize * 0.3,
        Random().nextDouble() * this.canvasSize * 0.4 + this.canvasSize * 0.3);

    List<Sprite> spawnPlayers = [];

    this.players.forEach((element) {
      if (element.characterFinished) {
        double randomX = Random().nextDouble() * this.canvasSize * 0.2;
        double randomY = Random().nextDouble() * this.canvasSize * 0.2;

        Offset playerOffset =
            Offset(firstSpawn.dx + randomX, firstSpawn.dy + randomY);

        element.location = playerOffset;

        spawnPlayers.add(Sprite(
            icon: element.race.icon,
            color: element.playerColor.primaryColor,
            size: 25,
            canvasSize: this.canvasSize,
            location: element.location));
      }
    });

    spawnPlayers.forEach((element) {
      this.displayCharacters.add(element);
    });
  }

  void spawnSingleCharacter(Character character) {
    Offset firstSpawn = Offset(
        Random().nextDouble() * this.canvasSize * 0.4 + this.canvasSize * 0.3,
        Random().nextDouble() * this.canvasSize * 0.4 + this.canvasSize * 0.3);

    List<Sprite> spawnCharacters = [];

    for (int i = 0; i < character.amount; i++) {
      double randomX = Random().nextDouble() * this.canvasSize * 0.1;
      double randomY = Random().nextDouble() * this.canvasSize * 0.1;

      Offset characterOffset =
          Offset(firstSpawn.dx + randomX, firstSpawn.dy + randomY);

      spawnCharacters.add(Sprite(
        icon: '${character.icon}',
        location: characterOffset,
        size: character.size,
        canvasSize: this.canvasSize,
        color: Colors.black,
      ));
    }
    spawnCharacters.forEach((element) {
      this.displayCharacters.add(element);
    });
  }

  void spawnCharacters() {
    Offset firstSpawn = Offset(
        Random().nextDouble() * this.canvasSize * 0.4 + this.canvasSize * 0.3,
        Random().nextDouble() * this.canvasSize * 0.4 + this.canvasSize * 0.3);

    List<Sprite> spawnCharacters = [];

    this.story.quest.threatList.forEach((element) {
      for (int i = 0; i < element.amount; i++) {
        double randomX = Random().nextDouble() * this.canvasSize * 0.1;
        double randomY = Random().nextDouble() * this.canvasSize * 0.1;

        Offset characterOffset =
            Offset(firstSpawn.dx + randomX, firstSpawn.dy + randomY);

        element.location = characterOffset;

        spawnCharacters.add(Sprite(
          icon: '${element.icon}',
          location: element.location,
          size: element.size,
          canvasSize: this.canvasSize,
          color: Colors.black,
        ));
      }
    });

    spawnCharacters.forEach((element) {
      this.displayCharacters.add(element);
    });
  }

  void availableCharacter() {
    this.availableCharacters.clear();
    this.story.quest.location.possibleCharacters.forEach((element) {
      this.availableCharacters.add(element);
    });
  }

  void newCharacter(Character character) {
    this.selectedCharacter = character.newCharacter();
    this.selectedCharacter.setHpAndXp();
  }

  void chooseCharacterAmount(int value) {
    if ((this.selectedCharacter.amount + value) *
            this.selectedCharacter.baseXp >
        100) {
      return;
    }
    if ((this.selectedCharacter.amount + value) *
            this.selectedCharacter.baseXp <
        1) {
      return;
    }

    this.selectedCharacter.changeAmount(value);
  }

  void confirmCharacter() {
    this.selectedCharacter.setHpAndXp();
    this.story.quest.threatList.add(this.selectedCharacter);
    this.selectedCharacter = this.story.quest.threatList.last;
    spawnSingleCharacter(this.selectedCharacter);
  }

  void selectCharacter(int index) {
    this.selectedCharacter = this.story.quest.threatList[index];
  }

  void deleteCharacter() {
    this.story.quest.threatList.remove(this.selectedCharacter);
    if (this.story.quest.threatList.isNotEmpty) {
      this.selectedCharacter = this.story.quest.threatList.last;
    } else {
      this.selectedCharacter = this.selectedCharacter.newCharacter();
    }
  }

  void characterLoot() {
    createRandomCharacterLoot(this.selectedCharacter.totalLoot);
    deleteCharacter();
    throw new NewLootException();
  }

  void giveLoot(Item item, Color primaryColor) {
    this.players.forEach((player) {
      if (player.playerColor.primaryColor == primaryColor) {
        player.receiveItem(item.copyItem());
      }
    });
    this.loot.itemList.remove(item);

    if (this.loot.itemList.isEmpty) {
      this.deleteLoot();
    }
  }

//LOOT

  Shop shop = Shop();

  Loot loot = Loot(
    icon: 'loot',
    name: 'NEW LOOT',
    lootDescription:
        'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
    itemList: [],
  );

  List<Loot> lootList = [];

  void rewardItem(String itemType) {
    this.loot = this.loot.rewardItemLoot(this.story.round, itemType);
    this.lootList.add(this.loot);
  }

  void selectLoot(int index) {
    this.loot = this.lootList[index];
  }

  void deleteLoot() {
    this.lootList.remove(this.loot);
    if (lootList.isEmpty) {
      this.loot.newLoot();
    } else {
      this.loot = this.lootList.first;
    }
  }

  void createRandomCharacterLoot(int value) {
    createRandomLoot(value);
    this.loot.lootDescription = 'Droped by ${this.selectedCharacter.name}.';
  }

  void createRandomLoot(int value) {
    Loot newLoot = Loot();
    newLoot.randomLoot(value);
    newLoot.icon = newLoot.itemList.first.icon;
    newLoot.name = newLoot.itemList.first.name;
    newLoot.lootDescription = 'Random Loot';
    this.lootList.add(newLoot.copyLoot());
    this.loot = this.lootList.last;
  }

//TURNS

  Gm();
}

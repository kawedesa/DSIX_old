import 'dart:math';

import 'loot.dart';
import 'story.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';
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

  // void createPlayer(PlayerColor playerColor) {
  //   Player newPlayer = Player(playerColor);

  //   this.players.add(newPlayer);
  // }

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
    if (this.numberPlayers < 1) {
      throw new NoPlayersException();
    }
  }

  // TURN

  void newTurn() {
    this.players.forEach((element) {
      element.newTurn();
    });
    throw new NewTurnException();
  }

  void checkTurn() {
    checkPlayers();

    int check = 0;
    this.players.forEach((player) {
      if (player.characterFinished) {
        if (player.turn.contains(false)) {
          return;
        } else {
          check++;
        }
      }
    });

    if (check == this.numberPlayers) {
      newTurn();
    }
  }

  // SET DIFFICULTY AND STORY

  Story story = Story();

  void deleteStory() {
    this.story.deleteStory();
    this.loot.itemList = [];
    this.totalXp = 0;
  }

  void newStory() {
    checkPlayers();
    if (numberPlayers < 1) {
      throw new NoPlayersException();
    }
    this.story.newStory(numberPlayers);
  }

  void newQuest() {
    checkPlayers();
    if (numberPlayers < 1) {
      throw new NoPlayersException();
    }
    this.story.newQuest(numberPlayers);
  }

  void chooseQuest(int index) {
    this.story.chooseQuest(index);

    this.totalXp = 0;
    this.story.quest.threatList.forEach((element) {});

    throw new NewStoryException();
  }

//QUESTS

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
      'GOLD',
      'ITEM',
      'RESOURCES',
      'FAME',
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
      case 'GOLD':
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
      case 'ITEM':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              rewardItem();
            }
          });
        }
        break;
      // case 'INFORMATION':
      //   {}
      //   break;
      case 'RESOURCES':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              element.inventory.add(this.shop.randomResourceRange(100, 600));
            }
          });
        }
        break;
      case 'FAME':
        {
          this.players.forEach((element) {
            element.newPermanentEffect('FAME');
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

//MANAGING XP
  int totalXp = 0;
  void changeXp(int value) {
    if (this.totalXp + value < 1) {
      this.totalXp = 0;
      return;
    }

    this.totalXp += value;
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

  void availableCharacter(String environment) {
    this.availableCharacters = [];

    switch (environment) {
      case 'Mountain':
        {
          this.locationList.locations[0].characters.forEach((element) {
            if (element.baseXp <= this.totalXp) {
              this.availableCharacters.add(element);
            }
          });
        }
        break;
      case 'Swamp':
        {
          this.locationList.locations[1].characters.forEach((element) {
            if (element.baseXp <= this.totalXp) {
              this.availableCharacters.add(element);
            }
          });
        }
        break;
    }

    if (this.availableCharacters.isEmpty) {
      throw new NoXpException();
    }
  }

  void newCharacter(Character character) {
    this.selectedCharacter = character.newCharacter();
    this.selectedCharacter.setHpAndXp();
  }

  void chooseCharacterAmount(int value) {
    if ((this.selectedCharacter.amount + value) *
            this.selectedCharacter.baseXp >
        this.totalXp) {
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
    this.totalXp -= this.selectedCharacter.totalXp;
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

  void refundCharacter() {
    this.totalXp += this.selectedCharacter.totalXp;
    this.deleteCharacter();
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

  void rewardItem() {
    this.loot = this.loot.rewardItemLoot(this.story.round);
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

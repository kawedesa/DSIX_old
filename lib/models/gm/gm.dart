import 'loot.dart';
import 'story.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/shop.dart';
import 'character.dart';
import 'characterList.dart';

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

  void newTurn() {
    this.players.forEach((element) {
      element.newTurn();
    });
  }

  void checkTurn() {
    int check = 0;
    this.players.forEach((element) {
      if (element.endTurn) {
        check++;
      }
      if (element.characterFinished == false) {
        check++;
      }
    });

    if (check == this.players.length) {
      newTurn();
    }
  }

  // SET DIFFICULTY AND STORY

  Story story = Story();

  int totalXp = 0;
  int totalGold = 0;
  void startQuest() {
    checkPlayers();
    this.totalXp = 0;
    this.totalGold = 0;
    this.story.acceptQuest();
    this.totalXp = this.story.newQuest.questXp * this.numberPlayers;
    this.totalGold = this.story.newQuest.questGold;
  }

  void finishQuest() {
    this.players.forEach((element) {
      if (element.characterFinished) {
        element.gold += this.totalGold;
        if (element.fame > 0) {
          element.gold += element.fame * 100;
        }
      }
    });
    switch (this.story.newQuest.reward) {
      case 'Gold':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              element.gold += this.totalGold;
              if (element.fame > 0) {
                element.gold += element.fame * 100;
              }
            }
          });
        }
        break;
      case 'Item':
        {
          rewardItem();
        }
        break;
      case 'Information':
        {}
        break;
      case 'Resources':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              int availableWeight =
                  element.race.maxWeight - element.currentWeight;
              if (availableWeight > 0) {
                element.inventory.add(this.shop.randomResource());
              }
            }
          });
        }
        break;
      case 'Fame':
        {
          this.players.forEach((element) {
            element.fame++;
          });
        }
        break;
      case 'Favor':
        {}
        break;
    }

    this.story.finishQuest();
    this.totalGold = 0;
    this.totalXp = 0;
  }

//NPCS AND MONSTERS
  CharacterList characterList = CharacterList();
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
    pSkill: 0,
    mSkill: 0,
    possibleSkills: [],
    selectedSkills: [],
    baseLoot: 0.25,
    baseXp: 25,
  );
  List<Character> characters = [];
  List<Character> availableCharacters = [];

  void availableCharacter(String environment) {
    availableCharacters = [];

    switch (environment) {
      case 'MOUNTAINS':
        {
          this.characterList.mountain.forEach((element) {
            this.availableCharacters.add(element);
          });
        }
        break;
    }
  }

  void newCharacter(Character character) {
    this.selectedCharacter = character;
    this.selectedCharacter.prepareCharacterNpc();
  }

  void selectCharacter(int index) {
    this.selectedCharacter = this.characters[index];
  }

  void deleteCharacter() {
    this.characters.remove(this.selectedCharacter);
    this.selectedCharacter.newCharacter();
  }

  void confirmCharacter() {
    this.characters.add(this.selectedCharacter);
  }

  void characterLoot() {
    createRandomLoot(this.selectedCharacter.totalLoot);
    deleteCharacter();
  }
  // List<Npc> npcList = [];

  // int npcLayout = 0;

  // Npc selectedNpc = Npc(
  //   icon: 'null',
  //   image: 'goblin',
  //   name: 'NPC',
  //   description:
  //       'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.',
  // );

  // List<Npc> npcTypeList = new NpcTypeList().npcType;

  // void createNpc(Npc npc) {
  //   Npc newNpc = npc.newNpc();

  //   newNpc.prepareNpc();

  //   this.npcList.add(newNpc);
  // }

//LOOT

  Shop shop = Shop();

  Loot loot = Loot(
    icon: 'loot',
    name: 'NEW LOOT',
    lootDescription:
        'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
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

  void createRandomLoot(int value) {
    this.loot.newLoot();
    this.loot.randomLoot(value);
    this.loot.icon = this.loot.itemList.first.icon;
    this.lootList.add(this.loot);
  }

//TURNS

  Gm();
}

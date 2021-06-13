import 'loot.dart';
import 'story.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/shop.dart';
import 'character.dart';
import '../shared/exceptions.dart';
import 'characterList.dart';
import 'package:dsixv02app/models/game/item.dart';

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
  }

  int totalXp = 0;
  void newStory() {
    this.story.newStory();
  }

  void startQuest() {
    checkPlayers();
    if (numberPlayers < 1) {
      throw new NoPlayersException();
    }
    this.totalXp = this.story.settings.totalXp * numberPlayers;
    this.story.acceptQuest();
    throw new AcceptQuestException();
  }

  void finishQuest() {
    checkPlayers();
    this.players.forEach((element) {
      if (element.characterFinished) {
        element.gold += this.story.settings.totalGold;
        if (element.fame > 0) {
          element.gold += element.fame * 100;
        }
      }
    });
    switch (this.story.quest.reward) {
      case 'Gold':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              element.gold += (this.story.settings.totalGold * 1.5).toInt();
              if (element.fame > 0) {
                element.gold += element.fame * 100;
              }
            }
          });
        }
        break;
      case 'Item':
        {
          this.players.forEach((element) {
            if (element.characterFinished) {
              rewardItem();
            }
          });
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
      // case 'Fame':
      //   {
      //     this.players.forEach((element) {
      //       element.fame++;
      //     });
      //   }
      //   break;
      // case 'Favor':
      //   {}
      //   break;
    }

    this.story.finishQuest();
    this.totalXp = 0;
    throw new FinishQuestException();
  }

  void newRound() {
    this.story.newRound();
    this.lootList.clear();
    this.characters.clear();
    throw new NewRoundException();
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
    // pSkill: 0,
    // mSkill: 0,
    possibleSkills: [],
    selectedSkills: [],
    baseLoot: 0.25,
    baseXp: 25,
  );
  List<Character> characters = [];
  List<Character> availableCharacters = [];

  void availableCharacter(String environment) {
    this.availableCharacters = [];

    switch (environment) {
      case 'MOUNTAINS':
        {
          this.availableCharacters = this.characterList.mountain;
        }
        break;
    }
  }

  void newCharacter(Character character) {
    this.selectedCharacter = character.newCharacter();
    this.selectedCharacter.setHpAndXp();
  }

  void confirmCharacter() {
    this.selectedCharacter.setHpAndXp();
    this.characters.add(this.selectedCharacter);
    this.selectedCharacter = this.characters.last;
  }

  void selectCharacter(int index) {
    this.selectedCharacter = this.characters[index];
  }

  void deleteCharacter() {
    this.characters.remove(this.selectedCharacter);
  }

  void characterLoot() {
    createRandomLoot(this.selectedCharacter.totalLoot);
    deleteCharacter();
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

  void createRandomLoot(int value) {
    Loot newLoot = Loot();
    newLoot.randomLoot(value);
    newLoot.icon = newLoot.itemList.first.icon;
    newLoot.name = newLoot.itemList.first.name;
    newLoot.lootDescription = 'Droped by ${this.selectedCharacter.name}.';
    this.lootList.add(newLoot.copyLoot());
    this.loot = this.lootList.last;
  }

//TURNS

  Gm();
}

import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/player/player.dart';

class InventoryPageVM {
  useOrEquip(Player player, Item item) {
    if (item.inventorySpace == 'consumable') {
      useItem(player, item);
    } else {
      player.equipItem(item);
    }
  }

  void useItem(Player player, Item item) {
    switch (item.name) {
      case 'BANDAGES':
        player.useItem(item);

        // playerTurn();
        // throw new UseItemException(message: '${item.name}');
        break;

      case 'FOOD':
        player.useItem(item);
        // if (this.currentHealth == this.race.maxHealth) {
        //   throw new MaxHpException();
        // }

        // playerTurn();

        player.heal(1, 3);

        break;

      case 'HEALING POTION':
        player.useItem(item);
        player.heal(3, 6);
        // if (this.currentHealth == this.race.maxHealth) {
        //   throw new MaxHpException();
        // }

        // playerTurn();

        break;

      case 'RESISTANCE POTION':
        player.useItem(item);
        // playerTurn();
        // newTemporaryEffect('MAGIC RESISTANCE', 3);

        // throw new UseItemException(message: '${item.name}');
        break;
      case 'KEY':
        player.useItem(item);

        // playerTurn();
        // throw new UseItemException(message: '${item.name}');
        break;
      case 'BOOK':
        player.useItem(item);
        // playerTurn();
        // throw new UseItemException(message: '${item.name}');
        break;
      case 'HERBS':
        player.useItem(item);

        // playerTurn();
        // throw new UseItemException(message: '${item.name}');
        break;
      case 'TOOL':
        player.useItem(item);

        // playerTurn();
        // throw new UseItemException(message: '${item.name}');
        break;
      case 'WARD':
        player.useItem(item);

        // playerTurn();
        // throw new UseItemException(message: '${item.name}');
        break;
      case 'ANTIDOTE':
        player.useItem(item);
        // playerTurn();

        // this.effects.forEach((element) {
        //   if (element.permanent == false) {
        //     element.duration = 0;
        //   }
        // });
        // checkEffects();

        // throw new UseItemException(message: '${item.name}');
        break;
      case 'MAGIC RUNE':
        player.useItem(item);

        break;
    }
  }

  unequip(Player player, Item item, String itemSlot) {
    player.unequipItem(item, itemSlot);
  }
}

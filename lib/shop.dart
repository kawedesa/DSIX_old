import 'item.dart';
import 'package:flutter/material.dart';

class Shop {

  //Item(this.icon, this.name, this.itemClass, this.inventorySpace,  this.description, this.pDamage, this.pArmor, this.mDamage, this.mArmor,this.weight,this.uses,this.value,);
  List<Item> lightWeapons = [

    Item('baton','BATON','lightWeapon', '1HAND','It is a club with a handle on the side.',0,1,0,0,1,0,100,),
    Item('dagger','DAGGER','lightWeapon', '1HAND','It is a knife with a very sharp edge.',1,0,0,0,1,0,100,),
    Item('mace','MACE','lightWeapon', '1HAND','It is a club with a reinforced metal head.',2,0,0,0,3,0,100,),
    Item('claw','CLAW','lightWeapon', '1HAND','A couple of blades that fit over the knuckles.',1,0,0,0,0,0,200,),
    Item('axe','AXE','lightWeapon', '1HAND','It is a club with a metal blade at the end.',2,0,0,0,2,0,200,),
    Item('shortSword','SHORT SWORD','lightWeapon', '1HAND','It is a weapon with a small blade and a handle.',1,1,0,0,1,0,300,),
    Item('shortSpear','SHORT SPEAR','lightWeapon', '1HAND','It is a small pole with a a pointy edge.',2,0,0,0,1,0,300,),
    Item('rapier','RAPIER','lightWeapon', '1HAND','It is a very light sword used for pocking.',2,0,0,0,1,0,300,),
    Item('sword','SWORD','lightWeapon', '1HAND','It is similar to a short sword, but with a longer blade and better reach.',2,2,0,0,4,0,400,),
    Item('saber','SABER','lightWeapon', '1HAND','It is a sword with a curved blade and a very sharp edge.',3,0,0,0,3,0,400,),
    Item('morningStar','MORNING STAR','lightWeapon', '1HAND','It is a club with a heavy steal ball full of spikes at the end.',5,0,0,0,6,0,400,),
    Item('longSword','LONG SWORD','lightWeapon', '1HAND','It is a sword with a very long blade. It is better used outdoors.',3,2,0,0,5,0,500,),
  ];

  List<Item> heavyWeapons = [
    Item('longSpear','LONG SPEAR','heavyWeapon', '2HAND','Its is a great weapon to keep your enemies away from you.',3,0,0,0,2,0,300,),
    Item('quarterstaff','QUARTERSTAFF','heavyWeapon', '2HAND','Its a wooden or metal pole that can be used as a defensive weapon.',1,3,0,0,4,0,300,),
    Item('doubleSword','DOUBLE SWORD','heavyWeapon', '2HAND','Its a wooden or metal pole with a blade on each end.',5,0,0,0,5,0,400,),
    Item('trident','TRIDENT','heavyWeapon', '2HAND','It is a heavier and more powerful spear with three points at the end.',4,0,0,0,3,0,400,),
    Item('battleAxe','BATTLE AXE','heavyWeapon', '2HAND','It is a heavier axe with a a longer pole and a blade on both sides.',7,0,0,0,8,0,500,),
    Item('halberd','HALBERD','heavyWeapon', '2HAND','It is a long spear with an axe at the end. Great for poking and slashing.',6,0,0,0,6,0,500,),
    Item('warHammer','WAR HAMMER','heavyWeapon', '2HAND','It is a long pole with a heavy metal head at the end. Great for crushing bones.',8,0,0,0,9,0,600,),
    Item('greatSword','GREAT SWORD','heavyWeapon', '2HAND','It is a very long and heavy sword. Very powerful, but hard to wield.',5,2,0,0,7,0,600,),
  ];

  List<Item> rangedWeapons = [
    Item('blowgun','BLOWGUN','rangedWeapon', '1HAND','It is a long tube that can shoot light projectiles.',1,0,0,0,1,0,100,),
    Item('boomerang','BOOMERANG','thrownWeapon', '1HAND','It is a thrown weapon that sometimes return to the thrower.',1,0,0,0,0,3,200,),
    Item('javelins','JAVELINS','thrownWeapon', '1HAND','It is a very small and light spear that can be thrown.',2,0,0,0,2,3,200,),
    Item('shortBow','SHORT BOW','rangedWeapon', '1HAND','It is a ranged weapon that can shoot arrows with precision.',2,0,0,0,1,0,300,),
    Item('kunai','KUNAI','thrownWeapon', '1HAND','It is a very light and sharp blade that can be thrown.',2,0,0,0,1,3,300,),
    Item('handCrossbow','HAND CROSSBOW','rangedWeapon', '1HAND','It is a very light and compact weapon that shoots bolts.',3,0,0,0,2,0,400,),
    Item('longBow','LONG BOW','rangedWeapon', '1HAND','It is a heavier bow with a longer arc that can shoot arrows really far.',4,0,0,0,4,0,400,),
    Item('greatBow','GREAT BOW','rangedWeapon', '1HAND','It is the heaviest and most powerful bow. It can shoot arrows really, really far.',5,0,0,0,5,0,500,),
    Item('lightCrossbow','LIGHT CROSSBOW','rangedWeapon', '1HAND','It is a weapon with a mechanism that shoots bolts at great speed.',4,0,0,0,3,0,500,),
    Item('handCannon','HAND CANNON','rangedWeapon', '1HAND','It is a light weapon that shoots bullets.',3,0,0,0,0,0,600,),
    Item('heavyCrossbow','HEAVY CROSSBOW','rangedWeapon', '1HAND','It is a very heavy and powerful crossbow that shoots bolts really far.',7,0,0,0,8,0,600,),
    Item('musket','MUSKET','rangedWeapon', '1HAND','It is a primitive rifle that can shoot bullets and has a blade at the end.',5,0,0,0,3,0,700,),
  ];

  List<Item> magicWeapons = [
    Item('magicOrb','MAGIC ORB','magicWeapon', '1HAND','It is a cristal ball that has magic powers.',0,0,1,0,1,0,200,),
    Item('grenades','GRENADES','thrownWeapon', '1HAND','It is a shell that can be thrown and explodes on impact.',0,0,1,0,0,3,200,),
    Item('wand','WAND','magicWeapon', '1HAND','It is a thin stick that has magic powers.',0,0,1,0,0,0,300,),
    Item('ritualDagger','RITUAL DAGGER','magicWeapon', '1HAND','It is a dagger that has a magic blade.',1,0,1,0,2,0,300,),
    Item('magicSword','MAGIC SWORD','magicWeapon', '1HAND','It is a sword that has a magic blade.',1,1,1,0,3,0,400,),
    Item('spellBook','SPELL BOOK','magicWeapon', '1HAND','It is a enchanted book with old drawings and magic powers.',0,0,2,0,1,0,500,),
    Item('magicAxe','MAGIC AXE','magicWeapon', '1HAND','It is an axe that has a magic blade.',2,0,2,0,4,0,600,),
    Item('magicStaff','MAGIC STAFF','magicWeapon', '2HAND','It is a two handed staff that is enchanted with strong magic powers.',0,0,5,0,5,0,700,),
  ];

  List<Item> armor = [
    Item('boots','BOOTS','armor', 'FEET','It is a type of footwear that protects your feet.',0,1,0,0,1,0,100,),
    Item('gloves','GLOVES','armor', 'HANDS','It is a piece of gear that protects your hands.',0,1,0,0,1,0,100,),
    Item('buckler','BUCKLER','armor', '1HAND','It is a small shield that can be used to deflect attacks.',0,1,0,0,0,0,200,),
    Item('magicSandals','MAGIC SANDALS','armor', 'FEET','It is a magic sandals that protects from the elements.',0,0,0,1,1,0,200,),
    Item('helmet','HELMET','armor', 'HEAD','It is a piece of gear that protects your head.',0,2,0,0,1,0,300,),
    Item('lightShield','LIGHT SHIELD','armor', '1HAND','It is a board with a handle that is used to intercept attacks.',0,2,0,0,1,0,300,),
    Item('lightArmor','LIGHT ARMOR','armor', 'BODY','It is a light armor that offers some protection.',0,4,0,0,4,0,400,),
    Item('magicRobe','MAGIC ROBE','armor', 'BODY','It is a magic robe that protects the user from the elements.',0,0,0,2,2,0,400,),
    Item('heavyShield','HEAVY SHIELD','armor', '1HAND','It is a heavy metal shield that is used to intercept attacks.',0,4,0,0,3,0,500,),
    Item('fullHelmet','FULL HELMET','armor', 'HEAD','It is a piece of gear that protects the head and the face.',0,4,0,0,2,0,600,),
    Item('magicShield','MAGIC SHIELD','armor', '1HAND','It is a magic shield that offers protection from the the elements.',0,0,0,3,3,0,600,),
    Item('heavyArmor','HEAVY ARMOR','armor', 'BODY','It is a very heavy armor that offers a lot of protection.',0,7,0,0,7,0,700,),
  ];

  List<Item> resources = [
    Item('bandages','BANDAGES','resource','CONSUMABLE','Helps you stop the bleeding',0,0,0,0,0,1,100,),
    Item('ammo','AMMO','ammo','1HAND','Ammo.',0,0,0,0,0,5,100,),
  ];

//   List<Item> shopList = [
//     Item(0,'bonus','','','BONUS','Each background gives you a different bonus.',0,0,0,0,0,0,0,Image.asset('images/shop/00.png')),
//     Item(0,'shop','','','Shop','',0,0,0,0,0,0,0,Image.asset('images/shop/00.png')),
//     Item(0,'loot','','','Loot','',0,0,0,0,0,0,0,Image.asset('images/shop/00.png')),
//
//     //LIGHT
//
//     Item(1,'light','DEX','1HAND','DAGGER','It is a knife with a very sharp edge designed for close combat.',0,0,0,0,0,0,100, Image.asset('images/shop/light1.png')),
//     Item(2,'light','DEX','1HAND','BATON','It is a club with a handle and it is carried as a defensive weapon.',0,0,1,0,1,0,100, Image.asset('images/shop/light2.png')),
//     Item(3,'light','DEX','1HAND','SICKLE','It is a curved blade with the sharp edge on the inside.',0,0,0,0,0,0,200, Image.asset('images/shop/light3.png')),
//     Item(4,'light','DEX','1HAND','CLAW','A couple of blades designed to fit over the knuckles.',0,0,0,0,0,0,200, Image.asset('images/shop/light4.png')),
//     Item(5,'light','DEX','1HAND','WHIP','It is a handle with a flexible line at the end. ',0,0,0,0,0,0,200, Image.asset('images/shop/light5.png')),
//     Item(6,'light','DEX','1HAND','SHORT SPEAR','It is a stick with a pointy edge.',0,0,0,0,0,0,300, Image.asset('images/shop/light6.png')),
//     Item(7,'light','DEX','1HAND','RAPPIER','It is a very light sword used for pocking.',0,0,0,0,0,0,300, Image.asset('images/shop/light7.png')),
//     Item(8,'light','DEX','1HAND','NUNCHAKU','Two pieces of wood attached by a string. Requires a lot of coordination.',0,0,0,0,0,0,300, Image.asset('images/shop/light8.png')),
//     Item(9,'light','DEX','2HAND','QUARTERSTAFF','A pole that can be used as a defensive weapon.',0,0,2,0,2,0,400, Image.asset('images/shop/light9.png')),
//     Item(10,'light','DEX','1HAND','SABER','A sword with a curved blade and only one sharp edge.',1,0,0,0,1,0,400, Image.asset('images/shop/light10.png')),
//     Item(11,'light','DEX','2HAND','DOUBLE SWORD','A stick with a blade on each end.',2,0,0,0,2,0,500, Image.asset('images/shop/light11.png')),
//     Item(12,'light','DEX','2HAND','LONG SPEAR','A great weapon to keep your enemies at a distance.',1,0,0,0,1,0,500, Image.asset('images/shop/light12.png')),
//     Item(13,'light','DEX','2HAND','TRIDENT','A heavier e more powerful spear with three points.',2,0,0,0,2,0,600, Image.asset('images/shop/light13.png')),
//
//     // 15 Item Count
//
//     //HEAVY
//
//
//     Item(1,'heavy','STR','1HAND','CAESTUS','It is a fist weapon made out of steel.',0,0,0,0,0,0,100, Image.asset('images/shop/heavy1.png')),
//     Item(2,'heavy','STR','2HAND','GARROTE','It is a chain, rope, wire or anything used to strangle a person.',0,0,0,0,0,0,100, Image.asset('images/shop/heavy2.png')),
//     Item(3,'heavy','STR','1HAND','CLUB','It is a small bat made out of wood, metal or stone.',0,0,0,0,0,0,100, Image.asset('images/shop/heavy3.png')),
//     Item(4,'heavy','STR','1HAND','WOOD AXE','A small axe used for chopping wood.',0,0,0,0,0,0,200, Image.asset('images/shop/heavy4.png')),
//     Item(5,'heavy','STR','1HAND','SHORT SWORD','A small sword, great for fighting indoors.',0,0,0,0,0,0,300, Image.asset('images/shop/heavy5.png')),
//     Item(6,'heavy','STR','1HAND','MACE','A club reinforced with a metal head.',1,0,0,0,1,0,300, Image.asset('images/shop/heavy6.png')),
//     Item(7,'heavy','STR','1HAND','AXE','An axe with a longer blade and better grip. ',1,0,0,0,1,0,300, Image.asset('images/shop/heavy7.png')),
//     Item(8,'heavy','STR','1HAND','MORNING STAR','A club with a steal ball with spikes at the end.',2,0,0,0,2,0,400, Image.asset('images/shop/heavy8.png')),
//     Item(9,'heavy','STR','1HAND','SWORD','It is a very common weapon, used for pretty much any occasion.',1,0,0,0,1,0,400, Image.asset('images/shop/heavy9.png')),
//     Item(10,'heavy','STR','1HAND','LONG SWORD','A sword with a longer blade.',2,0,0,0,2,0,500,Image.asset('images/shop/heavy10.png')),
//     Item(11,'heavy','STR','1HAND','FLAIL','A ball of steel connected to a handle by a chain.',1,0,0,0,1,0,500,Image.asset('images/shop/heavy11.png')),
//     Item(12,'heavy','STR','1HAND','BATTLE AXE','A heavy axe with blade on both sides.',2,0,0,0,2,0,500,Image.asset('images/shop/heavy12.png')),
//     Item(13,'heavy','STR','1HAND','LANCE','A very long weapon, used mainly for jousting competitions.',3,0,0,0,3,0,600,Image.asset('images/shop/heavy13.png')),
//     Item(14,'heavy','STR','2HAND','GREAT SWORD','A very long and heavy sword. Those who wield it properly are fearsome adversaries.',3,0,0,0,3,0,600,Image.asset('images/shop/heavy14.png')),
//     Item(15,'heavy','STR','2HAND','HALBERD','A long spear with an axe at the end. Good for poking and slashing.',3,0,0,0,3,0,600,Image.asset('images/shop/heavy15.png')),
//     Item(16,'heavy','STR','2HAND','WAR HAMMER','A pole with a heavy metal head. Great for crushing bones.',3,0,0,0,3,0,600,Image.asset('images/shop/heavy16.png')),
//
//     // 31 Item Count
//
//     //RANGED WEAPON
//
//     Item(1,'ranged','DEX','1HAND','BOOMERANG','It is a thrown weapon that is designed to return to the thrower.',0,0,0,0,0,0,100,Image.asset('images/shop/ranged1.png')),
//     Item(2,'ranged','DEX','1HAND','SLING','It is used to throw rocks, clay, or lead.',0,0,0,0,0,0,100,Image.asset('images/shop/ranged2.png')),
//     Item(3,'ranged','DEX','1HAND','BLOW DART','It is a long tube for shooting light projectiles such as darts.',0,0,0,0,0,0,200,Image.asset('images/shop/ranged3.png')),
//     Item(4,'ranged','DEX','1HAND','KUNAI','It is a blade with a ring on the handle that can be used for attaching a rope.',0,0,0,0,0,0,200,Image.asset('images/shop/ranged4.png')),
//     Item(5,'ranged','DEX','1HAND','JAVELINS','Small spears that can be thrown at a target.',0,0,0,0,0,0,300,Image.asset('images/shop/ranged5.png')),
//     Item(6,'ranged','DEX','2HAND','SHORT BOW','A ranged weapon that can shoot arrows.',0,0,0,0,0,0,300,Image.asset('images/shop/ranged6.png')),
//     Item(7,'ranged','DEX','2HAND','LONG BOW','A longer bow that can shoot arrows even further.',0,0,0,0,0,0,400,Image.asset('images/shop/ranged7.png')),
//     Item(8,'ranged','DEX','1HAND','HAND CANNON','A ranged weapon that can shoot bullets.',1,0,0,0,1,0,400,Image.asset('images/shop/ranged8.png')),
//     Item(9,'ranged','DEX','1HAND','HAND CROSSBOW','A ranged weapon that shoots arrows. ',0,0,0,0,0,0,400,Image.asset('images/shop/ranged9.png')),
//     Item(10,'ranged','DEX','2HAND','GREAT BOW','',1,0,0,0,1,0,500,Image.asset('images/shop/ranged10.png')),
//     Item(11,'ranged','DEX','1HAND','LIGHT CROSSBOW','',1,0,0,0,1,0,500,Image.asset('images/shop/ranged11.png')),
//     Item(12,'ranged','STR','1HAND','GRENADE','',0,1,0,0,1,0,500,Image.asset('images/shop/ranged12.png')),
//     Item(13,'ranged','DEX','2HAND','MUSKET','',2,0,0,0,2,0,600,Image.asset('images/shop/ranged13.png')),
//     Item(14,'ranged','STR','2HAND','HEAVY CROSSBOW','',2,0,0,0,2,0,600,Image.asset('images/shop/ranged14.png')),
//
//     // 45 Item Count
//
//     //MAGIC
//
//
//
//     Item(1,'magic','INT','CONSUMABLE','Blank Scroll','',0,0,0,0,0,1,100,Image.asset('images/shop/magic1.png')),
//     Item(2,'magic','INT','CONSUMABLE','Protection Scroll','',0,0,0,0,0,1,200,Image.asset('images/shop/magic2.png')),
//     Item(3,'magic','INT','CONSUMABLE','Healing Scroll','',0,0,0,0,0,1,300,Image.asset('images/shop/magic3.png')),
//     Item(4,'magic','INT','CONSUMABLE','Skill Scroll','',0,0,0,0,0,1,400,Image.asset('images/shop/magic4.png')),
//     Item(5,'magic','INT','CONSUMABLE','Attribute Scroll','',0,0,0,0,0,1,400,Image.asset('images/shop/magic5.png')),
//     Item(6,'magic','INT','CONSUMABLE','Ability Scroll','',0,0,0,0,0,1,400,Image.asset('images/shop/magic6.png')),
//     Item(7,'magic','INT','CONSUMABLE','Summoning Scroll','',0,0,0,0,0,1,500,Image.asset('images/shop/magic7.png')),
//     Item(8,'magic','INT','CONSUMABLE','Life Scroll','',0,0,0,0,0,1,600,Image.asset('images/shop/magic8.png')),
//     Item(9,'magic','INT','1HAND','WAND','A wand is a thin, light-weight rod that has magical powers, allowing the user to cast spells.',0,0,0,0,0,0,200,Image.asset('images/shop/magic9.png')),
//     Item(10,'magic','INT','1HAND','SPELLBOOK','',0,1,0,0,1,0,400,Image.asset('images/shop/magic10.png')),
//     Item(11,'magic','INT','2HAND','MAGIC STAFF','',0,2,0,0,2,0,600,Image.asset('images/shop/magic11.png')),
//
//     // 56 Item Count
//
//
//     //ARMOR
//
//     Item(1,'armor','DEX','1HAND','BUCKLER','It is a small shield used for deflecting attacks.',0,0,1,0,1,0,100,Image.asset('images/shop/armor1.png')),
//     Item(2,'armor','STR','1HAND','LIGHT SHIELD','A shield used for intercepting attacks, whether from close-ranged or a distance.',0,0,1,0,1,0,200,Image.asset('images/shop/armor2.png')),
//     Item(3,'armor','STR','1HAND','HEAVY SHIELD','',0,0,2,0,2,0,300,Image.asset('images/shop/armor3.png')),
//     Item(4,'armor','STR','1HAND','TOWER SHIELD','',0,0,3,0,3,0,400,Image.asset('images/shop/armor4.png')),
//     Item(5,'armor','CON','BODY','LIGHT ARMOR','A light armor offers a bit of protection, prevent damage from being inflicted to the user.',0,0,1,0,1,0,200,Image.asset('images/shop/armor5.png')),
//     Item(6,'armor','CON','BODY','MEDIUM ARMOR','',0,0,2,0,2,0,300,Image.asset('images/shop/armor6.png')),
//     Item(7,'armor','CON','BODY','HEAVY ARMOR','',0,0,3,0,3,0,400,Image.asset('images/shop/armor7.png')),
//     Item(8,'armor','CON','BODY','FULL PLATE','',0,0,4,0,4,0,500,Image.asset('images/shop/armor8.png')),
//     Item(9,'armor','CON','FEET','BOOTS','A boot is a type of footwear that covers and protects your feet.',0,0,1,0,1,0,100,Image.asset('images/shop/armor9.png')),
//     Item(10,'armor','CON','FEET','GREAVES','',0,0,2,0,2,0,300,Image.asset('images/shop/armor10.png')),
//     Item(11,'armor','CON','HANDS','GLOVES','A glove is a garment covering the whole hand. It offers protection for your hands.',0,0,1,0,1,0,100,Image.asset('images/shop/armor11.png')),
//     Item(12,'armor','CON','HANDS','GAUNTLET','',0,0,2,0,2,0,300,Image.asset('images/shop/armor12.png')),
//     Item(13,'armor','CON','HEAD','HELMET','A helmet is a form of protective gear worn to protect the head.',0,0,1,0,1,0,100,Image.asset('images/shop/armor13.png')),
//     Item(14,'armor','CON','HEAD','FULL HELMET','',0,0,2,0,2,0,300,Image.asset('images/shop/armor14.png')),
//
//     // 70 Item Count
//
//     //RESOURCES
//
//     Item(1,'resource','','CONSUMABLE','Antidote','',0,0,0,0,0,1,100,Image.asset('images/shop/resource1.png')),
//     Item(2,'resource','','CONSUMABLE','Resistance Potion','',0,0,0,0,0,1,200,Image.asset('images/shop/resource2.png')),
//     Item(3,'resource','','CONSUMABLE','Healing Potion','',0,0,0,0,0,1,300,Image.asset('images/shop/resource3.png')),
//     Item(4,'resource','','CONSUMABLE','Magic Potion','',0,0,0,0,0,1,400,Image.asset('images/shop/resource4.png')),
//     Item(5,'resource','','CONSUMABLE','Invincibility Potion','',0,0,0,0,0,1,500,Image.asset('images/shop/resource5.png')),
//     Item(6,'resource','','CONSUMABLE','Life Potion','',0,0,0,0,0,1,600,Image.asset('images/shop/resource6.png')),
//     Item(7,'resource','','CONSUMABLE','Ammo','',1,0,0,0,1,5,100,Image.asset('images/shop/resource7.png')),
//     Item(8,'resource','','CONSUMABLE','Book','A book is a medium for recording information in the form of writing or images. When using the moves I KNOW or THAT GUY, spend the book to get a +2 on your roll.',0,0,0,0,0,1,100,Image.asset('images/shop/resource8.png')),
//     Item(9,'resource','','CONSUMABLE','Bandages','Spend your First Aid to heal 1D6.',0,0,0,0,0,1,100,Image.asset('images/shop/resource9.png')),
//     Item(10,'resource','','CONSUMABLE','Gear','Gear is a collection of useful tools such as chalk, poles, spikes, ropes, ladder, etc. At anytime you can spend your gear, turning it into an object of your choice.',0,0,0,0,0,1,200,Image.asset('images/shop/resource10.png')),
//     Item(11,'resource','','CONSUMABLE','Key','You can spend your key to open any chest, lock or door.',0,0,0,0,0,1,200,Image.asset('images/shop/resource11.png')),
//     Item(12,'resource','','CONSUMABLE','Ward','',0,0,0,0,0,1,300,Image.asset('images/shop/resource12.png')),
//     Item(13,'resource','','CONSUMABLE','Magic Ammo','',0,2,0,0,1,5,500,Image.asset('images/shop/resource13.png')),
//
//     // 83 Item Count
//
//
//     //ENCHANTMENT
//
//     Item(12,'enchantment','','CONSUMABLE','Skill Charm','',0,0,0,0,0,1,600,Image.asset('images/shop/enchantment1.png')),
//     Item(9,'enchantment','','CONSUMABLE','Rune','',0,2,0,0,1,1,500,Image.asset('images/shop/enchantment2.png')),
//     Item(11,'enchantment','','CONSUMABLE','Life Charm','',0,0,0,0,0,1,600,Image.asset('images/shop/enchantment3.png')),
//
//     // 86 Item Count
//
//     //BONUS
//
//     Item(6,'bonus','','CONSUMABLE','Adaptation','',0,0,0,0,1,1,300,Image.asset('images/shop/bonus1.png')),
//     Item(8,'bonus','','CONSUMABLE','Free Action','',0,0,0,0,0,1,400,Image.asset('images/shop/bonus2.png')),
//     Item(7,'bonus','','CONSUMABLE','Luck Charm','',0,0,0,0,0,1,400,Image.asset('images/shop/bonus3.png')),
//
//     // 89 Item Count
//
//
//   ];
 }



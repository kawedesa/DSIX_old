import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'playerAction.dart';
import 'option.dart';
import 'item.dart';
import 'buff.dart';


class ActionPage extends StatefulWidget {

  final Function() refresh;
  final Player player;

  const ActionPage({Key key, this.player, this.refresh}) : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();


}

class _ActionPageState extends State<ActionPage> {


  List<String> selectedAction = [
    'null','null','null','null','null','null',
  ];


  PlayerAction displayedAction = PlayerAction('action', 'ACTION', 'These are the actions your character can take throughout the game. Each one will have a different outcome depending on your luck.', [],0,false);

  void actionSelection(index){

    selectedAction = [
      'null','null','null','null','null','null',
    ];
    selectedAction.replaceRange(index, index+1, [widget.player.playerAction[index].icon]);
    displayedAction = widget.player.playerAction[index];
  }



  //DICE ANIMATION

  int diceNumber;

  List<String> diceAnimation = [
    'Roll',
    'Roll',
  ];
  List<double> hideLines = [
    1.0,
    1.0,
  ];

  //VARIABLES THAT CHANGE DEPENDING ON THE RESULT

  List<int> randomNumbers;
  String actionTitle = '';
  String actionSubTitle = '';
  Color resultColor;
  int result;
  String resultSum = '';
  String resultText;
  Widget resultAction;
  String resultTitle;
  String resultSubTitle;
  String actionText;
  String buttonText;
  int bonus;
  Item _localMainHandItem;

  void resetAndRoll(int dice){

    //THIS RESETS EVERYTHING


    diceAnimation = [
      'Roll',
      'Roll',
    ];
    hideLines = [
      1.0,
      1.0,
    ];

    diceNumber = dice;
    randomNumbers=[];
    while(dice>randomNumbers.length){
      randomNumbers.add(0);
    }
    result = 0;

    resultSum = '';
    actionText= '';
    resultText ='';
    resultAction = Container();
    resultColor = widget.player.playerColor;

  }

  void checkWeapon(Option option){

    alertTitle='';
    alertDescription='';
    actionTitle = displayedAction.name;
    actionSubTitle = ' +${displayedAction.value}';
    resetAndRoll(2);

    if(option.name == 'WEAPON'){
      if(widget.player.offHandEquip.name == '' && widget.player.mainHandEquip.name == ''){
        alertTitle = 'NO WEAPON';
        alertDescription = 'Sorry, but you need to equip a weapon first. \nYou can buy weapons in the shop menu and equip them in the inventory.';
        showAlertDialogCheckWeapon(context);

        //CHECK FOR AMMO
      }else if(widget.player.mainHandEquip.itemClass == 'rangedWeapon' && widget.player.offHandEquip.itemClass != 'ammo'){
        alertTitle = 'NO AMMO';
        alertDescription = 'You don\'t have enough ammo to use your ${widget.player.mainHandEquip.name}.';
        showAlertDialogCheckWeapon(context);

      }else if(widget.player.offHandEquip.itemClass == 'rangedWeapon' && widget.player.mainHandEquip.itemClass != 'ammo'){
        alertTitle = 'NO AMMO';
        alertDescription = 'You don\'t have enough ammo to use your ${widget.player.offHandEquip.name}.';
        showAlertDialogCheckWeapon(context);
      }else{
        widget.player.mainHandEquip.uses--;
        widget.player.offHandEquip.uses--;
        showAlertDialogActionRoll(context, option);
      }
    }else{

      showAlertDialogActionRoll(context, option);
    }

  }


  //THIS ROLLS AND DECIDES THE OUTCOME OF THE ACTION

  void rollDice(int index, Option option){

      if(randomNumbers[index] == 0){

        randomNumbers[index] = Random().nextInt(5) + 1;
        diceAnimation[index] = '${randomNumbers[index]}';
        hideLines[index] = 0;
      }

      if(randomNumbers.contains(0) == false && result == 0){

        widget.player.actionsTaken++;


        int check = 0;
        while(check<randomNumbers.length){
          result+=randomNumbers[check];
          check++;
        }

        result += displayedAction.value;
        resultSum = '${randomNumbers[0]} + ${randomNumbers[1]} + ${displayedAction.value} = $result';

        if(result>=10){
          actionTitle = 'SUCCESS';
          actionSubTitle = '';
          resultColor = Colors.green;
          actionText = option.success;

          if(displayedAction.name == 'ALTER SENSES' || displayedAction.name == 'ILLUSION'){
            if(displayedAction.name == 'ILLUSION'){
              resultTitle = 'ILLUSION';
              resultSubTitle = '';
              resultText = 'Choose two senses.';
              buttonText = 'SENSES';
            }else if(option.name == 'ENHANCE'){
              resultTitle = 'ENHANCE';
              resultSubTitle = '';
              resultText = 'Choose two senses.';
              buttonText = 'SENSES';
            }else if(option.name == 'REMOVE'){
              resultTitle = 'REMOVE';
              resultSubTitle = '';
              resultText = 'Choose two senses.';
              buttonText = 'SENSES';
            }
            resultAction = TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),),
              onPressed: () {

                Navigator.pop(context);
                showAlertDialogChooseSenses(context, 2);

              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                          child: SvgPicture.asset(
                            'assets/ui/action.svg',
                            color: resultColor,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Center(
                        child: Text(buttonText,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );

          }else if(displayedAction.name == 'ATTACK' || displayedAction.name == 'DEFEND'){
            if(displayedAction.name == 'ATTACK' && option.name =='PUNCH'){
              resultTitle = 'DAMAGE';
              resultSubTitle = '';
              bonus = 0;
              buttonText = 'DAMAGE';
            }else if(displayedAction.name == 'ATTACK' && option.name == 'WEAPON'){
              resultTitle = 'DAMAGE';
              bonus = widget.player.pDamage + widget.player.mDamage;
              resultSubTitle = '+ $bonus';
              buttonText = 'DAMAGE';
            }else if(displayedAction.name == 'DEFEND' && option.name == 'PHYSICAL DEFENSE'){
              resultTitle = 'DEFEND';
              bonus = widget.player.pArmor;
              resultSubTitle = '+ $bonus';
              buttonText = 'DEFEND';
            }else if(displayedAction.name == 'DEFEND' && option.name == 'MAGIC DEFENSE'){
              resultTitle = 'DEFEND';
              bonus = widget.player.mArmor;
              resultSubTitle = '+ $bonus';
              buttonText = 'DEFEND';
            }
            resultAction = TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),),
              onPressed: () {

                Navigator.pop(context);
                resetAndRoll(2);
                showAlertDialogActionResultRoll(context, bonus);

              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                          child: SvgPicture.asset(
                            'assets/ui/action.svg',
                            color: resultColor,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Center(
                        child: Text(buttonText,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else if(displayedAction.name == 'CALL OF NATURE'){
            if(option.name == 'DEFEND'){
              resultTitle = 'DEFEND';
              bonus = 0;
              resultSubTitle = '';
              buttonText = 'DEFEND';
              resultAction = TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),),
                onPressed: () {

                  Navigator.pop(context);
                  resetAndRoll(2);
                  showAlertDialogActionResultRoll(context, bonus);

                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                            child: SvgPicture.asset(
                              'assets/ui/action.svg',
                              color: resultColor,
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: resultColor,
                          width: 2.5, //                   <--- border width here
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Center(
                          child: Text(buttonText,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else if(option.name == 'ATTACK'){
              resultTitle = 'DAMAGE';
              bonus = 0;
              resultSubTitle = '';
              buttonText = 'DAMAGE';
              resultAction = TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),),
                onPressed: () {

                  Navigator.pop(context);
                  resetAndRoll(2);
                  showAlertDialogActionResultRoll(context, bonus);

                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                            child: SvgPicture.asset(
                              'assets/ui/action.svg',
                              color: resultColor,
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: resultColor,
                          width: 2.5, //                   <--- border width here
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Center(
                          child: Text(buttonText,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }else if(displayedAction.name == 'ALCHEMY' && option.name == 'FIRE'){
            resultTitle = 'DAMAGE';
            bonus = 0;
            resultSubTitle = '';
            buttonText = 'DAMAGE';
            resultAction = TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),),
              onPressed: () {

                Navigator.pop(context);
                resetAndRoll(2);
                showAlertDialogActionResultRoll(context, bonus);

              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                          child: SvgPicture.asset(
                            'assets/ui/action.svg',
                            color: resultColor,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Center(
                        child: Text(buttonText,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

        }else if(result<=9 && result>=7){
          actionTitle = 'HALF SUCCESS';
          actionSubTitle = '';
          resultColor = Colors.green;
          actionText = option.halfSuccess;

          if(displayedAction.name == 'ALTER SENSES' || displayedAction.name == 'ILLUSION'){
            if(displayedAction.name == 'ILLUSION'){
              resultTitle = 'ILLUSION';
              resultSubTitle = '';
              resultText = 'Choose one sense.';
              buttonText = 'SENSES';
            }else if(option.name == 'ENHANCE'){
              resultTitle = 'ENHANCE';
              resultSubTitle = '';
              resultText = 'Choose one sense.';
              buttonText = 'SENSES';
            }else if(option.name == 'REMOVE'){
              resultTitle = 'REMOVE';
              resultSubTitle = '';
              resultText = 'Choose one sense.';
              buttonText = 'SENSES';
            }
            resultAction = TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),),
              onPressed: () {

                Navigator.pop(context);
                showAlertDialogChooseSenses(context, 1);

              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                          child: SvgPicture.asset(
                            'assets/ui/action.svg',
                            color: resultColor,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Center(
                        child: Text(buttonText,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );

          }else if(displayedAction.name == 'ATTACK' || displayedAction.name == 'DEFEND'){
            if(displayedAction.name == 'ATTACK' && option.name =='PUNCH'){
              resultTitle = 'DAMAGE';
              resultSubTitle = '';
              bonus = 0;
              buttonText = 'DAMAGE';
            }else if(displayedAction.name == 'ATTACK' && option.name == 'WEAPON'){
              resultTitle = 'DAMAGE';
              bonus = widget.player.pDamage + widget.player.mDamage;
              resultSubTitle = '+ $bonus';
              buttonText = 'DAMAGE';
            }else if(displayedAction.name == 'DEFEND' && option.name == 'PHYSICAL DEFENSE'){
              resultTitle = 'DEFEND';
              bonus = widget.player.pArmor;
              resultSubTitle = '+ $bonus';
              buttonText = 'DEFEND';
            }else if(displayedAction.name == 'DEFEND' && option.name == 'MAGIC DEFENSE'){
              resultTitle = 'DEFEND';
              bonus = widget.player.mArmor;
              resultSubTitle = '+ $bonus';
              buttonText = 'DEFEND';
            }
            resultAction = TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),),
              onPressed: () {

                Navigator.pop(context);
                resetAndRoll(1);
                showAlertDialogActionResultRoll(context, bonus);

              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                          child: SvgPicture.asset(
                            'assets/ui/action.svg',
                            color: resultColor,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Center(
                        child: Text(buttonText,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else if(displayedAction.name == 'CALL OF NATURE'){
            if(option.name == 'DEFEND'){
              resultTitle = 'DEFEND';
              bonus = 0;
              resultSubTitle = '';
              buttonText = 'DEFEND';
              resultAction = TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),),
                onPressed: () {

                  Navigator.pop(context);
                  resetAndRoll(1);
                  showAlertDialogActionResultRoll(context, bonus);

                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                            child: SvgPicture.asset(
                              'assets/ui/action.svg',
                              color: resultColor,
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: resultColor,
                          width: 2.5, //                   <--- border width here
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Center(
                          child: Text(buttonText,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else if(option.name == 'ATTACK'){
              resultTitle = 'DAMAGE';
              bonus = 0;
              resultSubTitle = '';
              buttonText = 'DAMAGE';
              resultAction = TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),),
                onPressed: () {

                  Navigator.pop(context);
                  resetAndRoll(1);
                  showAlertDialogActionResultRoll(context, bonus);

                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                            child: SvgPicture.asset(
                              'assets/ui/action.svg',
                              color: resultColor,
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: resultColor,
                          width: 2.5, //                   <--- border width here
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Center(
                          child: Text(buttonText,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }else if(displayedAction.name == 'ALCHEMY' && option.name == 'FIRE'){
            resultTitle = 'DAMAGE';
            bonus = 0;
            resultSubTitle = '';
            buttonText = 'DAMAGE';
            resultAction = TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),),
              onPressed: () {

                Navigator.pop(context);
                resetAndRoll(1);
                showAlertDialogActionResultRoll(context, bonus);

              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                          child: SvgPicture.asset(
                            'assets/ui/action.svg',
                            color: resultColor,
                            width: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Center(
                        child: Text(buttonText,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

        }else{
          actionTitle = 'FAIL';
          actionSubTitle = '';
          resultColor = Colors.red;
          actionText = option.fail;
        }


        if(widget.player.buffList.length!=0){
          for(int check = 0; check< widget.player.buffList.length; check++){
            widget.player.buffList[check].duration--;
          }
          for(int check = 0; check< widget.player.buffList.length; check++){
            if(widget.player.buffList[check].duration == 0){
              widget.player.buffList.removeAt(check);
              widget.player.playerAction[5].value++;
            }
          }
        }

        if(displayedAction.concentration == true){
          widget.player.buffList.add(Buff(displayedAction.icon,'CONCENTRATION','This action requires concentration. Each time this action is taken consecutively, it will decrease the chance of success.',-1,2));
          widget.player.playerAction[5].value--;
        }


      }

  }

  //THIS DECIDES THE OUTCOME OF THE RESULT

  void resultRoll(int index, int bonus){
    int diceResult = 0;

    if(randomNumbers[index] == 0){

      randomNumbers[index] = Random().nextInt(5) + 1;
      diceAnimation[index] = '${randomNumbers[index]}';
      hideLines[index] = 0;
    }

    if(randomNumbers.contains(0) == false){
      for(int check=0; check<randomNumbers.length; check++){
        diceResult += randomNumbers[check];
      }

      result = bonus + diceResult;
      resultSum = '$diceResult + $bonus = $result';

      if(resultTitle == 'DAMAGE'){
        resultText = 'You deal $result points of damage.';
      }else if(resultTitle == 'DEFEND') {
        resultText = 'You defend $result points of damage.';
      }

      if(widget.player.mainHandEquip.itemClass == 'thrownWeapon' || widget.player.mainHandEquip.itemClass == 'ammo'){
        if(widget.player.mainHandEquip.uses<=0){
          widget.player.pDamage -= widget.player.mainHandEquip.pDamage;
          widget.player.pArmor -= widget.player.mainHandEquip.pArmor;
          widget.player.mDamage -= widget.player.mainHandEquip.mDamage;
          widget.player.mArmor -= widget.player.mainHandEquip.mArmor;
          widget.player.mainHandEquip = Item('mainHand','','', '','',0,0,0,0,0,0,0,);
        }
      }else if(widget.player.offHandEquip.itemClass == 'thrownWeapon' || widget.player.offHandEquip.itemClass == 'ammo') {
        if(widget.player.offHandEquip.uses<=0){
          widget.player.pDamage -= widget.player.offHandEquip.pDamage;
          widget.player.pArmor -= widget.player.offHandEquip.pArmor;
          widget.player.mDamage -= widget.player.offHandEquip.mDamage;
          widget.player.mArmor -= widget.player.offHandEquip.mArmor;
          widget.player.offHandEquip = Item('offHand','','', '','',0,0,0,0,0,0,0,);
        }
      }

    }
  }


  //THIS IS THE POP MENU THAT SHOWS THE DICE AND THE RESULT OF THE ACTION

  showAlertDialogActionRoll(BuildContext context,Option option)
  {

    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
            builder: (context, setState) {

          return AlertDialog(
            backgroundColor: Colors.black,
            contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: resultColor,
                      width: 2.5, //                   <--- border width here
                    ),
                  ),
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: resultColor,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,10,0,10),
                          child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(actionTitle,
                                  style: TextStyle(
                                    fontFamily: 'Headline',
                                    height: 1.3,
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(actionSubTitle,
                                  style: TextStyle(
                                    fontFamily: 'Headline',
                                    height: 1.3,
                                    fontSize: 30.0,
                                    color: widget.player.playerSecondaryColor,
                                    letterSpacing: 2,
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(22,10,22,0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 125 * (diceNumber).toDouble(),
                              height: 200,
                              child: ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: diceNumber,
                                  itemBuilder: (BuildContext context, int index) {
                                    return TextButton(
                                        style: TextButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        ),
                                      onPressed: (){
                                        setState(() {
                                          rollDice(index, option);
                                        });
                                        widget.refresh();
                                      },
                                      child: SizedBox(
                                        width: 125,
                                        height: 200,
                                        child:Stack(
                                          children: <Widget>[
                                            AnimatedOpacity(
                                              curve: Curves.easeInOutExpo,
                                              opacity: hideLines[index],
                                              duration: Duration(milliseconds: 300),
                                              child: FlareActor(
                                                'assets/animation/line.flr',
                                                fit: BoxFit.fitHeight,
                                                animation: 'Lines',
                                                color: widget.player.playerColor,
                                              ),
                                            ),
                                            FlareActor(
                                              'assets/animation/dice.flr',
                                              fit: BoxFit.fitHeight,
                                              animation: diceAnimation[index],
                                              color: Colors.white,
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(30,5,30,0),
                              child: Center(
                                child: Text(resultSum,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                  fontFamily: 'Headline',
                                  fontSize: 27.0,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),

                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13,160,13,20),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    // color: widget.player.playerTertiaryColor,
                                    child: Text(actionText,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        height: 1.25,
                                        fontSize: 23,
                                        fontFamily: 'Calibri',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                    child: resultAction,
                                  ),
                                ],
                              ),
                            ),
                          ],

                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

            },
        );

      },
    );
  }


  //THIS IS THE POP MENU THAT SHOWS THE DICE AND THE DAMAGE/PROTECTION RESULT
  showAlertDialogActionResultRoll(BuildContext context, int bonus)
  {

    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setState) {

            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.player.playerColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: widget.player.playerColor,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10,10,10,10),
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(resultTitle,
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1.3,
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  Text(resultSubTitle,
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1.3,
                                      fontSize: 30.0,
                                      color: widget.player.playerSecondaryColor,
                                      letterSpacing: 2,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22,10,22,0),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 125 * (diceNumber).toDouble(),
                                    height: 200,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: diceNumber,
                                        itemBuilder: (BuildContext context, int index) {
                                          return TextButton(
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                resultRoll(index, bonus);
                                              });
                                              widget.refresh();
                                            },
                                            child: SizedBox(
                                              width: 125,
                                              height: 200,
                                              child:Stack(
                                                children: <Widget>[
                                                  AnimatedOpacity(
                                                    curve: Curves.easeInOutExpo,
                                                    opacity: hideLines[index],
                                                    duration: Duration(milliseconds: 300),
                                                    child: FlareActor(
                                                      'assets/animation/line.flr',
                                                      fit: BoxFit.fitHeight,
                                                      animation: 'Lines',
                                                      color: widget.player.playerColor,
                                                    ),
                                                  ),
                                                  FlareActor(
                                                    'assets/animation/dice.flr',
                                                    fit: BoxFit.fitHeight,
                                                    animation: diceAnimation[index],
                                                    color: Colors.white,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(30,5,30,0),
                                child: Center(
                                  child: Text(resultSum,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      fontSize: 27.0,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),

                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(13,170,13,20),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      // color: widget.player.playerTertiaryColor,
                                      child: Text(resultText,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          height: 1.25,
                                          fontSize: 23,
                                          fontFamily: 'Calibri',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                      child: resultAction,
                                    ),
                                  ],
                                ),
                              ),
                            ],

                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          },
        );

      },
    );
  }



  //THIS IS THE POP MENU THAT LETS YOU CHOOSE THE SENSES

  List<String> sense = [
    'Sound', 'Smell', 'Sight', 'Taste', 'Touch'
  ];

  showAlertDialogChooseSenses(BuildContext context, int numberOfSenses)
  {

    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setState) {

            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.player.playerColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: widget.player.playerColor,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10,10,10,10),
                            child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(actionTitle,
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1.3,
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  Text(actionSubTitle,
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1.3,
                                      fontSize: 30.0,
                                      color: widget.player.playerSecondaryColor,
                                      letterSpacing: 2,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22,20,22,0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(13,0,13,25),
                                child: Text(resultText,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    height: 1.25,
                                    fontSize: 23,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 190,
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  children: List.generate(sense.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      child: Container(
                                        height: 25,
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/action/${sense[index]}.svg',
                                              color: Colors.white,
                                              width: MediaQuery.of(context).size.width * 0.1,
                                            ),
                                            Text('${sense[index]}',
                                              style: TextStyle(
                                                height: 1.7,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                                fontFamily: 'Calibri',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),

                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          },
        );

      },
    );
  }

  //THIS IS THE POP MENU THAT TELLS YOU ABOUT EQUIPPED WEAPONS AND AMMO

  String alertTitle;
  String alertDescription;

  showAlertDialogCheckWeapon(BuildContext context,)
  {

    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.player.playerColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.player.playerColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30,10,30,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(alertTitle,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 30.0,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),

                      ],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,15,25,20),
                  child: Text(alertDescription,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 22,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            width:double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5,10, 0),
              child: Stack(
                children: <Widget>[

                  //ACTION ICON

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),

                        child: SvgPicture.asset(
                          'assets/action/${widget.player.playerAction[index].icon}.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                      );
                    }),
                  ),

                  //ACTION VALUE

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),

                        child: SvgPicture.asset(
                          'assets/action/${widget.player.playerAction[index].value}.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                      );
                    }),
                  ),



                  GridView.count(
                    crossAxisCount: 6,

                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              actionSelection(index);
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                          ),

                          child: SvgPicture.asset(
                            'assets/action/${selectedAction[index]}.svg',
                            color: widget.player.playerColor,
                          ),
                        ),
                      );
                    }),
                  ),

                ],

              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.player.playerColor,
        ),
        Expanded(
          flex: 13,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(65,15,65,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(displayedAction.name,
                    style: TextStyle(
                      fontFamily: 'Headline',
                      height: 1.3,
                      fontSize: 50,
                      color: widget.player.playerColor,
                      letterSpacing: 2,
                    ),),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0,10,0,0),
                //   child: Text('Actions taken: ${widget.player.actionsTaken}',
                //     textAlign: TextAlign.justify,
                //     style: TextStyle(
                //       letterSpacing: 3,
                //       fontSize: 20,
                //       fontFamily: 'Headline',
                //       color: Colors.white,
                //     ),),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,15),
                  child: Text(displayedAction.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 22,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.0+displayedAction.option.length*56,
                  child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      itemCount: displayedAction.option.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextButton(
                            style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0,0,0,10),
                            ),
                          onPressed: (){

                              checkWeapon(displayedAction.option[index]);

                          },

                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,12,12,0),
                                      child: SvgPicture.asset(
                                        'assets/ui/action.svg',
                                        color: widget.player.playerColor,
                                        width: MediaQuery.of(context).size.width * 0.055,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget.player.playerColor,
                                    width: 2.5, //                   <--- border width here
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                                  child: Center(
                                    child: Text(displayedAction.option[index].name,
                                      style: TextStyle(
                                        height: 1.5,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        fontFamily: 'Calibri',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
import 'dart:math';
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/dsix/dice.dart';
import 'package:dsixv02app/models/player/action/actionResult.dart';
import 'package:dsixv02app/widgets/diceAnimation.dart';
import 'package:flutter/material.dart';

class SecondRollDialog extends StatefulWidget {
  const SecondRollDialog({
    @required this.result,
  });

  final ActionResult result;

  @override
  State<SecondRollDialog> createState() => _SecondRollDialogState();
}

class _SecondRollDialogState extends State<SecondRollDialog> {
  List<Dice> diceList;
  Widget outcomeWidget = Container();

  void prepareDice(int numberOfDice) {
    this.diceList = [];
    while (this.diceList.length < numberOfDice) {
      this.diceList.add(Dice(0, 1));
    }
  }

  void tapDie(int index) {
    if (diceList[index].die != 0) {
      return;
    }

    int randomNumber = Random().nextInt(3) + 1;

    diceList[index].die = randomNumber;
    diceList[index].animationLines = 0;

    int _checkDice = 0;
    int _result = 0;

    diceList.forEach((element) {
      if (element.die == 0) {
        return;
      } else {
        _checkDice++;
        _result += element.die;
      }
    });

    if (_checkDice == diceList.length) {
      showResult(_result);
    }
  }

  String resultSum;

  void showResult(int result) {
    if (widget.result.outcomeBonus == null) {
      resultSum = '$result + 0 = $result';
    } else {
      int total = result + widget.result.outcomeBonus;
      resultSum = '$result + ${widget.result.outcomeBonus} = $total';
    }

    outcomeWidget = Text(
      widget.result.outcomeText,
      textAlign: TextAlign.justify,
      style: AppTextStyles.dialogDescriptionStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (diceList == null) {
      prepareDice(widget.result.outcomeValue);
    }

    return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: Container(
          color: AppColors.black01,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.result.color,
                    width: 1.5, //                   <--- border width here
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: AppColors.success,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                        child: Center(
                          child: Text(widget.result.outcomeTitle.toUpperCase(),
                              style: AppTextStyles.dialogTitleStyle),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 125 * (this.diceList.length).toDouble(),
                                height: 180,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: this.diceList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tapDie(index);
                                          });
                                        },
                                        child: DiceAnimation(
                                          color: widget.result.color,
                                          die: this.diceList[index].die,
                                          lines: this
                                              .diceList[index]
                                              .animationLines,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 7, 30, 0),
                            child: Center(
                              child: (resultSum == null)
                                  ? Container()
                                  : Text(
                                      resultSum,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 150, 25, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: outcomeWidget),
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
        ));
  }
}

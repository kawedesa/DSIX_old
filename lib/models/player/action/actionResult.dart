import 'package:flutter/material.dart';
import 'actionOutcome.dart';

class ActionResult {
  List<int> diceResult = [];
  int bonus;
  int total;
  String sum;
  Color color;
  String outcomeAction;
  String outcomeTitle;
  String outcomeType;
  String outcomeText;
  List<ActionOutcome> outcomeOptions = [];
  int outcomeValue;
  int outcomeBonus;

  ActionResult({
    List<int> diceResult,
    int bonus,
    int total,
    String sum,
    Color color,
    String outcomeAction,
    String outcomeTitle,
    String outcomeType,
    String outcomeText,
    List<ActionOutcome> outcomeOptions,
    int outcomeValue,
    int outcomeBonus,
  }) {
    this.diceResult = diceResult;
    this.bonus = bonus;
    this.total = total;
    this.sum = sum;
    this.color = color;
    this.outcomeAction = outcomeAction;
    this.outcomeTitle = outcomeTitle;
    this.outcomeType = outcomeType;
    this.outcomeText = outcomeText;
    this.outcomeOptions = outcomeOptions;
    this.outcomeValue = outcomeValue;
    this.outcomeBonus = outcomeBonus;
  }

  // ActionResult blankResult() {
  //   ActionResult newResult = ActionResult(
  //     diceResult: this.diceResult = [],
  //     // bonus: 0,
  //     // total: 0,
  //     // sum: '',

  //     // outcomeAction: '',
  //     // outcomeTitle: '',
  //     // outcomeType: '',
  //     // outcomeText: '',
  //     outcomeOptions: [],
  //     outcomeValue: 0,
  //     outcomeBonus: 0,
  //   );

  //   return newResult;
  // }
}

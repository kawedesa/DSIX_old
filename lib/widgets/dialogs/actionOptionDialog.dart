import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/player/action/actionResult.dart';
import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:dsixv02app/widgets/dialogs/dialogTitle.dart';
import 'package:flutter/material.dart';

class ActionOptionDialog extends StatefulWidget {
  const ActionOptionDialog({
    @required this.result,
    @required this.target,
  });

  final ActionResult result;
  final Player target;

  @override
  State<ActionOptionDialog> createState() => _ActionOptionDialogState();
}

class _ActionOptionDialogState extends State<ActionOptionDialog> {
  EffectSystem _effectSystem = EffectSystem();
  int selectionCheck = 0;

  void selectItem(int index) {
    if (widget.result.outcomeOptions[index].selected) {
      widget.result.outcomeOptions[index].selected = false;
      selectionCheck--;
    } else {
      widget.result.outcomeOptions[index].selected = true;
      selectionCheck++;
    }
    if (selectionCheck == widget.result.outcomeValue) {
      chooseOutcome();
    }
  }

  void chooseOutcome() {
    switch (widget.result.outcomeAction) {
      case 'resources':
        {
          widget.result.outcomeOptions.forEach((outcome) {
            if (outcome.selected) {
              widget.target.bag.add(outcome.itemList.first);
            }
          });
        }
        break;

      case 'information':
        {}
        break;

      case 'morph':
        {
          _effectSystem.removeAllEffectsFromOrigin('morph', widget.target);

          widget.result.outcomeOptions.forEach((element) {
            if (element.selected) {
              _effectSystem.addEffect(
                'positive',
                element.name,
                2,
                widget.target,
              );
            }
          });

          //   List<Effect> removeEffects = [];

          //   this.effects.forEach((currentEffect) {
          //     if (currentEffect.type == 'MORPH') {
          //       removeEffects.add(currentEffect);
          //     }
          //   });

          //   removeEffects.forEach((removeEffect) {
          //     removeTemporaryEffect(removeEffect);
          //   });

          //   this.result.outcomeOptions.forEach((outcome) {
          //     if (outcome.selected) {
          //       newTemporaryEffect(outcome.name, 2);
          //     }
          //   });
        }
        break;

      case 'illusion':
        {
          // this.result.outcomeOptions.forEach((outcome) {
          //   if (outcome.selected) {
          //     newTemporaryEffect(outcome.name, 2);
          //   }
          // });
        }
        break;

      case 'bless':
        {
          // List<Effect> removeEffects = [];
          // this.effects.forEach((effect) {
          //   if (effect.type == 'ALTER SENSES') {
          //     removeEffects.add(effect);
          //   }
          // });
          // removeEffects.forEach((element) {
          //   this.effects.remove(element);
          // });
          // this.result.outcomeOptions.forEach((outcome) {
          //   if (outcome.selected) {
          //     newTemporaryEffect(outcome.name, 2);
          //   }
          // });
        }
        break;
      case 'curse':
        {
          // List<Effect> removeEffects = [];
          // this.effects.forEach((effect) {
          //   if (effect.type == 'ALTER SENSES') {
          //     removeEffects.add(effect);
          //   }
          // });
          // removeEffects.forEach((element) {
          //   this.effects.remove(element);
          // });
          // this.result.outcomeOptions.forEach((outcome) {
          //   if (outcome.selected) {
          //     newTemporaryEffect(outcome.name, 2);
          //   }
          // });
        }
        break;
    }

    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DialogTitle(
                    title:
                        'choose: ${widget.result.outcomeValue}'.toUpperCase(),
                    color: widget.result.color),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: (widget.result.outcomeOptions.length < 6)
                        ? MediaQuery.of(context).size.height *
                            0.08 *
                            widget.result.outcomeOptions.length
                        : MediaQuery.of(context).size.height * 0.08 * 6,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.result.outcomeOptions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DialogButton(
                                buttonText: widget
                                    .result.outcomeOptions[index].name
                                    .toUpperCase(),
                                buttonColor: widget.result.color,
                                buttonTextColor: AppColors.white01,
                                buttonFillColor: (widget
                                        .result.outcomeOptions[index].selected)
                                    ? widget.result.color
                                    : null,
                                onTapAction: () async {
                                  setState(() {
                                    selectItem(index);
                                  });
                                },
                              ),
                              // GestureDetector(
                              //   // onTap: () {
                              //   //   setState(() {
                              //   //     selectOutcome(index);
                              //   //   });
                              //   // },
                              //   child: Container(
                              //     width: double.infinity,
                              //     height:
                              //         MediaQuery.of(context).size.height * 0.08,
                              //     // color: (widget.dsix.gm
                              //     //         .getCurrentPlayer()
                              //     //         .result
                              //     //         .outcomeOptions[index]
                              //     //         .selected)
                              //     //     ? widget.dsix.gm
                              //     //         .getCurrentPlayer()
                              //     //         .playerColor
                              //     //         .primaryColor
                              //     //     : Colors.black,
                              //     color: Colors.black,
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.fromLTRB(0, 7.5, 0, 0),
                              //       child: Center(
                              //         child: Text(
                              //           widget.result.outcomeOptions[index].name
                              //               .toUpperCase(),
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.bold,
                              //             letterSpacing: 1.5,
                              //             fontFamily: 'Calibri',
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Divider(
                                height: 0,
                                thickness: 2,
                                color: widget.result.color,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

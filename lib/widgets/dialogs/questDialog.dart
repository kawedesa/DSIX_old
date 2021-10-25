import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:flutter/material.dart';
import 'dialogTitle.dart';

class QuestDialog extends StatefulWidget {
  const QuestDialog({@required this.availableQuests, @required this.gm});

  final List<Quest> availableQuests;
  final Gm gm;

  @override
  State<QuestDialog> createState() => _QuestDialogState();
}

class _QuestDialogState extends State<QuestDialog> {
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
                color: AppColors.gmTertiaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DialogTitle(
                    title: 'choose a quest'.toUpperCase(),
                    color: AppColors.gmTertiaryColor),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height *
                        0.08 *
                        this.widget.availableQuests.length,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: this.widget.availableQuests.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DialogButton(
                                buttonText: this
                                    .widget
                                    .availableQuests[index]
                                    .objective
                                    .objective,
                                buttonTextColor: AppColors.white01,
                                onTapAction: () async {
                                  widget.gm.quest =
                                      widget.availableQuests[index];
                                  Navigator.pop(context);
                                },
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                                color: AppColors.gmTertiaryColor,
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

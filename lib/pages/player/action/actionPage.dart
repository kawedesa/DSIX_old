import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/descriptionTitle.dart';
import 'package:dsixv02app/widgets/dialogs/actionDialog.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'actionPageVM.dart';

class ActionPage extends StatefulWidget {
  final Function() refresh;
  final Function(String) alert;
  final Dsix dsix;

  const ActionPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  ActionPageVM _actionPageVM = ActionPageVM();

  @override
  Widget build(BuildContext context) {
    if (_actionPageVM.selector.items.isEmpty) {
      _actionPageVM.selector
          .newSelection(widget.dsix.getCurrentPlayer().actions.length);
    }

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
            child: Stack(
              children: <Widget>[
                //Values
                GridView.count(
                  crossAxisCount: 6,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(
                        'assets/icon/action/${widget.dsix.getCurrentPlayer().actions[index].value}.svg',
                        color: AppColors.white01,
                      ),
                    );
                  }),
                ),
                //Icons
                GridView.count(
                  crossAxisCount: 6,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _actionPageVM.selectAction(
                                widget.dsix.getCurrentPlayer(), index);
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/icon/action/${widget.dsix.getCurrentPlayer().actions[index].icon}.svg',
                          color: _actionPageVM.selector.items[index]
                              ? widget.dsix.getCurrentPlayer().primaryColor
                              : AppColors.white01,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.getCurrentPlayer().primaryColor,
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                child: Container(
                  width: 40,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    children: List.generate(
                        widget.dsix.getCurrentPlayer().currentEffects.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          width: 40,
                          height: 40,
                          // color: Colors.amber,
                          child: GestureDetector(
                            // onTap: () {
                            //   showEffect(index);
                            // },
                            child: SvgPicture.asset(
                              'assets/icon/effect/${widget.dsix.getCurrentPlayer().currentEffects[index].icon}.svg',
                              color:
                                  widget.dsix.getCurrentPlayer().primaryColor,
                            ),
                          ),
                        ),
                      );
                      // return Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: GestureDetector(
                      //     // onTap: () {
                      //     //   showEffect(index);
                      //     // },
                      //     child: SvgPicture.asset(
                      //       'assets/icon/effect/${widget.dsix.getCurrentPlayer().effects.currentEffects[index].icon}.svg',
                      //       color: widget.dsix
                      //           .getCurrentPlayer()
                      //           .primaryColor,
                      //     ),
                      //   ),
                      // );
                    }),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      DescriptionTitle(
                        title: _actionPageVM.selectedAction.name,
                        color: widget.dsix.getCurrentPlayer().primaryColor,
                      ),
                      (_actionPageVM.selector.items.contains(true))
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Description(
                                  description: _actionPageVM
                                      .selectedAction.description)),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          itemCount: _actionPageVM.selectedAction.option.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Button(
                                onTapAction: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ActionDialog(
                                        shop: widget.dsix.shop,
                                        action: _actionPageVM
                                            .selectedAction.option[index],
                                        player: widget.dsix.getCurrentPlayer(),
                                      );
                                    },
                                  ).then((_) => setState(() {}));
                                },
                                buttonText: _actionPageVM
                                    .selectedAction.option[index].name,
                                buttonColor:
                                    widget.dsix.getCurrentPlayer().primaryColor,
                                buttonIcon: 'action',
                                buttonTextColor: AppColors.white01,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

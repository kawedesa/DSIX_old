import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/dialogs/descriptionDialog.dart';
import 'package:dsixv02app/widgets/descriptionTitle.dart';
import 'package:dsixv02app/widgets/buttons/goBackButton.dart';
import 'package:dsixv02app/widgets/buttons/nextButton.dart';
import 'package:dsixv02app/widgets/pageTitle.dart';
import 'package:dsixv02app/widgets/dialogs/textInputDialog.dart';
import 'package:dsixv02app/widgets/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'actionPointPageVM.dart';

class ActionPointPage extends StatefulWidget {
  final Dsix dsix;

  const ActionPointPage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/actionPointPage";

  @override
  _ActionPointPageState createState() => new _ActionPointPageState();
}

class _ActionPointPageState extends State<ActionPointPage> {
  ActionPointPageVM actionPointPageVM = ActionPointPageVM();
  double nextButtonSize = 0;
  double valueButtonSize = 0;
  int actionIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (actionPointPageVM.selector.items.isEmpty) {
      actionPointPageVM.selector
          .newSelection(widget.dsix.getCurrentPlayer().actions.length);
    }
    if (widget.dsix.getCurrentPlayer().actionPoints < 1) {
      nextButtonSize = MediaQuery.of(context).size.width * 0.06;
    } else {
      nextButtonSize = 0;
    }
    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.1,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: GoBackButton(
              buttonColor: widget.dsix.getCurrentPlayer().secondaryColor,
            ),
          ),
          titleSpacing: 10,
          backgroundColor: widget.dsix.getCurrentPlayer().primaryColor,
          centerTitle: true,
          title: PageTitle(
            title: 'actions',
            color: widget.dsix.getCurrentPlayer().secondaryColor,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: AnimatedContainer(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 400),
                width: nextButtonSize,
                height: nextButtonSize,
                child: NextButton(
                  onTapAction: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TextInputDialog(
                          title: 'enter a name',
                          textController: actionPointPageVM.textController,
                          color: widget.dsix.getCurrentPlayer().primaryColor,
                          // confirm: () async {
                          //   actionPointPageVM.createPlayer(
                          //       context, widget.dsix);
                          // },
                          confirm: () {
                            actionPointPageVM.goToPlayerUI(
                                context, widget.dsix);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: new SafeArea(
          child: Column(
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
                                  actionPointPageVM.selectAction(
                                      widget.dsix.getCurrentPlayer(), index);

                                  valueButtonSize = 30;
                                  actionIndex = index;
                                });
                              },
                              child: SvgPicture.asset(
                                'assets/icon/action/${widget.dsix.getCurrentPlayer().actions[index].icon}.svg',
                                color: actionPointPageVM.selector.items[index]
                                    ? widget.dsix
                                        .getCurrentPlayer()
                                        .primaryColor
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
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: DescriptionTitle(
                                title: actionPointPageVM.selectedAction.name,
                                color:
                                    widget.dsix.getCurrentPlayer().primaryColor,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            actionPointPageVM.removePoints(
                                                widget.dsix.getCurrentPlayer(),
                                                actionIndex);
                                          });
                                        },
                                        child: AnimatedContainer(
                                          curve: Curves.easeInOutExpo,
                                          duration: Duration(milliseconds: 400),
                                          width: valueButtonSize,
                                          height: valueButtonSize,
                                          child: SvgPicture.asset(
                                            AppImages.remove,
                                            color: widget.dsix
                                                .getCurrentPlayer()
                                                .primaryColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            actionPointPageVM.addPoints(
                                                widget.dsix.getCurrentPlayer(),
                                                actionIndex);
                                          });
                                        },
                                        child: AnimatedContainer(
                                          curve: Curves.easeInOutExpo,
                                          duration: Duration(milliseconds: 400),
                                          width: valueButtonSize,
                                          height: valueButtonSize,
                                          child: SvgPicture.asset(
                                            AppImages.add,
                                            color: widget.dsix
                                                .getCurrentPlayer()
                                                .primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: SubTitle(
                          text:
                              'Points left: ${widget.dsix.getCurrentPlayer().actionPoints}',
                        ),
                      ),
                      (actionPointPageVM.selector.items.contains(true))
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Description(
                                  description: actionPointPageVM
                                      .selectedAction.description)),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          itemCount:
                              actionPointPageVM.selectedAction.option.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Button(
                                onTapAction: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DescriptionDialog(
                                        title: actionPointPageVM
                                            .selectedAction.option[index].name,
                                        description: actionPointPageVM
                                            .selectedAction
                                            .option[index]
                                            .description,
                                        color: widget.dsix
                                            .getCurrentPlayer()
                                            .primaryColor,
                                      );
                                    },
                                  );
                                },
                                buttonText: actionPointPageVM
                                    .selectedAction.option[index].name,
                                buttonColor:
                                    widget.dsix.getCurrentPlayer().primaryColor,
                                buttonIcon: 'help',
                                buttonTextColor: AppColors.white01,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

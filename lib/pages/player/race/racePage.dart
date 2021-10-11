import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/dialogs/descriptionDialog.dart';
import 'package:dsixv02app/widgets/descriptionTitle.dart';
import 'package:dsixv02app/widgets/buttons/goBackButton.dart';
import 'package:dsixv02app/widgets/buttons/nextButton.dart';
import 'package:dsixv02app/widgets/pageTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'racePageVM.dart';

class RacePage extends StatefulWidget {
  static const String routeName = "/racePage";

  final Dsix dsix;

  const RacePage({Key key, this.dsix}) : super(key: key);

  @override
  _RacePageState createState() => new _RacePageState();
}

class _RacePageState extends State<RacePage> {
  RacePageVM racePageVM = RacePageVM();
  double nextButtonSize = 0;

  @override
  Widget build(BuildContext context) {
    if (racePageVM.selector.items.isEmpty) {
      racePageVM.selector.newSelection(racePageVM.availableRaces.races.length);
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
            title: 'race and gender',
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
                    racePageVM.goToBackgroundPage(context, widget.dsix);
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
                  child: GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              racePageVM.chooseRace(
                                  widget.dsix.getCurrentPlayer(), index);
                              nextButtonSize =
                                  MediaQuery.of(context).size.width * 0.06;
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/icon/character/${racePageVM.availableRaces.races[index].icon}.svg',
                            color: racePageVM.selector.items[index]
                                ? widget.dsix.getCurrentPlayer().primaryColor
                                : AppColors.white01,
                          ),
                        ),
                      );
                    }),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            DescriptionTitle(
                              title: racePageVM.selectedRace.name,
                              color:
                                  widget.dsix.getCurrentPlayer().primaryColor,
                            ),
                            (racePageVM.selectedRace.sex == null)
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 5),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            racePageVM.chooseSex(
                                                widget.dsix.getCurrentPlayer());
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icon/ui/${widget.dsix.getCurrentPlayer().race.sex}.svg',
                                          color: widget.dsix
                                              .getCurrentPlayer()
                                              .primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Description(
                              description:
                                  racePageVM.selectedRace.description)),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          itemCount: racePageVM.selectedRace.bonus.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Button(
                                onTapAction: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DescriptionDialog(
                                        title: racePageVM
                                            .selectedRace.bonus[index].name,
                                        description: racePageVM.selectedRace
                                            .bonus[index].description,
                                        color: widget.dsix
                                            .getCurrentPlayer()
                                            .primaryColor,
                                      );
                                    },
                                  );
                                },
                                buttonText:
                                    racePageVM.selectedRace.bonus[index].name,
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

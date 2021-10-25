import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/pages/gm/character/characterPage.dart';
import 'package:dsixv02app/pages/gm/map/gmMapPage.dart';
import 'package:dsixv02app/pages/gm/story/storyPage.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/widgets/buttons/homeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gmUIVM.dart';

class GmUI extends StatefulWidget {
  const GmUI({@required this.dsix});

  final Dsix dsix;

  @override
  _GmUIState createState() => _GmUIState();
}

class _GmUIState extends State<GmUI> {
  GmUIVM _gmUIVM = GmUIVM();

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.1,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: HomeButton(
            dsix: widget.dsix,
            buttonColor: widget.dsix.gm.tertiaryColor,
          ),
        ),
        backgroundColor: widget.dsix.gm.primaryColor,
        actions: <Widget>[],
      ),
      body: new SafeArea(
        child: PageView(
          controller: _gmUIVM.pageController,
          physics: (_gmUIVM.pageIndex == 1 ||
                  widget.dsix.gm.quest.questStart == false)
              ? NeverScrollableScrollPhysics()
              : ScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              if (widget.dsix.gm.quest.questStart && _gmUIVM.pageIndex != 1) {
                _gmUIVM.changePage(index);
              }
            });
          },
          children: <Widget>[
            StoryPage(
              dsix: this.widget.dsix,
              refresh: refresh,
              controller: _gmUIVM,
              // alert: displayAlert,
            ),
            GmMapPage(
              dsix: this.widget.dsix,
              // refresh: this.widget.refresh,
              // alert: displayAlert,
            ),
            CharacterPage(
              dsix: this.widget.dsix,
              // refresh: this.widget.refresh,
              // alert: displayAlert,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            if (widget.dsix.gm.quest.questStart) {
              _gmUIVM.changePage(index);
            }
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _gmUIVM.pageIndex,
        backgroundColor: widget.dsix.gm.primaryColor,
        items: [
          BottomNavigationBarItem(
            label: 'story',
            activeIcon: SvgPicture.asset(
              AppImages.story,
              color: widget.dsix.gm.secondaryColor,
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            icon: SvgPicture.asset(
              AppImages.story,
              color: widget.dsix.gm.tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.07,
            ),
          ),
          BottomNavigationBarItem(
            label: 'map',
            activeIcon: SvgPicture.asset(
              AppImages.map,
              color: (widget.dsix.gm.quest.questStart == false)
                  ? widget.dsix.gm.primaryColor
                  : widget.dsix.gm.secondaryColor,
              width: MediaQuery.of(context).size.width * 0.075,
            ),
            icon: SvgPicture.asset(
              AppImages.map,
              color: (widget.dsix.gm.quest.questStart == false)
                  ? widget.dsix.gm.primaryColor
                  : widget.dsix.gm.tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.075,
            ),
          ),
          BottomNavigationBarItem(
            label: 'character',
            activeIcon: SvgPicture.asset(
              AppImages.character,
              color: (widget.dsix.gm.quest.questStart == false)
                  ? widget.dsix.gm.primaryColor
                  : widget.dsix.gm.secondaryColor,
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            icon: SvgPicture.asset(
              AppImages.character,
              color: (widget.dsix.gm.quest.questStart == false)
                  ? widget.dsix.gm.primaryColor
                  : widget.dsix.gm.tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.07,
            ),
          ),
        ],
      ),
    );
  }
}

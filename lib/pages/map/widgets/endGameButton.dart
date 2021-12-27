import 'package:dsixv02app/pages/battleRoyaleSettings/battleRoyaleSettingsPage.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class EndGameButton extends StatefulWidget {
  final bool? isDead;

  const EndGameButton({
    @required this.isDead,
  });

  @override
  State<EndGameButton> createState() => _EndGameButtonState();
}

class _EndGameButtonState extends State<EndGameButton> {
  Artboard? _artboard;
  Color? strokeColor;
  String? buttonText;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);
    setState(() {
      _artboard = file.mainArtboard;
      _playReflectionAnimation();
    });
  }

  _playReflectionAnimation() {
    _artboard!.addController(SimpleAnimation('reflection'));
  }

  _playOnTapAnimation() {
    _artboard!.addController(OneShotAnimation(
      'onTap',
    ));
  }

  @override
  Widget build(context) {
    if (widget.isDead!) {
      strokeColor = AppColors.youLost;
      buttonText = 'you lost';
    } else {
      strokeColor = AppColors.youWin;
      buttonText = 'you win';
    }

    return GestureDetector(
      onTap: () {
        _playOnTapAnimation();
        Route newRoute = PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BattleRoyaleSettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-1.0, 0.0);
            var end = Offset(0.0, 0.0);
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

        Navigator.of(context).pushReplacement(newRoute);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: strokeColor!,
            width: 2.5,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            (_artboard != null)
                ? Rive(
                    artboard: _artboard!,
                    fit: BoxFit.fill,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Center(
                child: Text('${this.buttonText}'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontFamily: 'Calibri',
                      color: strokeColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

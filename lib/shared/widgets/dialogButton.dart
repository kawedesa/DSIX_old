import 'package:dsixv02app/models/player/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../app_Colors.dart';
import 'uiColor.dart';

// ignore: must_be_immutable
class DialogButton extends StatefulWidget {
  String? buttonText;

  Function()? onTapAction;
  DialogButton(
      {Key? key, @required this.buttonText, @required this.onTapAction})
      : super(key: key);

  @override
  State<DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
  UIColor _uiColor = UIColor();
  Artboard? _artboard;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);
    _artboard = file.mainArtboard;
    _playReflectionAnimation();
  }

  _playReflectionAnimation() {
    _artboard?.addController(SimpleAnimation('reflection', autoplay: true));
  }

  _playOnTapAnimation() {
    _artboard?.addController(OneShotAnimation(
      'onTap',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return GestureDetector(
      onTap: () {
        widget.onTapAction!();
        _playOnTapAnimation();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
            width: 1,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Center(
                child: Text(widget.buttonText!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontFamily: 'Calibri',
                      color: _uiColor.setUIColor(
                          user.selectedPlayer!.id, 'primary'),
                    )),
              ),
            ),
            (_artboard != null)
                ? Rive(
                    artboard: _artboard!,
                    fit: BoxFit.fill,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

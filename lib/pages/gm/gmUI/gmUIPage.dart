import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/pages/gm/gmUI/gmUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GmUIPage extends StatefulWidget {
  final Dsix dsix;

  const GmUIPage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/gmUIPage";

  @override
  _GmUIPageState createState() => new _GmUIPageState();
}

class _GmUIPageState extends State<GmUIPage> {
  // SnackBar displayAlert(String description) {
  //   SnackBar newAlert = new SnackBar(
  //     backgroundColor:
  //         widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
  //     content: Container(
  //       height: MediaQuery.of(context).size.height * 0.05,
  //       child: Text(
  //         description,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           height: 1.25,
  //           fontSize: 22,
  //           fontFamily: 'Calibri',
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  //   return newAlert;
  // }

  Widget build(BuildContext context) {
    return GmUI(dsix: widget.dsix);
  }
}

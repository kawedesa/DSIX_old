import 'package:flutter/material.dart';
import 'package:dsixv02app/pages/homePage.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticatePage.dart';

import 'package:dsixv02app/models/dsixUser.dart';

class WrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DsixUser>(context);

    // return hope or authenticate widget
    if (user == null) {
      return AuthenticatePage();
    } else {
      return HomePage();
    }
  }
}

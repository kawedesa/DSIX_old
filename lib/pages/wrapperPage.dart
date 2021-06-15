import 'package:flutter/material.dart';
import 'package:dsixv02app/pages/homePage.dart';
import 'package:provider/provider.dart';
import 'authenticatePage.dart';

import 'package:dsixv02app/models/dsix/dsixUser.dart';

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

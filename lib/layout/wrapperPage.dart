import 'package:flutter/material.dart';
import 'package:dsixv02app/pages/homePage.dart';
import 'authenticate/authenticatePage.dart';
import 'authenticate/signInPage.dart';

class WrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return hope or authenticate widget
    return SignInPage();
  }
}

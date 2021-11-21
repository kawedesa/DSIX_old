import 'package:flutter/material.dart';

class PlayerUIVM {
  PageController pageController = PageController(initialPage: 1);

  int selectedPage = 1;

  changePage(int index) {
    this.selectedPage = index;
    this.pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.ease);
  }
}

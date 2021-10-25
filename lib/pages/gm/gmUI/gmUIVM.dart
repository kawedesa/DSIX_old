import 'package:flutter/material.dart';

class GmUIVM {
  PageController pageController = PageController(initialPage: 0);

  int pageIndex = 0;

  changePage(int index) {
    this.pageIndex = index;
    this.pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  PageController? controller;

  onTap(int index) {
    selectedIndex = index;
    controller!.animateToPage(
      selectedIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    update();
  }

  onPageChange(int index) {
    selectedIndex = index;
    update();
  }
}

import 'package:flutter/cupertino.dart';

import '../screen/home/home_screen.dart';

class MainProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

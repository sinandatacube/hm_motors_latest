import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  bool brandsViewAll = false;
  int budgetCarsIndex = 0;
  init() {
    brandsViewAll = false;
    budgetCarsIndex = 0;
    notifyListeners();
  }

  updateBrandsViewAll() {
    brandsViewAll = !brandsViewAll;
    notifyListeners();
  }

  updatebudgetCarsIndex(int i) {
    budgetCarsIndex = i;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

class VehicleDetailsProvider extends ChangeNotifier {
  double index = 0;

  init() {
    index = 0;
    notifyListeners();
  }

  changeIndex(double ind) {
    index = ind;
    notifyListeners();
  }
}

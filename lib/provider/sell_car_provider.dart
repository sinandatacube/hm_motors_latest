import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class SellCarProvider extends ChangeNotifier {
  List<XFile> images = [];

  init() {
    images = [];
    notifyListeners();
  }

  getImages(List<XFile> im) {
    images = im;
    notifyListeners();
  }
}

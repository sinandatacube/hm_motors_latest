import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';

import '../global_functions.dart';

class WishListController extends ChangeNotifier {
  deleteFromWish(String wishId, BuildContext context) async {
    lodingDialog(context);
    var res = await ApiController().deleteFromWish(wishId);
    return res;
  }

  addToWish(String productId) async {
    var res = await ApiController().addToWish(productId);
    return res;
  }
}

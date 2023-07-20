import 'dart:developer';

import 'package:flutter/material.dart';

import '../../controller/api_controller.dart';
import '../../controller/wishlist_controller.dart';
import '../../global_functions.dart';
import '../../global_variables.dart';

class FavouriteButton extends StatefulWidget {
  bool isFav;
  String purchaseId;
  String wishId;
  FavouriteButton(
      {super.key,
      required this.isFav,
      required this.purchaseId,
      required this.wishId});

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: isSkip
            ? () => buildloginDialog(context)
            : () async {
                if (!widget.isFav) {
                  var res =
                      await WishListController().addToWish(widget.purchaseId);
                  log(res.toString(), name: "ress");

                  if (res['status'] == "Success") {
                    widget.isFav = true;
                    setState(() {});
                  }
                } else {
                  var res = await ApiController().deleteFromWish(
                    widget.wishId,
                  );
                  log(res.toString(), name: "ress");
                  if (res['status'] == "deleted") {
                    widget.isFav = false;
                    setState(() {});
                  }
                }
              },
        icon: widget.isFav
            ? Icon(
                Icons.favorite,
                size: 35,
                color: Colors.red.shade700,
              )
            : const Icon(
                Icons.favorite_outline,
                size: 35,
                color: Colors.black87,
              ),
      ),
    );
  }
}

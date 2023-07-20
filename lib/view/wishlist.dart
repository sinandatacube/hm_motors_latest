import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/controller/wishlist_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/model/wishlist_model.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';
import 'package:hm_motors/view/vehicle_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/vehicle_details_controller.dart';
import '../url.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late List wishlistItems;

  getwishlist() async {
    wishlistItems = await VehicleDetailsController().getWishlistItems();
    return wishlistItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          "Wishlist",
          style: TextStyle(fontFamily: "Rubik"),
        )),
      ),
      body: isSkip
          ? loginBuild(
              height,
              width,
            )
          : FutureBuilder(
              future: ApiController().getFromWishList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  wishlistItems = snapshot.data;
                  log(wishlistItems.toString(), name: "wishlist view");
                  return wishlistItems.isEmpty
                      ? const Center(
                          child: Text(
                            "Wishlist is Empty",
                            style: TextStyle(
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        )
                      : FutureBuilder(
                          future: ApiController().getFromWishList(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == "No cars found") {
                                return const Center(
                                  child: Text(
                                    "Wishlist is Empty",
                                    style: TextStyle(
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                );
                              }
                              log(snapshot.data.toString());

                              MainWishListModel data =
                                  MainWishListModel.fromJson(snapshot.data);

                              return _buildBody(context, data);
                            } else if (snapshot.hasError) {
                              var error = snapshot.error;
                              if (error == "Socket error") {
                                return const NoNetwork();
                              } else {
                                return const ErrorPage();
                              }
                            } else {
                              return const Scaffold(
                                  body: Center(
                                      child: CircularProgressIndicator()));
                              // listShimmmerLoading(5, context));
                            }
                          });
                } else {
                  return loadingAnimation();
                  // return
                  //  listShimmmerLoading(5, context);
                }
              }),
    );
  }

  Widget _buildBody(BuildContext context, MainWishListModel data) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        itemCount: data.cars.length,
        itemBuilder: (context, index) {
          var current = data.cars[index];
          String price = MoneyFormat().moneyFormat(current.price);
          return InkWell(
            onTap: current.status == "0"
                ? null
                : () => navigate(
                    VehicleDetails(
                        purchaseId: current.id, thumbImage: current.image),
                    false),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                // height: height * 0.17,
                height: width > 600 ? 200 : 140,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.45,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          child: CachedNetworkImage(
                            memCacheWidth: 500,
                            imageUrl: budgetImagePath + current.image,
                            errorWidget: (context, url, error) =>
                                Image.asset(errorImageUrl),
                            placeholder: (context, url) =>
                                Image.asset(placeholderImageUrl),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            // width: width * 0.5,
                            padding: EdgeInsets.only(
                                left: width * 0.03, top: height * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${current.brand} ${current.model}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Rubik"),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  current.year,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: "Rubik"),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${current.kms}kms",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: "Rubik"),
                                ),
                                // Text(current["color"]),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  price,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Rubik"),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                current.status != "0"
                                    ? const SizedBox.shrink()
                                    : Text(
                                        "Sold out!",
                                        style: TextStyle(
                                            color: Colors.red.shade800,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Rubik"),
                                      ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 5,
                            child: SizedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white),
                                onPressed: () async {
                                  // var sp =
                                  //     await SharedPreferences.getInstance();
                                  // List<String> wishItems =
                                  //     sp.getStringList("fav") ?? [];
                                  // wishItems.remove(current.id);
                                  // sp.setStringList("fav", wishItems);
                                  // setState(() {});

                                  var res = await WishListController()
                                      .deleteFromWish(current.wishId, context);
                                  log(res.toString(), name: "red");
                                  if (res['status'] == "deleted") {
                                    navigatorKey.currentState?.pop();
                                    setState(() {});
                                  } else {
                                    navigatorKey.currentState?.pop();
                                    Fluttertoast.showToast(
                                        msg: "Something went wrong");
                                  }
                                },
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    // decoration:
                                    // BoxDecoration(shape: BoxShape.circle),
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: Colors.red.shade700,
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

          // Card(
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //   child: Container(
          //     height: height * 0.18,
          //     decoration: BoxDecoration(
          //         border: Border.all(), borderRadius: BorderRadius.circular(5)),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           width: width * 0.5,
          //           padding:
          //               EdgeInsets.only(left: width * 0.03, top: height * 0.01),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 current["name"],
          //                 style: const TextStyle(
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 16,
          //                     fontFamily: "Rubik"),
          //               ),
          //               const SizedBox(
          //                 height: 4,
          //               ),
          //               Text(
          //                 current["year"],
          //                 style: TextStyle(
          //                     color: Colors.grey.shade600, fontFamily: "Rubik"),
          //               ),
          //               const SizedBox(
          //                 height: 4,
          //               ),
          //               Text(
          //                 current["mileage"] + "kms",
          //                 style: TextStyle(
          //                     color: Colors.grey.shade600, fontFamily: "Rubik"),
          //               ),
          //               // Text(current["color"]),
          //               const SizedBox(
          //                 height: 4,
          //               ),
          //               Text(
          //                 current["price"],
          //                 style: const TextStyle(
          //                     fontWeight: FontWeight.w600, fontFamily: "Rubik"),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Stack(
          //           children: [
          //             SizedBox(
          //               width: width * 0.4,
          //               child: ClipRRect(
          //                   borderRadius: const BorderRadius.only(
          //                       topRight: Radius.circular(5),
          //                       bottomRight: Radius.circular(5)),
          //                   child: Image.asset(
          //                     current["image"],
          //                     fit: BoxFit.cover,
          //                   )),
          //             ),
          //             Positioned(
          //               right: 0,
          //               top: 0,
          //               child: SizedBox(
          //                 child: ElevatedButton(
          //                   style: ElevatedButton.styleFrom(
          //                       elevation: 5,
          //                       shape: const CircleBorder(),
          //                       backgroundColor: Colors.white),
          //                   onPressed: () {},
          //                   child: SizedBox(
          //                       height: 30,
          //                       width: 30,
          //                       // decoration:
          //                       // BoxDecoration(shape: BoxShape.circle),
          //                       child: Center(
          //                         child: Icon(
          //                           Icons.favorite,
          //                           size: 25,
          //                           color: mainColor,
          //                         ),
          //                       )),
          //                 ),
          //               ),

          //               // Container(
          //               //   height: 30,
          //               //   width: 40,
          //               //   alignment: Alignment.center,
          //               //   // color: Colors.white,
          //               //   child: ElevatedButton(
          //               //       style: ElevatedButton.styleFrom(
          //               //           shape: CircleBorder(),
          //               //           backgroundColor: Colors.white,
          //               //           foregroundColor: mainColor),
          //               //       onPressed: () {},
          //               //       child: const Icon(
          //               //         Icons.favorite,
          //               //         // size: 25,
          //               //       )),
          //               // ))
          //             )
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // );
        });
  }
}

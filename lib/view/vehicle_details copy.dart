import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/controller/vehicle_details_controller.dart';
import 'package:hm_motors/controller/wishlist_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/model/vehicle_details_model.dart';
import 'package:hm_motors/model/wishlist_model.dart';
import 'package:hm_motors/provider/car_details_provider.dart';
import 'package:hm_motors/url.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';
import 'package:hm_motors/view/utitlities/photo_view.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

import '../global_variables.dart';

class VehicleDetails extends StatefulWidget {
  final String purchaseId;
  final String? thumbImage;
  const VehicleDetails({Key? key, required this.purchaseId, this.thumbImage})
      : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  final PageController _controller = PageController(initialPage: 0);
  bool isInterested = false;
  bool isFav = false;
  String wishId = "";
  late List wishlistItems;
  getwishlist() async {
    wishlistItems = await VehicleDetailsController().getWishlistItems();
    return wishlistItems;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getwishlist();
  // }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    log(isFav.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleDetailsProvider>().init();
    });

    //get wishlist ids
    return FutureBuilder(
        future: ApiController().getFromWishList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            wishlistItems = snapshot.data;
            MainWishListModel wish = MainWishListModel.fromJson(wishlistItems);
            for (var element in wish.cars) {
              if (element.id == widget.purchaseId && element.status == "1") {
                isFav = true;
                wishId = element.wishId;
              }
            }
            // log(wishlistItems.toString(), name: "wishItems");
            //get vehicle details
            return FutureBuilder(
                future: ApiController().fetchvehicleDetails(widget.purchaseId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List images2 = snapshot.data["fullImages"] ?? [];
                    images2.add({"Car_Image": widget.thumbImage});

                    VehicleDetailsModel data =
                        VehicleDetailsModel.fromJson(snapshot.data["result"]);
                    // if (wishlistItems.contains(data.id)) {
                    //   isFav = true;
                    // }

                    return Scaffold(
                      backgroundColor: Colors.white,
                      bottomNavigationBar: _buildBottomBar(context, data, wish),
                      body: SafeArea(child: _buildBody(context, data, images2)),
                    );
                  } else if (snapshot.hasError) {
                    var error = snapshot.error;
                    if (error == "Socket error") {
                      return const NoNetwork();
                    } else {
                      return const ErrorPage();
                    }
                  } else {
                    return Scaffold(body: loadingAnimation());
                  }
                });
          } else {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ));
          }
        });
  }

  Widget _buildBody(
      BuildContext context, VehicleDetailsModel data, List images2) {
    // images2.isNotEmpty ? images2.add(widget.thumbImage) : null;
    String price = MoneyFormat().moneyFormat(data.price);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: width > 600 ? height * 0.35 : height * 0.3,
                width: width,
                child: images2.isEmpty
                    ? Image.asset(errorImageUrl)
                    : PageView.builder(
                        onPageChanged: (value) {
                          context
                              .read<VehicleDetailsProvider>()
                              .changeIndex(value.toDouble());
                        },
                        controller: _controller,
                        itemCount: images2.length,
                        itemBuilder: (context, index) {
                          // currentIndexPage = index.toDouble();
                          return InkWell(
                            onTap: () => navigatorKey.currentState!
                                .push(MaterialPageRoute(
                                    builder: (_) => Photoview(
                                          images: images2,
                                          index: index,
                                        ))),
                            child: SizedBox(
                                // height: height * 0.45,
                                width: width,
                                child: AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: CachedNetworkImage(
                                      memCacheWidth: 100,
                                      imageUrl: budgetImagePath +
                                          images2[index]["Car_Image"],
                                      errorWidget: (context, url, error) =>
                                          Image.asset(errorImageUrl),
                                      placeholder: (context, url) =>
                                          Image.asset(placeholderImageUrl),
                                      fit: BoxFit.cover,
                                    )
                                    // CachedNetworkImage(
                                    //   imageUrl: images[index],
                                    //   memCacheWidth: 1000,
                                    // ),
                                    )),
                          );
                        },
                      ),
              ),
              Positioned(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    onPressed: () => navigatorKey.currentState!.pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
              images2.isEmpty
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: 5,
                      child: Consumer(builder:
                          (context, VehicleDetailsProvider value, child) {
                        return PageViewDotIndicator(
                          currentItem: value.index.toInt(),
                          count: images2.length,
                          unselectedColor: Colors.white,
                          selectedColor: Colors.amber.shade800,
                          duration: const Duration(milliseconds: 200),
                        );
                      }),
                    ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.brand} ${data.model}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Rubik"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Text(
                  "ASKING PRICE",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Rubik"),
                ),
                Text(
                  price,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Rubik"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   height: 100,
                    //   width: width / 4.5,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.shade200,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Column(
                    //     children: const [Text("Kms driven"), Text("6999 kms")],
                    //   ),
                    // ),
                    // Container(
                    //   height: 100,
                    //   width: width / 4.5,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.shade200,
                    //       borderRadius: BorderRadius.circular(10)),
                    // ),
                    // Container(
                    //   height: 100,
                    //   width: width / 4.5,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.shade200,
                    //       borderRadius: BorderRadius.circular(10)),
                    // ),
                    // Container(
                    //   height: 100,
                    //   width: width / 4.5,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.shade200,
                    //       borderRadius: BorderRadius.circular(10)),
                    // ),
                    Container(
                      height: 40,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "${data.kms} KMS",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: "Rubik"),
                      ),
                    ),
                    const Text(
                      "-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(
                      height: 40,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "${data.owners} OWNER",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: "Rubik"),
                      ),
                    ),
                    const Text(
                      "-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),

                    Container(
                      height: 40,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        data.transmission.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: "Rubik"),
                      ),
                    ),
                    const Text(
                      "-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),

                    Container(
                      height: 40,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        data.fuel.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: "Rubik"),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                const Text(
                  "DETAILS",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "Rubik"),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                detailsWidget("YEAR OF MANUFACTURE", data.year.toUpperCase(),
                    "assets/registration.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "HM ASSURED", "YES", "assets/assured.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget("BRAND", data.brand.toUpperCase(),
                    "assets/make.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "MODEL", data.model, "assets/model.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget("OWNERSHIP", data.owners.toUpperCase(),
                    "assets/user.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget("RUN KMS", data.kms.toUpperCase(),
                    "assets/odometer.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "INSURANCE VALID UPTO",
                    data.insuranceValid.toUpperCase(),
                    "assets/insurance.png",
                    height,
                    width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "TYRE CONDITION",
                    data.tyreCondition.toUpperCase(),
                    "assets/wheel.png",
                    height,
                    width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "ACCIDENT OR REPLACEMENT",
                    data.accident.toUpperCase(),
                    "assets/accident.png",
                    height,
                    width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "REGISTRATION",
                    data.regNumber.toUpperCase().substring(0, 4),
                    "assets/machine.png",
                    height,
                    width),
                const Divider(
                  thickness: 1.5,
                ),
                detailsWidget(
                    "CONDITION", "GOOD", "assets/health.png", height, width),
                const Divider(
                  thickness: 1.5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar(
      BuildContext context, VehicleDetailsModel data, MainWishListModel wish) {
    return Container(
      width: width,
      height: 60,
      color: Colors.transparent,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: isSkip
                  ? () => buildloginDialog(context)
                  : isInterested
                      ? null
                      : () async {
                          var result = await ApiController()
                              .sentInterest(data.id, userNumber);
                          if (result == "success") {
                            isInterested = true;
                            setState(() {});
                          }
                          _buildInterestDialog(context);
                        },
              child: Text(
                isInterested ? "INTERESTED" : "SHOW INTEREST",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Card(
            elevation: 5,
            color: Colors.white,
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: isSkip
                  ? () => buildloginDialog(context)
                  : () async {
                      if (!isFav) {
                        var res = await WishListController()
                            .addToWish(widget.purchaseId);
                        if (res == "Success") {
                          isFav = true;
                          setState(() {});
                        }
                      } else {
                        var res = await ApiController().deleteFromWish(
                          wishId,
                        );
                        log(res.toString(), name: "ress");
                        if (res == "deleted") {
                          isFav = false;
                          setState(() {});
                        }
                      }
                    },
              icon: isFav
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
          )
        ],
      ),
    );
  }

  Widget detailsWidget(String title, String content, String imgUrl,
      double height, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.01),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Image.asset(
              imgUrl,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontFamily: "Rubik"),
            ),
          ],
        ),
        Text(
          content,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontFamily: "Rubik"),
        ),
      ]),
    );
  }

  _buildInterestDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Thanks for showing interest.Our sales executive will call you back.',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.grey.shade700),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontFamily: "Rubik"),
                    )),
                // TextButton(
                //     onPressed: () {
                //       // willLeave = true;
                //       // Navigator.of(context).pop();
                //       SystemNavigator.pop();
                //     },
                //     child: Text('yes',
                //         style: Theme.of(context)
                //             .textTheme
                //             .titleMedium!
                //             .copyWith(
                //                 fontWeight: FontWeight.w600,
                //                 color: Colors.black)))
              ],
            ));
  }
}

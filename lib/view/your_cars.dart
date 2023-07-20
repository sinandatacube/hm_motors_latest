import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/model/your_cars_model.dart';
import 'package:hm_motors/url.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';

import '../global_variables.dart';

class YourCars extends StatefulWidget {
  const YourCars({super.key});

  @override
  State<YourCars> createState() => _YourCarsState();
}

class _YourCarsState extends State<YourCars> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiController().getUserAds(userNumber),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data;

            MainYourCarsModel data = MainYourCarsModel.fromJson(result);

            log(data.toString());
            return Scaffold(
              appBar: buildAppBar(),
              body: buildBody(data),
            );
          } else if (snapshot.hasError) {
            if (snapshot.error == "Network error") {
              return const NoNetwork();
            } else {
              return const ErrorPage();
            }
          } else {
            return Scaffold(body: loadingAnimation());
          }
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("My cars"),
    );
  }

  Widget buildBody(MainYourCarsModel data) {
    return data.cars.isEmpty
        ? const Center(
            child: Text(
              "No Ads Posted",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: "Rubik"),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            itemCount: data.cars.length,
            itemBuilder: (context, index) {
              var current = data.cars[index];
              String price = MoneyFormat().moneyFormat(current.price);
              // return Container(

              //   child: ListTile(
              //     leading: CachedNetworkImage(
              //       imageUrl: yourCarsImagePath + current.imgUrl,
              //       memCacheWidth: 300,
              //       errorWidget: (context, url, error) => Image.asset(errorImageUrl),
              //       placeholder: (context, url) => Image.asset(placeholderImageUrl),
              //       fit: BoxFit.cover,
              //     ),
              //     title: Text(
              //       current.brand + " " + current.model + " " + current.varient,
              //       overflow: TextOverflow.ellipsis,
              //       style: const TextStyle(
              //           fontFamily: "Rubik", fontWeight: FontWeight.w400),
              //     ),
              //   ),
              // );

              return Card(
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
                              memCacheWidth: 300,
                              imageUrl: yourCarsImagePath + current.imgUrl,
                              errorWidget: (context, url, error) =>
                                  Image.asset(errorImageUrl),
                              placeholder: (context, url) =>
                                  Image.asset(placeholderImageUrl),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                        child: Container(
                          // width: width * 0.5,
                          padding: EdgeInsets.only(
                              left: width * 0.03, top: height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      current.brand +
                                          " " +
                                          current.model +
                                          " " +
                                          current.varient,
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
                                      "${current.kms} kms",
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
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                child: IconButton(
                                  onPressed: () async {
                                    helpDialog(context);
                                    var result = await ApiController()
                                        .deleteUserAds(
                                            current.imgUrl, current.userId);

                                    if (result == "deleted") {
                                      setState(() {});
                                      Future.delayed(
                                          const Duration(seconds: 1),
                                          () =>
                                              navigatorKey.currentState?.pop());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Unable to delete");
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
  }
}

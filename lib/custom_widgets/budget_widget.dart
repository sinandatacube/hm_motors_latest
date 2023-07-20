import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/model/homepage_model.dart';
import 'package:hm_motors/url.dart';

import '../view/utitlities/money_format.dart';
import '../view/vehicle_details.dart';
import '../view/view_all.dart';

class BudgetWidget extends StatelessWidget {
  final List<CarModel> items;

  const BudgetWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        items.isEmpty
            ? Expanded(
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  child: const Text(
                    "No vehicles avaialable",
                    style: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                shrinkWrap: true,
                itemCount: items.length >= 4 ? 4 : items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: width * 0.02,
                  mainAxisSpacing: height * 0.01,
                  crossAxisCount: 2,
                  // childAspectRatio: 1.1,
                  childAspectRatio: width > 600 ? 1.75 : 1,
                ),
                itemBuilder: (context, index) {
                  var current = items[index];
                  String price = MoneyFormat().moneyFormat(current.carprice);
                  return InkWell(
                    onTap: () => navigate(
                        VehicleDetails(
                            purchaseId: current.carPurchaseId,
                            thumbImage: current.imgUrl),
                        false),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                                // height: height * 0.165,
                                width: width,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(5)),
                                    child: CachedNetworkImage(
                                      memCacheWidth: 300,
                                      fit: BoxFit.fitWidth,
                                      imageUrl:
                                          budgetImagePath + current.imgUrl,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(errorImageUrl),
                                      placeholder: (context, url) =>
                                          Image.asset(placeholderImageUrl),
                                    ))),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "${current.carBrand} ${current.carName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text(
                                    price,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
        items.length > 4
            ? InkWell(
                onTap: () {
                  navigate(ViewAll(items: items), false);
                },
                child: Container(
                  width: 70,
                  height: 28,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      // Icon(
                      //   value.brandsViewAll
                      //       ? Icons.arrow_upward_rounded
                      //       : Icons.arrow_downward_rounded,
                      //   size: 20,
                      //   color: Colors.grey.shade500,
                      // )
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

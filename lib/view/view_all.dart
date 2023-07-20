import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/vehicle_details.dart';

import '../global_variables.dart';
import '../model/homepage_model.dart';
import '../url.dart';

class ViewAll extends StatelessWidget {
  final List<CarModel> items;

  const ViewAll({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var current = items[index];
          String price = MoneyFormat().moneyFormat(current.carprice);
          return InkWell(
            onTap: () {
              navigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (_) => VehicleDetails(
                        purchaseId: current.carPurchaseId,
                        thumbImage: current.imgUrl,
                      )));
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: width,
                height: width > 600 ? 200 : 140,
                // padding: EdgeInsets.only(left: width * 0.04),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.45,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(5)),
                          child: CachedNetworkImage(
                            imageUrl: budgetImagePath + current.imgUrl,
                            errorWidget: (context, url, error) =>
                                Image.asset(errorImageUrl),
                            placeholder: (context, url) =>
                                Image.asset(placeholderImageUrl),
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(current.carYear,
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${current.carBrand} ${current.carName}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${current.kms} kms",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Text(
                                  current.color,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            price,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

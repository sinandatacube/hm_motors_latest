import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/model/search_model.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';
import 'package:hm_motors/view/vehicle_details.dart';

import '../global_variables.dart';
import '../url.dart';

class CarList extends StatelessWidget {
  final String brandId;
  final String brandName;
  const CarList({super.key, required this.brandId, required this.brandName});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          brandName,
          style: const TextStyle(fontFamily: "Rubik", fontSize: 18),
        ),
      ),
      body: FutureBuilder(
          future: ApiController().brandWiseCars(brandId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (data == "No cars found") {
                return const Center(
                  child: Text(
                    "No Cars Available",
                    style: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                MainSearchModel data2 = MainSearchModel.fromJson(data);
                // print(data2);
                return _buildBody(context, height, width, data2);
              }
            } else if (snapshot.hasError) {
              var error = snapshot.error;
              if (error == "Socket error") {
                return const NoNetwork();
              } else {
                return const ErrorPage();
              }
            } else {
              return Scaffold(body: loadingAnimation()

                  //  Center(
                  //   child: CircularProgressIndicator(
                  //     strokeWidth: 2,
                  //   ),
                  // ),
                  );
            }
          }),
    );
  }

  Widget _buildBody(BuildContext context, double height, double width,
      MainSearchModel data2) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      shrinkWrap: true,
      itemCount: data2.cars.length,
      itemBuilder: (context, index) {
        var current = data2.cars[index];
        String price = MoneyFormat().moneyFormat(current.price);
        return InkWell(
          onTap: () {
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (_) => VehicleDetails(
                      purchaseId: current.id,
                      thumbImage: current.imgUrl,
                    )));
          },
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: width > 600 ? 200 : 140,
              padding: EdgeInsets.only(left: width * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(current.year,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${current.brand} ${current.model} ${current.varient}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
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
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 11),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                current.color,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 11),
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
                  SizedBox(
                    width: 7,
                  ),
                  SizedBox(
                    width: width * 0.45,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        child: CachedNetworkImage(
                          imageUrl: budgetImagePath + current.imgUrl,
                          errorWidget: (context, url, error) =>
                              Image.asset(errorImageUrl),
                          placeholder: (context, url) =>
                              Image.asset(placeholderImageUrl),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

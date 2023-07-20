import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/model/notification_model.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';
import 'package:hm_motors/view/vehicle_details.dart';
import 'package:intl/intl.dart';

import '../global_variables.dart';
import '../url.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder(
        future: ApiController().fetchNotifications(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            log(snapshot.data.toString(), name: "snaps");
            List<NotificationModel> notifications =
                notificationModelFromJson(snapshot.data);
            return Scaffold(
              appBar: appbar(),
              body: body(size, notifications),
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
  }

  AppBar appbar() {
    return AppBar(
      title: const Text("Notifications"),
    );
  }

  Widget body(Size size, List<NotificationModel> notifications) {
    return notifications.isEmpty
        ? Center(
            child: Text(
              "No new notifications",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          )
        : ListView.builder(
            itemCount: notifications.length > 15 ? 15 : notifications.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.015),
            itemBuilder: (context, index) {
              var current = notifications[index];
              String date = DateFormat('dd-MM-yyyy ').format(current.notifDate);
              return InkWell(
                onTap: () {
                  navigatorKey.currentState!.push(MaterialPageRoute(
                      builder: (_) => VehicleDetails(
                            purchaseId: current.adId,
                            thumbImage: current.image,
                          )));
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    width: size.width,
                    height: size.width > 600 ? 200 : 140,
                    // padding: EdgeInsets.only(left: width * 0.04),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.45,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(5)),
                              child: CachedNetworkImage(
                                imageUrl: notificationImagePath + current.image,
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.width > 600 ? 22 : 17,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(current.title,
                                    style: TextStyle(color: Colors.grey)),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  // "${current.carBrand} ${current.carName}",
                                  current.body,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: size.width * 0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // "${current.kms} kms",
                                        // current.notifDate.toString().split(' ')[0],
                                        date,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '\u{20B9} ' + current.sellingPrice,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
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

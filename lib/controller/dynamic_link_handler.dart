import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/view/vehicle_details.dart';

class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks() async {
    log("asdsfafsaf");
    log("**********************************************");
    dynamicLinks.onLink.listen((dynamicLinkData) {
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK
      // Ex: https://namnp.page.link/product/013232
      final String path = dynamicLinkData.link.path; // Get PATH
      // Ex: product/013232
      log(path.toString(), name: "dynamic link path");
      if (deepLink.isEmpty) return;
      handleDeepLink(path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
    // initUniLinks();
  }

  // Future<void> initUniLinks() async {
  //   try {
  //     final initialLink = await dynamicLinks.getInitialLink();
  //     if (initialLink == null) return;
  //     handleDeepLink(initialLink.link.path);
  //   } catch (e) {
  //     // Error
  //   }
  // }

  void handleDeepLink(String path) {
    String productId = path.split("--")[1];
    log("-----------------------------------------------");
    navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (_) => VehicleDetails(purchaseId: productId)));
  }
}

class DynamicLinkController {
  Future<String> createDynamicLink(String productId) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://hmmotors.page.link/vehicle--$productId"),
      uriPrefix: "https://hmmotors.page.link/",
      // uriPrefix: "https://hmmotor.in/",
      androidParameters: AndroidParameters(
        packageName: "com.datacubeinfo.hm_motors",
        minimumVersion: 0,
        fallbackUrl: Uri.parse("https://hmmotor.in/"
            // "https://play.google.com/store/search?q=hm+motors&c=apps",
            ),
      ),

      iosParameters: IOSParameters(
        bundleId: "com.datacubeinfo.hm.motors",
        appStoreId: "6444602277",
        minimumVersion: "0",
        fallbackUrl: Uri.parse(
            // "https://spencermobile.com/"
            "https://hmmotor.in/"
            // "https://apps.apple.com/us/app/hm-motors/id6444602277",
            ),
      ),
    );
    final Uri dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    log(dynamicLink.toString(), name: "long link");
    // final ShortDynamicLink shortUrl =
    //     await dynamicLinks.buildShortLink(dynamicLinkParams);
    // Uri url = shortUrl.shortUrl;
    // log(url.toString(), name: "link");
    return dynamicLink.toString();
  }
}

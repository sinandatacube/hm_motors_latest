import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/view/vehicle_details.dart';

class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // Future<void> initDynamicLinks() async {
  //   log("asdsfafsaf");
  //   log("**********************************************");
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     log(dynamicLinkData.link.toString(), name: "link");

  //     // Listen and retrieve dynamic links here
  //     final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK
  //     log(deepLink.toString(), name: "deep link");

  //     final String path = dynamicLinkData.link.toString(); // Get PATH

  //     if (deepLink.isEmpty) return;
  //     handleDeepLink(path);
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  //   // initUniLinks();
  // }

  // void handleDeepLink(String path) {
  //   String productId = path.split("--")[1];
  //   log("-----------------------------------------------");
  //   navigatorKey.currentState?.push(MaterialPageRoute(
  //       builder: (_) => VehicleDetails(purchaseId: productId)));
  // }

  handleDynamicLink() async {
    // Check if you received the link via `getInitialLink` first
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      log(deepLink.toString(), name: "0000000000");
      String productId = deepLink.toString().split("--")[1];
      log(deepLink.toString().split("--")[1], name: "00000000002");

      log("-----------------------------------------------");
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (_) => VehicleDetails(purchaseId: productId)));
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        // Set up the `onLink` event listener next as it may be received here
        if (pendingDynamicLinkData != null) {
          final Uri deepLink = pendingDynamicLinkData.link;
          log(deepLink.toString(), name: "d1111111111");
          String productId = deepLink.toString().split("--")[1];
          log("-----------------------------------------------");
          navigatorKey.currentState?.push(MaterialPageRoute(
              builder: (_) => VehicleDetails(purchaseId: productId)));
          return;
        }
      },
    );
    // FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    //   log(dynamicLinkData.toString(), name: "d222222222");
    //   String productId = dynamicLinkData.link.toString().split("--")[1];
    //   log("-----------------------------------------------");
    //   navigatorKey.currentState?.push(MaterialPageRoute(
    //       builder: (_) => VehicleDetails(purchaseId: productId)));
    //   return;
    // }).onError((error) {
    //   // Handle errors
    // });
  }
}

class DynamicLinkController {
//  Future<String>
  createDynamicLinkWithapi(String productId) async {
    String apiKey = 'AIzaSyCRnqkRmhMWQ60r0rzF61KY2a3Nt6sBVRc';
    Map params = {
      "dynamicLinkInfo": {
        "domainUriPrefix": "https://hmmotors.page.link",
        "link": "https://www.hmmotor.in/vehilce--$productId",
        "androidInfo": {
          "androidPackageName": "com.datacubeinfo.hm_motors",

          "androidFallbackLink":
              "https://play.google.com/store/search?q=hm+motors&c=apps",
          // "androidMinPackageVersionCode": string
        },
        "iosInfo": {
          "iosBundleId": "com.datacubeinfo.hm.motors",
          "iosFallbackLink":
              "https://apps.apple.com/us/app/hm-motors/id6444602277",
          // "iosCustomScheme": string,

          "iosAppStoreId": "64446022777"
        }
      }
    };
    var response = await http.post(
        Uri.parse(
            'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params));
    log(response.body.toString(), name: 'dynamic api');
    Map data = jsonDecode(response.body);
    return data['shortLink'];
  }

  Future<String> createDynamicLink(String productId) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final dynamicLinkParams = DynamicLinkParameters(
      // link: Uri.parse("https://hmmotors.page.link/vehicle--$productId"),
      // uriPrefix: "https://hmmotors.page.link/",
      link: Uri.parse("https://hmmotors.page.link/vehicle--$productId"),
      uriPrefix: "https://hmmotors.page.link/",
      // uriPrefix: "https://hmmotor.in/",
      androidParameters: AndroidParameters(
        packageName: "com.datacubeinfo.hm_motors",
        minimumVersion: 0,
        fallbackUrl: Uri.parse(
          // "https://hmmotor.in/"
          "https://play.google.com/store/search?q=hm+motors&c=apps",
        ),
      ),

      iosParameters: IOSParameters(
        bundleId: "com.datacubeinfo.hm.motors",
        appStoreId: "64446022777",
        minimumVersion: "1.0.1",
        fallbackUrl: Uri.parse(
          // "https://spencermobile.com/"
          // "https://hmmotor.in/id6444602277"
          "https://apps.apple.com/us/app/hm-motors/id64446022777",
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

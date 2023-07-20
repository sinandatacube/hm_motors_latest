import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hm_motors/model/homepage_model.dart';
import 'package:hm_motors/model/wishlist_model.dart';
import 'package:hm_motors/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ApiController {
  Future homepageCall() async {
    try {
      var response = await http.get(Uri.parse(baseUrl + homepageUrl));
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        // log(result.toString());
        MainHomePageModel result2 = MainHomePageModel.fromJson(result);
        MainWishListModel mostSearch =
            MainWishListModel.fromJson(result["most_search"]);
        // print(mostSearch);
        // log(result2.toString());
        // log(result2.offerwall.toString());

        var result3 = {
          "data": result2,
          "budget": result["budget"],
          "mostSearch": mostSearch
        };
        return result3;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  Future enterNumber(String number) async {
    try {
      Map params = {"cus_phone": number};

      var response =
          await http.post(Uri.parse(baseUrl + loginUrl), body: params);
      if (response.statusCode == 200) {
        // log(response.body.toString());
        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future register(String number, String name) async {
    try {
      Map params = {"cus_phone": number, "cus_name": name};

      var response = await http.post(Uri.parse(baseUrl + registrationUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);
      if (response.statusCode == 200) {
        // log(response.body.toString());

        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future brandWiseCars(
    String brandId,
  ) async {
    try {
      Map params = {
        "brandId": brandId,
      };

      var response = await http.post(Uri.parse(baseUrl + brandWiseCarsUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);
      if (response.statusCode == 200) {
        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        // log(response.body.toString());

        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future sentInterest(
    String id,
    String number,
  ) async {
    try {
      var sp = await SharedPreferences.getInstance();
      String cusId = sp.getString("cusId") ?? "";
      if (cusId != "") {
        Map params = {"adId": id, "mobileNumber": number, "user_id": cusId};

        var response = await http.post(Uri.parse(baseUrl + sentInterestUrl),
            // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
            body: params);
        if (response.statusCode == 200) {
          log(response.body.toString(), name: "resp");
          return await jsonDecode(response.body);

          //  jsondata['category'];
        } else {
          // log(response.body.toString());
          return Future.error("Network error");
        }
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future fetchvehicleDetails(
    String purchaseId,
  ) async {
    try {
      Map params = {
        "pId": purchaseId,
      };

      var response = await http.post(Uri.parse(baseUrl + vehicleDetailsUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/register_customers"),
          body: params);

      if (response.statusCode == 200) {
        // log(response.body.toString());

        return await jsonDecode(response.body);

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  // Future fetchWishlist(
  //   List purchaseIds,
  // ) async {
  //   try {
  //     Map params = {
  //       "pId": purchaseIds.toString(),
  //     };
  //     log(params.toString(), name: "wish_params");
  //     var response = await http.post(Uri.parse(baseUrl + wishlistUrl),
  //         // "https://www.hmmotors.datacubeglobal.com/API_Controller/CarsBy_Array_of_Pid"),
  //         body: params);
  //     // print(response.body);
  //     if (response.statusCode == 200) {
  //       var result = await jsonDecode(response.body);
  //       return result;

  //       //  jsondata['category'];
  //     } else {
  //       // log(response.body.toString());
  //       log(response.body.toString());

  //       return Future.error("Network error");
  //     }
  //   } on SocketException {
  //     return Future.error("Socket error");
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future fetchUserDetails(
    String mobile,
  ) async {
    try {
      Map params = {
        "mobileNumber": mobile,
      };
      var response = await http.post(Uri.parse(baseUrl + userDetailsUrl),
          // "https://www.hmmotors.datacubeglobal.com/API_Controller/CarsBy_Array_of_Pid"
          // ),
          body: params);
      // print(response.body);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        // List images=[];
        // for(int i=0;i<result["fullImages"].length;i++){
        //   images.add(result[i]["fullImages"]);
        // }
        // // List images=result["fullImages"];
        // var result2={"data"

        // }
        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        // log(response.body.toString());

        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future search(
    String keyword,
  ) async {
    try {
      Map params = {"keyword": keyword.trim()};

      var response =
          await http.post(Uri.parse(baseUrl + searchUrl), body: params);
      if (response.statusCode == 200) {
        // log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteUser(
    String mobileNumber,
  ) async {
    try {
      Map params = {"mobileNumber": mobileNumber};
      // log(mobileNumber);
      var response =
          await http.post(Uri.parse(baseUrl + deleteUserUrl), body: params);
      if (response.statusCode == 200) {
        // log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future submitSellCar(
      String registrationNumber,
      String brand,
      String model,
      String year,
      String owners,
      String kms,
      String insurance,
      String tyre,
      String vehicleCondition,
      List images,
      String mobile,
      String varient,
      String expectedPrice) async {
    try {
      Map params = {
        "Reg_number": registrationNumber,
        "brand": brand,
        "model": model,
        "regYear": year,
        "owner": owners,
        "kms": kms,
        "insurance": insurance,
        "tyre": tyre,
        "condition": vehicleCondition,
        "Images": jsonEncode(images),
        "mobile": mobile,
        "variant": varient,
        "car_price": expectedPrice
      };
      // log(expectedPrice);
      var response =
          await http.post(Uri.parse(baseUrl + sellCarUrl), body: params);
      if (response.statusCode == 200) {
        // log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getUserAds(
    String mobileNumber,
  ) async {
    try {
      Map params = {"mobileNumber": mobileNumber};
      // log(mobileNumber);
      var response =
          await http.post(Uri.parse(baseUrl + userAdsUrl), body: params);
      if (response.statusCode == 200) {
        // log(response.body.toString());
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        // log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  // /\/\/\/\/\/\/\/\/\/\/ get from wishlist

  Future getFromWishList() async {
    try {
      var sp = await SharedPreferences.getInstance();
      String? id = sp.getString('cusId');
      log(id.toString(), name: "id");

      if (id != null) {
        Map params = {
          "uid": id,
        };
        log(params.toString(), name: "wish_params");
        var response = await http.post(Uri.parse(
                // "https://hmmotor.in/API_Controller/get_from_wishlist"
                baseUrl + getFromWishlistUrl),
            // "https://www.hmmotors.datacubeglobal.com/API_Controller/CarsBy_Array_of_Pid"),
            body: params);

        if (response.statusCode == 200) {
          log(response.body.toString(), name: "wish_params");
          var result = await jsonDecode(response.body);
          return result;

          //  jsondata['category'];
        } else {
          // log(response.body.toString());
          // log(response.body.toString());

          return Future.error("Network error");
        }
      } else {
        return [];
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      log(e.toString(), name: "er");
      return Future.error(e);
    }
  }
// /\/\/\/\/\\/\/\/\/\\/\/\ delete from wishlist

  Future deleteFromWish(
    String wishId,
  ) async {
    try {
      Map params = {"wishid": wishId};
      log(wishId);
      var response =
          await http.post(Uri.parse(baseUrl + deleteFromWishUrl), body: params);
      log(response.statusCode.toString(), name: "statusCode");
      log(response.body.toString(), name: "resp");

      if (response.statusCode == 200) {
        var result = await json.decode(response.body);
        log(result.toString(), name: "resp");

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }
// /\/\/\/\/\\/\/\/\/\\/\/\ add to wishlist

  Future addToWish(
    String productId,
  ) async {
    try {
      var sp = await SharedPreferences.getInstance();
      String cusId = sp.getString('cusId') ?? "";
      if (cusId != "") {
        Map params = {"user_id": cusId, 'ad_id': productId};

        var response =
            await http.post(Uri.parse(baseUrl + addToWishUrl), body: params);
        log(response.body.toString(), name: "resp");
        log(response.statusCode.toString(), name: "statusCode");

        if (response.statusCode == 200) {
          var result = await jsonDecode(response.body);
          log(result.toString(), name: "resp");

          return result;

          //  jsondata['category'];
        } else {
          log(response.body.toString());
          return Future.error("Network error");
        }
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

// /\/\/\/\/\/\/\/\/\/\/\  delete From UserAds
  Future deleteUserAds(String imageName, String adId) async {
    try {
      Map params = {"image_name": imageName, "ad_id": adId};
      log(imageName);
      log(adId);
      var response =
          await http.post(Uri.parse(baseUrl + deleteUserAdsUrl), body: params);
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);

        return result;

        //  jsondata['category'];
      } else {
        log(response.body.toString());
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  // /\/\/\/\\/\/\/\/\/check Intrested Cars
  Future checkIntrestedCars(
    String carId,
  ) async {
    try {
      log(carId, name: 'carId');

      var sp = await SharedPreferences.getInstance();
      String userId = sp.getString('cusId') ?? "";

      if (userId != "") {
        Map params = {"ad_id": carId, "uid": userId};
        var response = await http
            .post(Uri.parse(baseUrl + checkIntrestedCarsUrl), body: params);
        if (response.statusCode == 200) {
          var result = await jsonDecode(response.body);

          return result;

          //  jsondata['category'];
        } else {
          return Future.error("Network error");
        }
      } else {
        return {'status': "false"};
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      log(e.toString(), name: 'userId');

      return Future.error(e);
    }
  }

  Future saveFCMTokentoServer(String number) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();

      if (number.isNotEmpty && number != '0') {
        String savedFCM = sharedPreferences.getString('fcm_token') ?? '';
        if (savedFCM.isEmpty) {
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          String fcmToken = await messaging.getToken() ?? '';
          if (fcmToken.isNotEmpty) {
            Map params = {'mobileNumber': number, 'token_number': fcmToken};
            print(fcmToken);
            var response = await http.post(Uri.parse(baseUrl + saveFcmTokenUrl),
                body: params);
            if (response.statusCode == 200) {
              var result = await jsonDecode(response.body);
              // log("result.toString()");
              // log(result.toString());
              // log(fcmToken);
              if (result == "Inserted") {
                // print("local");
                saveFCMToken(fcmToken);
              }
              // print('fcm res server ' + result.toString());
            }
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//fcm locally
  void saveFCMToken(var fcmToken) async {
    debugPrint('FCM Saved');
    var sharedPreferences = await SharedPreferences.getInstance();
    String savedFCM = sharedPreferences.getString('fcm_token') ?? '';
    if (savedFCM.isEmpty) {
      sharedPreferences.setString('fcm_token', fcmToken);
    }
  }

  Future fetchNotifications() async {
    try {
      // var sp = await SharedPreferences.getInstance();
      // String userId = sp.getString('cusId') ?? "";
      // log(userId.toString(), name: "body");

      // if (userId != "") {
      // Map params = {
      //   "cus_id": userId,
      // };
      var response = await http.post(
        Uri.parse(baseUrl + fetchNotificationsUrl),
      );
      log(response.statusCode.toString(), name: "body");
      if (response.statusCode == 200) {
        // var result = await jsonDecode(response.body);

        return response.body;
      } else {
        return Future.error("Network error");
      }
      // } else {
      //   return Future.error("Network error");
      // }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      log(e.toString(), name: 'userId');

      return Future.error(e);
    }
  }
}

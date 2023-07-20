import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/view/login.dart';
import 'package:hm_motors/view/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/api_controller.dart';

//check internet connection
bool isConnected = true;
Future<bool> checkNetwork() async {
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // print('connected');
      isConnected = true;
    }
  } on SocketException catch (_) {
    // print('not connected');
    isConnected = false;
  }
  return isConnected;
}

//check logged in or not
checkIsLoggedIn() async {
  String status = "failed";
  var sp = await SharedPreferences.getInstance();
  var result = sp.getString("mobile");
  // print(result);
  if (result == "" || result == null) {
    status = "failed";
  } else {
    status = "success";
  }
  return status;
}

//navigation function
navigate(Widget route, bool isreplace) {
  isreplace
      ? navigatorKey.currentState!
          .pushReplacement(MaterialPageRoute(builder: (_) => route))
      : navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (_) => route));
}

//loading dialog widget

lodingDialog(BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
            ),
          ));
}

//goto search
Future<void> showSearches(BuildContext context) async {
  await showSearch(
    context: context,
    delegate: SearchField(),
    // query: "any query",
  );
}

//goto phone dialer
Future<void> launchDialer() async {
  final url = Uri.parse("tel:+971507182336");
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

//help dialog
helpDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
            ),
          ));
}

//get user mobile number\
getUserNumber() async {
  var sp = await SharedPreferences.getInstance();
  userNumber = sp.getString("mobile") ?? "";

  ApiController().saveFCMTokentoServer(userNumber);
}

//is skip trueplease login
Widget loginBuild(
  double height,
  double width,
) {
  return Scaffold(
      body: SizedBox(
    height: height,
    width: width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Please Login for more features",
          style: TextStyle(fontFamily: "Rubik", fontSize: 17),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            navigate(LoginView(), false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fixedSize: const Size.fromWidth(100),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  ));
}

///loading widget
Widget loadingAnimation() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

//popup login dialog
buildloginDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(
              'Please login to continue',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.grey.shade700),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () => navigate(LoginView(), false),
                  child: const Text(
                    "Login",
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/view/enter_otp.dart';
import 'package:hm_motors/view/home.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/enter_your_name.dart';

class LoginController {
  checkPhoneNumber(String number, BuildContext context) async {
    String error = "";
    if (number.isEmpty) {
      error = "Mobile number is empty";
    } else if (number.length != 10) {
      error = "Enter a valid mobile number";
    } else {
      lodingDialog(context);
      var result = await ApiController().enterNumber(number);
      log(result.toString());
      if (result.isEmpty) {
        navigate(const ErrorPage(), true);
      } else {
        navigate(
            EnterOtp(
                mobileNumber: number,
                otp: result["otp"].toString(),
                status: result["status"],
                id: result["status"] == 'exist'
                    ? result['data']['customer_id']
                    : ""),
            true);

        //
      }
    }

    if (error != "") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              error,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red.shade700),
      );
    }
  }

  ////////////////////////////verify otp/////////////////////////////////
  verifyOtp(
      String digit1,
      String digit2,
      String digit3,
      String digit4,
      String otp,
      String status,
      BuildContext context,
      String number,
      String id) async {
    String error = "";
    if (digit1.isEmpty || digit2.isEmpty || digit3.isEmpty || digit4.isEmpty) {
      error = "Enter a valid otp";
    } else if (otp != digit1 + digit2 + digit3 + digit4) {
      error = "Otp doesnt match";
    } else {
      if (status == "new") {
        navigate(EnterYourName(number: number), true);
      } else {
        isSkip = false;
        var sp = await SharedPreferences.getInstance();
        sp.setString("mobile", number);
        sp.setString("cusId", id);
        navigate(const Home(), true);
      }
    }

    if (error != "") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              error,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red.shade700),
      );
    }
  }

  ////////////////////////////////////////// enter your name ////////////////////////////////////
  enterYourname(String number, String name, BuildContext context) async {
    // print(name);
    // print(number);
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text(
              "Please enter your name",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red.shade700),
      );
    } else {
      lodingDialog(context);
      var result = await ApiController().register(number, name);

      if (result['status'] != "success") {
        navigate(const ErrorPage(), true);
      } else {
        isSkip = false;
        var sp = await SharedPreferences.getInstance();
        sp.setString("mobile", number);

        sp.setString("cusId", result['id']);

        navigate(const Home(), true);
      }
    }
  }
}

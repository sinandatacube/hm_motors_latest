import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm_motors/global_functions.dart';

import '../global_variables.dart';
import '../view/home.dart';
import 'api_controller.dart';

class SellCarController {
  _buildInterestDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Thanks for selling your car with us.Our sales executive will call you back.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.grey.shade700),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () => navigate(const Home(), false),
                    child: const Text(
                      "Ok",
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

//validate form
  validateform(
      String brand,
      String model,
      String registrationNumber,
      String year,
      String owners,
      String kms,
      String insurance,
      String tyre,
      String vehicleCondition,
      List images,
      String mobile,
      String varient,
      String expectedPrice,
      BuildContext context) async {
    String error = "";
    if (brand.isEmpty) {
      error = "Enter Brand";
    } else if (model.isEmpty) {
      error = "Enter model";
    } else if (varient.isEmpty) {
      error = "Enter vehicle varient";
    } else if (registrationNumber.isEmpty) {
      error = "Enter registration number ";
    } else if (year.isEmpty) {
      error = "Enter Year of registration";
    } else if (owners.isEmpty) {
      error = "Enter number of owners";
    } else if (kms.isEmpty) {
      error = "Enter run kms";
    } else if (insurance.isEmpty) {
      error = "Enter insurance valid upto";
    } else if (tyre.isEmpty) {
      error = "Enter tyre life";
    } else if (vehicleCondition.isEmpty) {
      error = "Enter vehicle Condition";
    } else if (expectedPrice.isEmpty) {
      error = "Enter expected price";
    } else if (images.isEmpty) {
      error = "Please select an image";
    } else if (images.length > 6) {
      error = "Select upto 6 images";
    } else {
      lodingDialog(context);

      var result = await ApiController().submitSellCar(
          registrationNumber,
          brand,
          model,
          year,
          owners,
          kms,
          insurance,
          tyre,
          vehicleCondition,
          images,
          mobile,
          varient,
          expectedPrice);
      log(result, name: "result");
      if (result == "Inserted") {
        navigatorKey.currentState!.pop();
        _buildInterestDialog(context);
      }
      // _buildInterestDialog(context);
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
}

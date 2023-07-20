import 'package:flutter/material.dart';
import 'package:hm_motors/provider/emicalculator_provider.dart';
import 'package:provider/provider.dart';

class EmiCalculatorController {
  checkForm(String loanAmount, String interestRate, String tenure,
      BuildContext context) {
    String error = "";
    if (loanAmount.isEmpty) {
      error = "Enter loan amount";
    } else if (interestRate.isEmpty) {
      error = "Enter interest rate";
    } else if (tenure.isEmpty) {
      error = "Enter loan tenure";
    } else {
      double p = double.parse(loanAmount);
      double r = double.parse(interestRate);

      double n = double.parse(tenure);

      context.read<EmiCalculatorProvider>().calculateEmi(p, r, n);
    }

    if (error != "") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red.shade800,
      ));
    }
  }
}

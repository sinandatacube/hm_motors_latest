import 'dart:math';

import 'package:flutter/cupertino.dart';

class EmiCalculatorProvider extends ChangeNotifier {
  //emi
  double A = 0;
  //loan amount
  double principleAmount = 0;
  //rate of interest
  double rateOfInterst = 0;
  //number of months
  double noOfMonths = 0;

  //interest payable
  double interestPayable = 0;

  //total payment
  double totalPayment = 0;

  clearAll() {
    A = 0;
    principleAmount = 0;
    rateOfInterst = 0;
    noOfMonths = 0;
    interestPayable = 0;
    totalPayment = 0;
  }

  totalInterest(double pA, double emi, double nM) {
    interestPayable = 0;
    double tot = emi * nM;
    interestPayable = tot - pA;
    totalPayment = pA + interestPayable;
  }

  calculateEmi(double P, double rI, double n) {
    A = 0;
    principleAmount = P;
    rateOfInterst = rI;
    noOfMonths = n;
    double r = rI / 12 / 100;
    A = P * r * pow((1 + r), n) / ((pow((1 + r), n) - 1));
    totalInterest(principleAmount, A, noOfMonths);
    notifyListeners();
  }
}

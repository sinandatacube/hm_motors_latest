import 'package:flutter/material.dart';

import 'package:hm_motors/controller/emicalculator_controller.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/provider/emicalculator_provider.dart';
import 'package:provider/provider.dart';

class EmiCalculator extends StatelessWidget {
  EmiCalculator({super.key});
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();

  TextEditingController loanTenureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text(
            "Emi calculator",
            style: TextStyle(fontFamily: "Rubik"),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.4,
                    width: width,
                  ),

                  //backbutton
                  // Positioned(
                  //   left: width * 0.03,
                  //   top: width * 0.0,
                  //   child: InkWell(
                  //     onTap: () => navigatorKey.currentState!.pop(),
                  //     child: Card(
                  //       elevation: 4,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30)),
                  //       child: Container(
                  //         width: 40,
                  //         height: 30,
                  //         alignment: Alignment.center,
                  //         padding: EdgeInsets.only(left: width * 0.005),
                  //         margin: EdgeInsets.symmetric(
                  //             horizontal: width * 0.005,
                  //             vertical: height * 0.01),
                  //         child: Icon(
                  //           Icons.arrow_back_ios,
                  //           size: 20,
                  //         ),
                  //         decoration: BoxDecoration(
                  //             color: Colors.white, shape: BoxShape.circle),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  //base card

                  Positioned(
                    top: height * 0.06,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          width: width * 0.95,
                          height: height * 0.3,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.04),
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Consumer(builder:
                              (context, EmiCalculatorProvider value, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.17,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Principle Amount",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: Colors.grey.shade500,
                                                  fontFamily: "Rubik"),
                                        ),
                                        SizedBox(
                                          height: height * 0.005,
                                        ),
                                        Text(
                                          "Rs ${value.principleAmount.toInt()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Rubik"),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Interest Payable",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: Colors.grey.shade500,
                                                  fontFamily: "Rubik"),
                                        ),
                                        SizedBox(
                                          height: height * 0.005,
                                        ),
                                        Text(
                                          "Rs ${value.interestPayable.round()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Rubik"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: SizedBox(
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total Payment",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: Colors.grey.shade500,
                                                    fontFamily: "Rubik"),
                                          ),
                                          SizedBox(
                                            height: height * 0.005,
                                          ),
                                          Text(
                                            "Rs ${value.totalPayment.round()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Rubik"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  //round base

                  Positioned(
                      top: height * 0.0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Card(
                          elevation: 5,
                          shape: const CircleBorder(),
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.25,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: mainColor, width: 18),
                                // color: mainColor,
                                shape: BoxShape.circle),
                            child: Consumer(builder:
                                (context, EmiCalculatorProvider value, child) {
                              return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'Your EMI is\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                            fontFamily: "Rubik"),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Rs ${value.A.round()}\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(fontFamily: "Rubik")),
                                      TextSpan(
                                        text: 'Per month',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54,
                                                fontFamily: "Rubik"),
                                      )
                                    ]),
                              );
                            }),
                          ),
                        ),
                      )),
                ],
              ),
              Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: height * 0.45,
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Loan Amount",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Rubik"),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              height: 45,
                              child: TextField(
                                controller: loanAmountController,
                                cursorColor: Colors.black54,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusColor: Colors.amber.shade800,
                                  prefixText: "Rs ",
                                  filled: true,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Interest Rate",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Rubik"),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              height: 45,
                              child: TextField(
                                cursorColor: Colors.black54,
                                controller: interestRateController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusColor: Colors.amber.shade800,
                                  suffixText: "%",
                                  filled: true,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'Loan Tenure\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                          fontFamily: "Rubik"),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '(in Months)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                              fontFamily: "Rubik"),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              height: 45,
                              child: TextField(
                                cursorColor: Colors.black54,
                                controller: loanTenureController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusColor: Colors.amber.shade800,
                                  filled: true,
                                  isDense: true,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      SizedBox(
                        height: 40,
                        width: width * 0.4,
                        child: ElevatedButton(
                          onPressed: () => EmiCalculatorController().checkForm(
                              loanAmountController.text.trim(),
                              interestRateController.text.trim(),
                              loanTenureController.text.trim(),
                              context),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Calculate",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Rubik"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

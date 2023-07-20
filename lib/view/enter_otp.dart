import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm_motors/controller/login_controller.dart';
import 'package:hm_motors/global_variables.dart';

class EnterOtp extends StatelessWidget {
  final String mobileNumber;
  final String status;
  final String otp;
  final String id;
  EnterOtp(
      {Key? key,
      required this.mobileNumber,
      required this.id,
      required this.otp,
      required this.status})
      : super(key: key);
  TextEditingController digit1Controller = TextEditingController();
  TextEditingController digit2Controller = TextEditingController();
  TextEditingController digit3Controller = TextEditingController();
  TextEditingController digit4Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(),
      body: _buildbody(context, height, width),
    );
  }

  Widget _buildbody(BuildContext context, double height, double width) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: height * 0.4,
              width: width,
              child: Center(
                child: Container(
                  height: height * 0.35,
                  width: width * 0.35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      blurRadius: 10.0,
                    ),
                  ], color: Colors.white, shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/3.png",
                    height: height * 0.15,
                    width: width * 0.15,
                  ),
                ),
              )),
          Container(
            height: height * 0.49,
            width: width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    blurRadius: 20.0,
                  ),
                ],
                color: Colors.white,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(80))),
            child: Column(
              children: [
                Container(
                  height: height * 0.1,
                  width: width,
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.15, vertical: height * 0.03),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Please enter the verification code sent to $mobileNumber",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontFamily: "Rubik"),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 50,
                      child: TextFormField(
                        onChanged: (str) {
                          if (str.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (str.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber.shade700),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        keyboardType: TextInputType.number,
                        controller: digit1Controller,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        // decoration: const InputDecoration(
                        //     border: InputBorder.none,
                        //     // hintText: "   *",
                        //     hintStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 20,
                        //     )),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    SizedBox.square(
                      dimension: 50,
                      child: TextFormField(
                        onChanged: (str) {
                          if (str.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (str.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        keyboardType: TextInputType.number,
                        controller: digit2Controller,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        // decoration: const InputDecoration(
                        //     border: InputBorder.none,
                        //     // hintText: "   *",
                        //     hintStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 20,
                        //     )),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    SizedBox.square(
                      dimension: 50,
                      child: TextFormField(
                        onChanged: (str) {
                          if (str.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (str.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        keyboardType: TextInputType.number,
                        controller: digit3Controller,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        // decoration: const InputDecoration(
                        //     border: InputBorder.none,
                        //     // hintText: "   *",
                        //     hintStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 20,
                        //     )),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    SizedBox.square(
                      dimension: 50,
                      child: TextFormField(
                        onChanged: (str) {
                          if (str.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (str.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        keyboardType: TextInputType.number,
                        controller: digit4Controller,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        // decoration: const InputDecoration(
                        //     border: InputBorder.none,
                        //     // hintText: "   *",
                        //     hintStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 20,
                        //     )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      String digit1 = digit1Controller.text.trim();
                      String digit2 = digit2Controller.text.trim();
                      String digit3 = digit3Controller.text.trim();
                      String digit4 = digit4Controller.text.trim();

                      LoginController().verifyOtp(digit1, digit2, digit3,
                          digit4, otp, status, context, mobileNumber, id);
                    },
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

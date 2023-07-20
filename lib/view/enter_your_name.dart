// import 'package:flutter/material.dart';
// import 'package:hm_motors/controller/login_controller.dart';

// class EnterYourName extends StatelessWidget {
//   final String number;
//   EnterYourName({super.key, required this.number});
//   final TextEditingController nameController = TextEditingController();
//   // final focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: SizedBox(
//           width: width,
//           height: height,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                     height: 180,
//                     width: 180,
//                     margin: EdgeInsets.only(
//                         top: height * 0.1, bottom: height * 0.0),
//                     decoration: const BoxDecoration(shape: BoxShape.circle),
//                     child: Image.asset(
//                       "assets/avatar.png",
//                     )),
//                 // Padding(
//                 //   padding: EdgeInsets.symmetric(vertical: height * 0.03),
//                 //   child:const Text(
//                 //     "Enter your name",
//                 //     style: TextStyle(
//                 //         fontFamily: "Rubik",
//                 //         fontWeight: FontWeight.w500,
//                 //         fontSize: 20),
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: height * 0.03,
//                 ),
//                 SizedBox(
//                   width: width * 0.7,
//                   height: 50,
//                   child: TextField(
//                     controller: nameController,
//                     // focusNode: focusNode,
//                     autofocus: true,
//                     decoration: InputDecoration(
//                         hintText: "Enter your name",
//                         hintStyle: TextStyle(fontFamily: "Rubik"),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.amber.shade900)),
//                         isDense: true,
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5))),
//                   ),
//                 ),
//                 Container(
//                   width: width * 0.5,
//                   height: 45,
//                   margin: EdgeInsets.only(top: height * 0.05),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       String name = nameController.text.trim();
//                       LoginController().enterYourname(number, name, context);
//                     },
//                     child: const Text(
//                       "Continue",
//                       style: TextStyle(
//                           fontFamily: "Rubik",
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hm_motors/controller/login_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';

class EnterYourName extends StatelessWidget {
  final String number;
  EnterYourName({super.key, required this.number});
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (isConnected) {
      return Scaffold(
        ///////////////////////////////////////////Appbar////////////////////////////////////////////
        appBar: AppBar(
            // actions: [
            //   SizedBox(
            //     child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10)),
            //           backgroundColor: Colors.white,
            //         ),
            //         onPressed: () {
            //           isSkip=true;
            //           Navigator.of(context).push(
            //               MaterialPageRoute(builder: (context) => const Home()));
            //         },
            //         child: const Text(
            //           "Skip",
            //           style: TextStyle(fontFamily: "Rubik"),
            //         )),
            //   )
            // ],
            ),
        backgroundColor: mainColor,

        ///////////////////////////////////body////////////////////////////////////////////////////////
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.39,
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
                        "assets/123.png",
                        height: height * 0.15,
                        width: width * 0.15,
                      ),
                    ),
                  )),
              Container(
                height: height * 0.5,
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: height * 0.08,
                    // ),
                    Container(
                      height: height * 0.1,
                      width: width,
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.08, vertical: height * 0.03),
                      alignment: Alignment.bottomCenter,
                      // child: const Text(
                      //   "Enter your name",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 18,
                      //       fontFamily: "Rubik"),
                      // ),
                    ),
                    SizedBox(
                        width: width * 0.7,
                        child: TextField(
                          controller: nameController,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "Enter your name",
                              hintStyle: TextStyle(fontFamily: "Rubik")),
                        )),
                    SizedBox(
                      height: height * 0.12,
                    ),
                    SizedBox(
                      height: 55,
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          String name = nameController.text.trim();
                          LoginController()
                              .enterYourname(number, name, context);
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 18, fontFamily: "Rubik"),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: NoNetwork(),
      );
    }
  }
}

// class LoginView extends StatelessWidget {
//   LoginView({Key? key}) : super(key: key);
//   TextEditingController otpController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         // backgroundColor: mainColor,
//         leading: IconButton(
//             onPressed: () => navigatorKey.currentState!
//                 .push(MaterialPageRoute(builder: (_) => Home())),
//             icon: const Icon(Icons.close)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: width * 0.04),
//         child: Column(
//           children: [
//             // SizedBox(
//             //   height: height * 0.02,
//             // ),
//             // Image.asset(
//             //   "assets/hm-01.png",
//             //   width: width * 0.8,
//             //   height: height * 0.07,
//             //   // width: 200,
//             //   // height: 100,
//             // ),
//             SizedBox(
//               height: height * 0.05,
//             ),
//             Text(
//               "Log in to your account",
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium!
//                   .copyWith(fontSize: 18),
//             ),
//             SizedBox(
//               height: height * 0.03,
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//               child: const Text("Enter phone number"),
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//               child: TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   filled: true,
//                   isDense: true,
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Container(
//               width: width,
//               height: 50,
//               padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(primary: mainColor),
//                 onPressed: () {
//                   var number = otpController.text.trim();
//                   LoginController().checkPhoneNumber(number, context);
//                 },
//                 child: const Text("Get otp"),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             const Text("By continuing you agree to privacy and policy")
//           ],
//         ),
//       ),
//     );
//   }
// }

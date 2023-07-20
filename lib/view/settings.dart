import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/main.dart';
import 'package:hm_motors/url.dart';
import 'package:hm_motors/view/emi_calculator.dart';
import 'package:hm_motors/view/login.dart';
import 'package:hm_motors/view/your_cars.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../help/help.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(fontFamily: "Rubik"),
        ),
      ),
      body: FutureBuilder(
          future: ApiController().fetchUserDetails(userNumber),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              return Scaffold(
                backgroundColor: Colors.grey.shade50,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Image.asset("assets/avatar.png",
                              height: 100, width: 100),
                          SizedBox(
                            width: width * 0.08,
                          ),
                          isSkip
                              ? Column(
                                  children: [
                                    const Text("Please Login.. !",
                                        style: TextStyle(fontFamily: "Rubik")),
                                    const SizedBox(height: 5),
                                    ElevatedButton(
                                      onPressed: () =>
                                          navigate(LoginView(), false),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                )
                              // ? ElevatedButton(
                              //     style: ElevatedButton.styleFrom(elevation: 1),
                              //     onPressed: () => navigate(LoginView(), false),
                              //     child: const Text("Login"))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data == "Error"
                                        ? const SizedBox.shrink()
                                        : Text(
                                            data["customer_name"],
                                            style: const TextStyle(
                                                fontFamily: "Rubik",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    data == "Error"
                                        ? const SizedBox.shrink()
                                        : Text(
                                            data["customer_contact_number"],
                                            style: const TextStyle(
                                                fontFamily: "Rubik",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                  ],
                                )
                        ],
                      ),
                      // Container(
                      //   width: width,
                      //   height: height * 0.1,
                      //   padding: EdgeInsets.only(top: height * 0.03, left: width * 0.05),
                      //   child: const Text(
                      //     "Settings",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 27,
                      //         fontFamily: "Rubik"),
                      //   ),
                      // ),
                      SizedBox(height: height * 0.05),
                      /////////////////////tiles///////////////////////////////

                      profileTile("Showroom location", LineIcons.mapMarker,
                          context, height, width, true, () {
                        navigateTo(11.1514746, 76.0910605);
                      }),
                      profileTile("Emi calculator", LineIcons.calculator,
                          context, height, width, true, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EmiCalculator()));
                      }),
                      profileTile("My cars", LineIcons.car, context, height,
                          width, true, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => YourCars()));
                      }),

                      // isSkip
                      //     ? const SizedBox.shrink()
                      //     : profileTile("Account", LineIcons.user, context, height, width,
                      //         true, () {}),

                      profileTile("Help", Icons.help_outline_outlined, context,
                          height, width, true, () {
                        navigate(const Help(), false);
                      }),

                      // profileTile(
                      //     "Privacy Policy",
                      //     Icons.privacy_tip_outlined,
                      //     context,
                      //     height,
                      //     width,
                      //     true,
                      //     () => policyUrlLaunch(policyUrl)),
                      // isSkip
                      //     ? profileTile("Login", Icons.logout, context, height,
                      //         width, false, () {
                      //         navigate(LoginView(), false);
                      //       })
                      //     :
                      !isSkip
                          ? profileTile("Logout", Icons.logout, context, height,
                              width, false, () {
                              showDialog(
                                  context: context, builder: _buildDialog);
                            })
                          : const SizedBox.shrink(),
                      Expanded(
                          child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/hm-01.png",
                              height: 35,
                              width: 100,
                            ),
                            Text(
                              "version ${packageInfo?.version}",
                              style: const TextStyle(fontFamily: "Rubik"),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            } else {
              return loadingAnimation();
            }
          }),
    );
  }

  //settings tile

  Widget profileTile(String title, IconData icon, BuildContext context,
      double height, double width, bool isIcon, Function route) {
    return InkWell(
      onTap: () => route(),
      child: Container(
        height: height * 0.08,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        // padding: EdgeInsets.symmetric(horizontal: width * 0.0),
        child: Row(
          children: [
            Icon(icon),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: width * 0.03),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontFamily: "Rubik"),
                ),
              ),
            ),
            isIcon
                ? const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

//open google map
  static void navigateTo(double lat, double lng) async {
    Uri uri;
    if (Platform.isAndroid) {
      uri = Uri.parse("geo:$lat,$lng?z=15");
    } else {
      uri = Uri.parse("https://maps.apple.com/?q=$lat,$lng");
    }
    // var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

//logout dialog box
  Widget _buildDialog(BuildContext context) => AlertDialog(
        title: Text(
          'Are you sure you want to Logout?',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: mainColor),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          TextButton(
              onPressed: () async {
                var sp = await SharedPreferences.getInstance();
                await sp.setString("mobile", "");
                await sp.setString("cusId", "");
                await sp.setStringList("fav", []);
                await sp.setString("fcm_token", "");
                await sp.setString("pass", "");
                navigatorKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginView()),
                    (route) => false);
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (context) => LoginView(),
                //     ),
                //     (route) => false);
              },
              child: Text("Yes",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black)))
        ],
      );
}

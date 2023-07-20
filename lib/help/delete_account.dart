import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/login.dart';

const _companyName = "HM Motors";

const pcolor = Colors.orange;

// GlobalKey<FormState> _fkey = GlobalKey<FormState>();

class AccountDelete extends StatelessWidget {
  const AccountDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Account Delete'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 40,
            ),
            const SizedBox(height: 30),
            const Text(
              "By closing account you will lose all of your data from $_companyName, you no longer have access to your account and it can't be recovered.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: .5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // final psswcntr = TextEditingController();
                    return AlertDialog(
                      content: const Text(
                        'Are you sure to delete your account?',
                        style: TextStyle(
                            fontFamily: "Rubik", fontWeight: FontWeight.w500),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: pcolor),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            var sp = await SharedPreferences.getInstance();
                            await sp.setString("mobile", "");
                            await sp.setStringList("fav", []);
                            await sp.setString("fcm_token", "");
                            await sp.setString("pass", "");
                            var result =
                                await ApiController().deleteUser(userNumber);
                            if (result == "deleted") {
                              navigatorKey.currentState!.pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => LoginView()),
                                  (route) => false);
                            }

                            // navigatorKey.currentState!.pushAndRemoveUntil(
                            //     MaterialPageRoute(builder: (_) => LoginView()),
                            //     (route) => false);
                            // final prefs = await SharedPreferences.getInstance();
                            // String userId = prefs.getString('userid') ?? "0";
                            // String userSavedPass =
                            //     prefs.getString("userpassword") ?? "";
                            // String userTypedPass = psswcntr.text;

                            // if (userSavedPass.isNotEmpty &&
                            //     userSavedPass == userTypedPass) {
                            //   //request to delete
                            //   Map params = {"user_id": userId};
                            //   try {
                            //     var response = await http.post(
                            //         Uri.parse(urlDeleteAccount),
                            //         body: params);
                            //     log(response.body);
                            //     var result = jsonDecode(response.body);

                            //     if (result) {
                            //       //deleted
                            //       await prefs.setBool('ifuser', false);
                            //       await prefs.setBool('carduser', false);
                            //       ifuser = false;
                            //       AppResources.navKey.currentState
                            //           ?.pushAndRemoveUntil(
                            //               MaterialPageRoute(
                            //                   builder: (_) =>
                            //                       const MainBottomBar()),
                            //               (route) => false);
                            //       //
                            //     } else {
                            //       Fluttertoast.showToast(
                            //           msg: "Failed, please try again later");
                            //     }
                            //   } catch (e) {
                            //     log(e.toString());
                            //     Fluttertoast.showToast(
                            //         msg: "Failed, please try again later");
                            //   }
                            // } else {
                            //   Fluttertoast.showToast(
                            //       msg: "Enter correct password");
                            // }
                          },
                          child: const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text(
                'DELETE MY ACCOUNT',
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding txt(txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          circle(),
          Expanded(
            child: Text(
              txt,
              // textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Container circle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 10,
      width: 10,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
    );
  }
}

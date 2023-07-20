import 'package:flutter/material.dart';

import '../../global_functions.dart';
import '../../global_variables.dart';
import '../home.dart';
import '../login.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.09),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/noNetwork1.png",
              height: height * 0.15,
              width: width * 0.25,
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Text(
            "Whoops!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w400, color: Colors.grey.shade400),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Text(
            "No Internet connection found.Check your connection and try again",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400, color: Colors.grey.shade600),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mainColor),
              onPressed: () async {
                // var prefss = await SharedPreferences.getInstance();
                checkNetwork();
                Future.delayed(const Duration(milliseconds: 150), () async {
                  if (isConnected == true) {
                    var route = await checkIsLoggedIn();
                    // print(route);
                    if (route == "failed") {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ));
                    } else if (route == "success") {
                      navigatorKey.currentState!.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                          (route) => false);
                    }
                  } else if (isConnected == false) {
                    navigatorKey.currentState!.pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const NoNetwork(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
                });
              },
              // onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => route(),)),
              child: Text(
                "Try again",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w400, color: Colors.white),
              ))
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm_motors/global_functions.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/provider/car_details_provider.dart';
import 'package:hm_motors/provider/emicalculator_provider.dart';
import 'package:hm_motors/provider/homepage_provider.dart';
import 'package:hm_motors/view/home.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/vehicle_details%20copy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'http_override.dart';

// price fix
PackageInfo? packageInfo;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: const FirebaseOptions(
    //     apiKey: "AIzaSyAwlMy6eSyGNLKWGnoI3xH4jGXo9H-L0TQ",
    //     appId: "1:536472508718:web:6392b3c18a52e891af42bf",
    //     messagingSenderId: "536472508718",
    //     projectId: "spencer-mobile-accessories")
  );

  HttpOverrides.global = MyHttpoverrides();

  packageInfo = await PackageInfo.fromPlatform();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => VehicleDetailsProvider()),
    ChangeNotifierProvider(create: (_) => EmiCalculatorProvider()),
    ChangeNotifierProvider(create: (_) => HomePageProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      color: mainColor,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.amber,
        primaryColor: mainColor,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: mainColor,
            foregroundColor: Colors.black),
        backgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
      Future.delayed(const Duration(seconds: 1), () async {
        setRoute();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkNetwork();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.1),
            Image.asset(
              "assets/hm-01.png",
              width: width * 0.8,
              height: height * 0.07,
              // width: 200,
              // height: 100,
            ),
            SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                color: mainColor,
                strokeWidth: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

setRoute() async {
  checkNetwork();
  Future.delayed(const Duration(seconds: 1), () async {
    String status = await checkIsLoggedIn();
    if (isConnected) {
      if (status == "success") {
        isSkip = false;
        navigatorKey.currentState!
            .pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
      } else {
        isSkip = true;
        navigatorKey.currentState!
            .pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
      }
    } else {
      navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (_) => const ErrorPage()));
    }
  });
}

handleDynamicLink() async {
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    log(deepLink.toString(), name: "deeplink");
    // Example of using the dynamic link to push the user to a different screen
    // navigatorKey.currentState?.push(MaterialPageRoute(builder: (_)=>VehicleDetails()));
  }
}

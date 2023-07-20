// import 'package:flutter/material.dart';
// import 'package:hm_motors/global_variables.dart';
// import 'package:hm_motors/provider/emicalculator_provider.dart';
// import 'package:hm_motors/view/emi_calculator.dart';
// import 'package:hm_motors/view/support.dart';
// import 'package:hm_motors/view/wishlist.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NavDrawer extends StatelessWidget {
//   const NavDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width * 0.7,
//       height: height,
//       color: Colors.white,
//       child: Column(
//         children: [
//           DrawerHeader(
//             child: Image.asset(
//               "assets/hm-01.png",
//               width: width * 0.5,
//               height: height * 0.05,
//             ),
//           ),
//           // const Divider(
//           //   thickness: 1.5,
//           // )
//           ListTile(
//             leading: Icon(LineIcons.car,
//                 color: Colors.black, size: Theme.of(context).iconTheme.size),
//             title: Text(
//               'Sell your car',
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               scaffoldKey.currentState!.closeDrawer();
//               navigatorKey.currentState!
//                   .push(MaterialPageRoute(builder: (_) => EmiCalculator()))
//                   .then((value) =>
//                       context.read<EmiCalculatorProvider>().clearAll());
//             },
//             leading: Icon(LineIcons.calculator,
//                 color: Colors.black, size: Theme.of(context).iconTheme.size),
//             title: Text(
//               'Emi calculator',
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//           ),

//           ListTile(
//               leading: Icon(LineIcons.heart,
//                   color: Colors.black, size: Theme.of(context).iconTheme.size),
//               title: Text(
//                 'Wishlist',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       fontWeight: FontWeight.w400,
//                     ),
//               ),
//               onTap: () {
//                 navigatorKey.currentState!.pop();
//                 navigatorKey.currentState!
//                     .push(MaterialPageRoute(builder: (_) => const WishList()));
//               }),
//           ListTile(
//             onTap: () {
//               navigateTo(10.9985, 76.1422);
//               // launc();
//               // launchMap();
//             },
//             leading: const Icon(
//               LineIcons.mapMarker,
//               color: Colors.black,
//             ),
//             title: Text(
//               "Showroom Location",
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(LineIcons.user,
//                 color: Colors.black, size: Theme.of(context).iconTheme.size),
//             title: Text(
//               'Account',
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//             onTap: () async {},
//           ),

//           ListTile(
//             onTap: () => Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => const Support())),
//             leading: const Icon(
//               LineIcons.comment,
//               color: Colors.black,
//             ),
//             title: Text(
//               "Support",
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.logout_outlined,
//                 color: Colors.black, size: Theme.of(context).iconTheme.size),
//             title: Text(
//               'Logout',
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//             onTap: () async {
//               // Update the state of the app
//               // ...
//               // Then close the drawer
//               Navigator.pop(context);
//               // showDialog(context: context, builder: _buildDialog);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // void launc() async {
//   //   String googleUrl = "https://sample-web-c3f9c.web.app/#/base";
//   //   if (await canLaunch(googleUrl)) {
//   //     await launch(googleUrl);
//   //   }
//   // }
//   static void navigateTo(double lat, double lng) async {
//     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
//     if (!await launchUrl(uri)) {
//       throw 'Could not launch $uri';
//     }
//   }

//   // Future<void> launc() async {
//   //   String googleUrl = "https://goo.gl/maps/XARSjK38eUxT2PR38";
//   //   if (!await launchUrl(Uri.parse(googleUrl))) {
//   //     throw 'Could not launch $googleUrl';
//   //   }
//   // }

//   // void launchMap() async {
//   //   // String query = Uri.encodeComponent(address);
//   //   String googleUrl = "https://goo.gl/maps/XARSjK38eUxT2PR38";

//   //   if (await canLaunch(googleUrl)) {
//   //     await launch(googleUrl);
//   //   }
//   // }
//   // static Future<void> openMap() async {
//   //   String googleUrl =
//   //       // 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
//   //       "https://goo.gl/maps/XARSjK38eUxT2PR38";

//   //   // if (await canLaunchUrl(Uri.parse(googleUrl))) {
//   //   // await launchUrl(Uri.parse(googleUrl));
//   //   // } else {
//   //   //   throw 'Could not open the map.';
//   //   // }+

//   //   // String query = Uri.encodeComponent(googleUrl);
//   //   // // String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
//   //   if (await canLaunch(googleUrl)) {
//   //     await launch(googleUrl);
//   //   }
//   // }
// }

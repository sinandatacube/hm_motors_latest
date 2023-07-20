// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import '../url.dart';

// class PrivacyPolicy extends StatefulWidget {
//    PrivacyPolicy({super.key});

//   @override
//   State<PrivacyPolicy> createState() => _PrivacyPolicyState();
// }

// class _PrivacyPolicyState extends State<PrivacyPolicy> {
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Privacy policy"),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             // key: wKey,
//             initialUrl: policyUrl,
//             javascriptMode: JavascriptMode.unrestricted,
//             onPageFinished: (finish) {
//               setState(() {
//                 isLoading = false;
//               });
//             },
//           ),
//           if (isLoading)
//             const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xff2e5266),
//                 strokeWidth: 2.5,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // class Webview extends StatefulWidget {
// //   const Webview({Key? key}) : super(key: key);

// //   @override
// //   State<Webview> createState() => _WebviewState();
// // }

// // class _WebviewState extends State<Webview> {
// //   bool isLoading = true;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Privacy policy"),
// //       ),
// //       body: Stack(
// //         children: [
// //           WebView(
// //             // key: wKey,
// //             initialUrl: policyUrl,
// //             javascriptMode: JavascriptMode.unrestricted,
// //             onPageFinished: (finish) {
// //               setState(() {
// //                 isLoading = false;
// //               });
// //             },
// //           ),
// //           if (isLoading)
// //             const Center(
// //               child: CircularProgressIndicator(
// //                 color: Color(0xff2e5266),
// //                 strokeWidth: 2.5,
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }

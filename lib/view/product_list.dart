// import 'package:flutter/material.dart';
// import 'package:hm_motors/global_variables.dart';
// import 'package:hm_motors/list.dart';
// import 'package:hm_motors/view/vehicle_details.dart';

// class ProductList extends StatelessWidget {
//   const ProductList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(context),
//       appBar: AppBar(
//         title: const Text(
//           "Toyota",
//         ),
//         // backgroundColor: Colors.transparent,
//       ),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return ListView.builder(
//         padding: EdgeInsets.symmetric(
//             horizontal: width * 0.02, vertical: height * 0.01),
//         itemCount: brandsList.length,
//         itemBuilder: (context, index) {
//           var current = brandsList[index];
//           return InkWell(
//             onTap: () => navigatorKey.currentState!
//                 .push(MaterialPageRoute(builder: (_) => VehicleDetails(purchaseId: current.id,))),
//             child: Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               child: Container(
//                 height: 120,
//                 width: width,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.grey.shade500)),
//                 child: Row(
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       width: width * 0.55,
//                       padding: EdgeInsets.only(left: width * 0.04),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             current["year"],
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400, fontSize: 15),
//                           ),
//                           const SizedBox(
//                             height: 2,
//                           ),
//                           Text(
//                             current["name"],
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 18),
//                           ),
//                           const SizedBox(
//                             height: 4,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: width * 0.02),
//                             child: Row(
//                               children: [

//                                 Text(
//                                   current["kms"],
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14,
//                                       color: Colors.grey.shade600),
//                                 ),
//                                 SizedBox(
//                                   width: width * 0.02,
//                                 ),
//                                 Text(
//                                   current["fuel"],
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14,
//                                       color: Colors.grey.shade600),
//                                 ),
//                                 SizedBox(
//                                   width: width * 0.02,
//                                 ),
//                                 Text(
//                                   current["color"],
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14,
//                                       color: Colors.grey.shade600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 4,
//                           ),
//                           Text(
//                             current["price"],
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14,
//                                 color: Colors.grey.shade800),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                                 topRight: Radius.circular(20),
//                                 bottomRight: Radius.circular(20)),
//                             child:
//                                 // Image.asset("assets/sample2.png")
//                                 Image.network(current["image"])))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

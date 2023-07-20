import 'package:flutter/material.dart';

class BuyOrSellWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  final Color color;
  final double width;
  const BuyOrSellWidget(
      {super.key,
      required this.color,
      required this.imgUrl,
      required this.title,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 1,
      child: Container(
        width: width * 0.45,
        height: 200,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 21,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                imgUrl,
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget buyOrSellWidget(String imgUrl, String title, Color color,double width) {
//     return Material(
//       borderRadius: BorderRadius.circular(5),
//       elevation: 1,
//       child: Container(
//         width: width * 0.45,
//         height: 200,
//         decoration:
//             BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//               title,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 21,
//                   color: Colors.white),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Image.asset(
//                 imgUrl,
//                 fit: BoxFit.cover,
//                 width: 90,
//                 height: 90,
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

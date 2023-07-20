import 'package:flutter/material.dart';

class StepsForBuyingWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String subtitle;
  const StepsForBuyingWidget(
      {super.key,
      required this.imgUrl,
      required this.subtitle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imgUrl,
              // "assets/selectcar.jpeg",
              height: height * 0.13,
              width: width * 0.3,
            ),
          ),
        ),
        SizedBox(
          width: width * 0.12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // "Choose the perfect\nscar for you",
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                // "Browse through the cars and \nfind your perfect match",
                subtitle,
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: Colors.black54),
              ),
            ],
          ),
        )
      ],
    );
  }
}
// ///////steps for buying widget/////////////////////
//   Widget stepsForBuyingWidget(String imgUrl, String title, String subtitle,double height,double width) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.black45),
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15)),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Image.asset(
//               imgUrl,
//               // "assets/selectcar.jpeg",
//               height: height * 0.18,
//               width: width * 0.3,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: width * 0.12,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 // "Choose the perfect\nscar for you",
//                 title,
//                 style:
//                     const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 // "Browse through the cars and \nfind your perfect match",
//                 subtitle,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w300,
//                     fontSize: 13,
//                     color: Colors.black54),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

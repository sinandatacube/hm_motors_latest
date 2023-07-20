import 'package:flutter/material.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: shimmerWidget(height * 0.05, width * 0.3),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            shimmerWidget(50, width * 0.8),
            SizedBox(
              height: height * 0.05,
            ),
            shimmerWidget(height * 0.2, width * 0.8),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              width: width,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width * 0.03),
              child: shimmerWidget(height * 0.05, width * 0.3),
            ),
            GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                shrinkWrap: true,
                itemCount: 8,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: width * 0.03,
                    mainAxisSpacing: height * 0.02),
                itemBuilder: (context, index) {
                  return shimmerWidget(height * 0.05, width * 0.3);
                }),
            shimmerWidget(30, 70),
            Container(
              alignment: Alignment.centerLeft,
              width: width,
              child: shimmerWidget(40, 120),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => shimmerWidget(35, 60),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget shimmerWidget(double h, double w) {
  //   return Shimmer.fromColors(
  //     baseColor: Colors.grey.shade200,
  //     highlightColor: Colors.grey.shade400,
  //     direction: ShimmerDirection.ltr,
  //     period: const Duration(seconds: 1),
  //     child: Container(
  //       color: Colors.black,
  //       child: Container(
  //         height: h,
  //         width: w,
  //         // margin: EdgeInsets.symmetric(
  //         //     horizontal: width * 0.1, vertical: height * 0.01),
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //       ),
  //     ),
  //   );
  // }
}

// Widget shimmerLoading(double height, double width) {
//   return Scaffold(
//     appBar: AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,
//       title: shimmerWidget(height * 0.05, width * 0.3),
//     ),
//     body: Container(
//       height: height,
//       width: width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: height * 0.03,
//           ),
//           shimmerWidget(50, width * 0.8),
//           SizedBox(
//             height: height * 0.05,
//           ),
//           shimmerWidget(height * 0.2, width * 0.8),
//           SizedBox(
//             height: height * 0.05,
//           ),
//           Container(
//             width: width,
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.only(left: width * 0.03),
//             child: shimmerWidget(height * 0.05, width * 0.3),
//           ),
//           GridView.builder(
//               padding: EdgeInsets.symmetric(
//                   horizontal: width * 0.03, vertical: height * 0.02),
//               shrinkWrap: true,
//               itemCount: 6,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   childAspectRatio: 1.5,
//                   crossAxisSpacing: width * 0.03,
//                   mainAxisSpacing: height * 0.02),
//               itemBuilder: (context, index) {
//                 return shimmerWidget(height * 0.05, width * 0.3);
//               }),
//           shimmerWidget(30, 70)
//         ],
//       ),
//     ),
//   );
// }

Widget listShimmmerLoading(int length, BuildContext context) {
  return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
            height: 8,
            width: width,
          ),
      itemCount: length,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 00.02),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          width: width,
          height: 140,
          child: shimmerWidget(width, 140)));
}

Widget shimmerWidget(double h, double w) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.grey.shade400,
    direction: ShimmerDirection.ltr,
    period: const Duration(seconds: 1),
    child: Container(
      color: Colors.black,
      child: Container(
        height: h,
        width: w,
        // margin: EdgeInsets.symmetric(
        //     horizontal: width * 0.1, vertical: height * 0.01),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

Widget settingsShimmer(double height, double width) {
  return SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: shimmerWidget(120, 120),
            )
          ],
        ),
        SizedBox(
          child: shimmerWidget(120, 12),
        )
      ],
    ),
  );
}

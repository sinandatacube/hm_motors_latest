// import 'package:flutter/material.dart';
// import 'package:hm_motors/global_variables.dart';
// import 'package:hm_motors/list.dart';
// import 'package:hm_motors/view/vehicle_details.dart';

// class Search extends StatelessWidget {
//   const Search({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(context),
//       appBar: _buildAppbar(context),
//     );
//   }

//   AppBar _buildAppbar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.grey.shade100,
//       elevation: 2,
//       actions: [
//         IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
//         IconButton(
//             onPressed: () {
//               showFilter(context);
//             },
//             icon: const Icon(Icons.filter_alt))
//       ],
//       title: const TextField(
//         decoration: InputDecoration(border: InputBorder.none),
//       ),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.02,
//             ),
//             child: InkWell(
//               onTap: () {
//                 showFilter(context);
//               },
//               child: Container(
//                 height: 35,
//                 width: width,
//                 alignment: Alignment.centerLeft,
//                 decoration: BoxDecoration(
//                     border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade500))),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       "Filter",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           ListView.builder(
//               shrinkWrap: true,
//               keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric(horizontal: width * 0.03),
//               itemCount: expand.length,
//               itemBuilder: (context, index) {
//                 var current = expand[index];
//                 return InkWell(
//                   onTap: () {
//                     navigatorKey.currentState!.push(
//                         MaterialPageRoute(builder: (_) => VehicleDetails()));
//                   },
//                   child: Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Container(
//                       width: width,
//                       height: 140,
//                       padding: EdgeInsets.only(left: width * 0.04),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey.shade400),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(current["year"],
//                                     style: const TextStyle(color: Colors.grey)),
//                                 const SizedBox(
//                                   height: 2,
//                                 ),
//                                 Text(
//                                   current["name"],
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(
//                                   height: 6,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(right: width * 0.02),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(current["mileage"] + "kms"),
//                                       SizedBox(
//                                         width: width * 0.03,
//                                       ),
//                                       Text(current["color"]),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   current["price"],
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: width * 0.45,
//                             child: ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(5),
//                                     bottomRight: Radius.circular(5)),
//                                 child: Image.asset(
//                                   current["image"],
//                                   fit: BoxFit.cover,
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//         ],
//       ),
//     );
//   }

//   void showFilter(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         isScrollControlled: true,
//         builder: (
//           context,
//         ) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//             height: height * 0.9,
//             width: width,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text("Filter",
//                         style: TextStyle(
//                           fontSize: 17,
//                         )),
//                   ),
//                   const Divider(
//                     thickness: 1.5,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "Brand",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: brand.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(brand[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "Fuel",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: fule.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(fule[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "Year",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: fule.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(fule[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "Color",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: color.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(color[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "Transmission",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: transmission.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(transmission[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "No of owners",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: owners.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(owners[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02, vertical: height * 0.01),
//                     child: const Text(
//                       "Kms driven",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: width * 0.01),
//                     width: width,
//                     height: height * 0.07,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: kms.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(right: width * 0.01),
//                           child: FilterChip(
//                             label: Text(kms[index]),
//                             onSelected: (val) {},
//                             selected: false,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/model/search_model.dart';
import 'package:hm_motors/view/utitlities/error_page.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';
import 'package:hm_motors/view/vehicle_details.dart';

import '../global_functions.dart';
import '../global_variables.dart';
import '../url.dart';

class SearchField extends SearchDelegate<String> {
  SearchField({
    this.contextPage,
  });

  BuildContext? contextPage;

  @override
  String get searchFieldLabel => "Search cars";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (query.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return FutureBuilder(
          future: ApiController().search(query),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (data == "No Cars found") {
                return buildNoMatch(width, height, context);
              } else {
                MainSearchModel data2 = MainSearchModel.fromJson(data);
                // print("data2");
                // print(data2);
                return ListView.builder(
                    shrinkWrap: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    // physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    itemCount: data2.cars.length,
                    itemBuilder: (context, index) {
                      var current = data2.cars[index];
                      String price = MoneyFormat().moneyFormat(current.price);
                      return InkWell(
                        onTap: () {
                          navigatorKey.currentState!.push(MaterialPageRoute(
                              builder: (_) => VehicleDetails(
                                    purchaseId: current.id,
                                    thumbImage: current.imgUrl,
                                  )));
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            width: width,
                            height: width > 600 ? 200 : 140,
                            padding: EdgeInsets.only(left: width * 0.04),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(current.year,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${current.brand} ${current.model} ${current.varient}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${current.kms} kms",
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            Text(
                                              current.color,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        price,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      child: CachedNetworkImage(
                                        memCacheWidth: 500,
                                        imageUrl:
                                            budgetImagePath + current.imgUrl,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(errorImageUrl),
                                        placeholder: (context, url) =>
                                            Image.asset(placeholderImageUrl),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            } else if (snapshot.hasError) {
              var error = snapshot.error;
              if (error == "Socket error") {
                return const NoNetwork();
              } else {
                return const ErrorPage();
              }
            } else {
              return loadingAnimation();
            }
          });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Container();
  }

  Widget buildNoMatch(double width, double height, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/noResultFound.png",
            height: height * 0.13,
          ),
          Text("sorry!",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600)),
          Text("No result found",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

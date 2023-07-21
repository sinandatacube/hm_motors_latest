import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/controller/api_controller.dart';
import 'package:hm_motors/custom_widgets/budget_widget.dart';
import 'package:hm_motors/custom_widgets/homepage_widgets/ads_slider.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/help/help.dart';
import 'package:hm_motors/model/homepage_model.dart';
import 'package:hm_motors/model/wishlist_model.dart';
import 'package:hm_motors/provider/homepage_provider.dart';
import 'package:hm_motors/view/notifications.dart';
import 'package:hm_motors/view/utitlities/money_format.dart';
import 'package:hm_motors/view/utitlities/no_network.dart';
import 'package:hm_motors/view/utitlities/notification.dart';
import 'package:hm_motors/view/vehicle_details.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../controller/dynamic_link_handler.dart';
import '../custom_widgets/homepage_widgets/shimmer_widget.dart';
import '../custom_widgets/homepage_widgets/steps_for_buying_widget.dart';
import '../global_functions.dart';
import '../url.dart';
import 'car_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final scrollDirection = Axis.horizontal;

  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    getUserNumber();
    DynamicLinkHandler().handleDynamicLink();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);

    NotificationServices().setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomePageProvider>().init();
    });

    return FutureBuilder(
        future: ApiController().homepageCall(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            MainWishListModel newArrivals = snapshot.data["mostSearch"];
            MainHomePageModel data = snapshot.data["data"];
            List data2 = snapshot.data["budget"];
            List data3 = [
              data.budget1,
              data.budget2,
              data.budget3,
              data.budget4,
              data.budget5
            ];
            // List data3 = [];
            // if (data.budget1.isNotEmpty) data3.add(data.budget1);
            // if (data.budget2.isNotEmpty) data3.add(data.budget2);
            // if (data.budget3.isNotEmpty) data3.add(data.budget3);
            // if (data.budget4.isNotEmpty) data3.add(data.budget4);
            // if (data.budget5.isNotEmpty) data3.add(data.budget5);
            // for (var i = 0; i < data2.length; i++) {
            //   if (data3[i].isEmpty) data2.removeAt(i);
            // }
            return Scaffold(
                key: scaffoldKey,
                // drawer: const NavDrawer(),
                appBar: _buildAppBar(),
                backgroundColor: Colors.white,
                floatingActionButton: floatButton(),
                body: _buildbody(context, data, data2, data3, newArrivals));
          } else if (snapshot.hasError) {
            var error = snapshot.error;
            if (error == "Socket error") {
              return const NoNetwork();
            } else {
              return const Text("Error");
            }
          } else {
            return const ShimmerLoading();
            //  listShimmmerLoading(5, context);
            // const
          }
        });
  }

//////////////////////////////////////apppbar/////////////////////////////////////////////////////////////////////

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      // leading: IconButton(
      //     onPressed: () {
      //       scaffoldKey.currentState?.openDrawer();
      //     },
      //     icon: const Icon(Icons.menu)),
      title: Image.asset(
        "assets/hm-01.png",
        // height: height * 0.1,
        height: height * 0.045,
        width: width * 0.3,
      ),
      actions: [
        isSkip
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: () {
                  navigate(const Notifications(), false);
                },
                icon: const Icon(Icons.notifications)),
        IconButton(
            onPressed: () {
              navigate(const Help(), false);
            },
            icon: const Icon(Icons.help_outline_sharp))
      ],
    );
  }

//////////////////////////////////////body/////////////////////////////////////////////////////////////////////

  Widget _buildbody(BuildContext context, MainHomePageModel data, List data2,
      List data3, MainWishListModel newArrivals) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          //////////////////search box////////////////////////////////////////////////////////////////////////
          OutlinedButton.icon(
            onPressed: () => showSearches(context),
            icon: const Icon(Icons.search),
            label: const Text(
              "Search",
              style: TextStyle(
                fontFamily: "Rubik",
              ),
            ),
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: Colors.grey.shade50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(width * 0.85, 50),
                alignment: Alignment.centerLeft),
          ),
          // GestureDetector(
          //   onTap: () => navigatorKey.currentState!
          //       .push(MaterialPageRoute(builder: (_) => const Search())),
          //   child: Card(
          //     elevation: 1,
          //     margin: EdgeInsets.symmetric(
          //         horizontal: width * 0.1, vertical: height * 0.01),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(5)),
          //     child: Container(
          //       width: width,
          //       height: 50,
          //       // margin: EdgeInsets.symmetric(
          //       //     horizontal: width * 0.1, vertical: height * 0.01),
          //       padding: const EdgeInsets.only(left: 15),
          //       decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey.shade400),
          //           // boxShadow: [
          //           //   BoxShadow(
          //           //     color: Colors.grey.shade600,
          //           //     blurRadius: 3,
          //           //   ),
          //           // ],
          //           color: Colors.white70,
          //           borderRadius: BorderRadius.circular(5)),
          //       child: Row(
          //         children: const [
          //           Icon(Icons.search),
          //           Text(
          //             "Search",
          //             style: TextStyle(fontFamily: "Rubik"),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          /////////////////////////////////ads///////////////////////////////
          data.offerwall.isEmpty
              ? const SizedBox.shrink()
              : AdsSlider(imagesList: data.offerwall),

          ///////////////sell or buy car//////////
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     buyOrSellWidget("assets/buyCar1.jpg", "Buy car",
          //         Color.fromARGB(255, 59, 111, 223)),
          //     buyOrSellWidget("assets/sellcar.jpg", "Sell car",
          //         Color.fromARGB(255, 140, 44, 230)),
          //   ],
          // )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     buyOrSellWidget("assets/buyCar1.jpg", "Buy car",
          //         const Color.fromARGB(255, 88, 128, 214)),
          //     SizedBox(
          //       // height: height * 0.02,
          //       height: 25,
          //     ),
          //     buyOrSellWidget("assets/sellcar.jpg", "Sell car",
          //         const Color.fromARGB(255, 150, 83, 212)),
          //   ],
          // // ),
          // const SizedBox(
          //   // height: height * 0.02,
          //   height: 15,
          // ),

          ///////////////////////////////popular brands//////////////////////////////////////////////////////////
          Container(
            width: width,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.01),
            child: const Text(
              "Popular Brands",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Rubik"),
            ),
          ),
          Consumer<HomePageProvider>(builder: (context, value, child) {
            return GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                shrinkWrap: true,
                itemCount: value.brandsViewAll
                    ? data.brands.length
                    : data.brands.length < 8
                        ? data.brands.length
                        : 8,

                //  value.brandsViewAll ? data.brands.length :

                //  6,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: width * 0.03,
                    mainAxisSpacing: height * 0.02),
                itemBuilder: (context, index) {
                  var current = data.brands[index];

                  return InkWell(
                    onTap: () => navigate(
                        CarList(
                            brandId: current.brandId,
                            brandName: current.brandName),
                        false),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.shade500, width: 0.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 2,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: SizedBox(
                                  width: width,
                                  child: CachedNetworkImage(
                                    memCacheWidth: 200,
                                    imageUrl: brandImagePath + current.imgUrl,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(errorImageUrl),
                                    placeholder: (context, url) =>
                                        Image.asset(placeholderImageUrl),
                                    //         errorBuilder: (context, error, stackTrace) =>
                                    //     Image.asset(errorImageUrl),
                                    // loadingBuilder: (context, child, loadingProgress) {
                                    //   if (loadingProgress == null) {
                                    //     return child;
                                    // }
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            current.brandName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: "Rubik",
                                fontSize: 9,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
          data.brands.length <= 8
              ? const SizedBox.shrink()
              : Consumer<HomePageProvider>(builder: (context, value, child) {
                  return TextButton(
                      onPressed: () => value.updateBrandsViewAll(),
                      child: Container(
                        width: 70,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value.brandsViewAll ? "Less" : "More",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontFamily: "Rubik"),
                            ),
                            Icon(
                              value.brandsViewAll
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              size: 20,
                              color: Colors.grey.shade500,
                            )
                          ],
                        ),
                      ));
                }),
          //////////////////////new arrivals////////////////////////////
          if (newArrivals.cars.isNotEmpty)
            Container(
              width: width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                top: height * 0.02,
                left: width * 0.03,
              ),
              child: const Text(
                "New Arrivals",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: "Rubik"),
              ),
            ),
          if (newArrivals.cars.isNotEmpty)
            SizedBox(
              height: 230,
              width: width,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.02),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: newArrivals.cars.length,
                  itemBuilder: (context, index) {
                    var current = newArrivals.cars[index];
                    String price = MoneyFormat().moneyFormat(current.price);
                    return InkWell(
                      onTap: () => navigate(
                          VehicleDetails(
                              purchaseId: current.id,
                              thumbImage: current.image),
                          false),
                      child: Card(
                        elevation: 1,
                        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(5)),
                                  child: CachedNetworkImage(
                                    memCacheWidth: 300,
                                    imageUrl: budgetImagePath + current.image,
                                    height: 150,
                                    width: 180,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(errorImageUrl),
                                    placeholder: (context, url) =>
                                        Image.asset(placeholderImageUrl),
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.03, vertical: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "${current.brand} ${current.model}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      price,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          //////////////////////////////////// cars by budget /////////////////////////////////////
          const SizedBox(
            // height: height * 0.02,
            height: 15,
          ),
          Container(
            width: width,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: const Text(
              "Cars by budget",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Rubik"),
            ),
          ),
          const SizedBox(
            // height: height * 0.02,
            height: 15,
          ),
          SizedBox(
            width: width,
            height: 30,
            child: Consumer<HomePageProvider>(builder: (context, value, child) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data2.length,
                itemBuilder: (context, index) =>
                    //  data3[index].isNotEmpty ?
                    GestureDetector(
                  onTap: () {
                    context
                        .read<HomePageProvider>()
                        .updatebudgetCarsIndex(index);
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  //  context
                  //     .read<HomePageProvider>()
                  //     .updatebudgetCarsIndex(index),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: value.budgetCarsIndex == index
                          ? Colors.grey.shade300
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Text(
                      data2[index],
                      style: const TextStyle(fontSize: 13, fontFamily: "Rubik"),
                    ),
                  ),
                )
                // : const SizedBox.shrink()
                ,
              );
            }),
          ),
          const SizedBox(
            // height: height * 0.02,
            height: 15,
          ),
          SizedBox(
            width: width,
            // height: width > 600
            //     ? height * 0.47
            //     : height > 800
            //         ? height * 0.5
            //         : height * 0.61,
            height: 480,
            child: Consumer<HomePageProvider>(builder: (context, value, child) {
              // print("Device width $width");
              // print("Device height $height");
              return PageView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: scrollDirection,
                // controller: controller,
                controller: _pageController,
                onPageChanged: (val) {
                  context.read<HomePageProvider>().updatebudgetCarsIndex(val);
                },
                children: <Widget>[
                  ...List.generate(data3.length, (index) {
                    // var current = budgetdetail[index];
                    // selectedMarkerIndex = current;

                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: controller,
                      index: index,
                      highlightColor: Colors.black.withOpacity(0.1),

                      child: BudgetWidget(items: data3[index]),
                      //  Container(
                      //   height: 100,
                      //   color: Colors.red,
                      //   margin: EdgeInsets.all(10),
                      //   child: Center(child: Text('index: $index')),
                      // ),
                      // child:
                    );
                  }),
                ],
              );
            }),
          ),
          /////////////////////////steps for buy//////////////////////////////////////
          ///
          Container(
            width: width,
            color: Colors.orange.shade100,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: height * 0.02, left: width * 0.03),
            child: const Text(
              "Easy steps for buying car",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: "Rubik"),
            ),
          ),
          Container(
            width: width,
            color: Colors.orange.shade100,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.04),
              // scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                StepsForBuyingWidget(
                  imgUrl: "assets/selectcar.jpeg",
                  title: "Choose the perfect\ncar for you",
                  subtitle:
                      "Browse through the cars and \nfind your perfect match",
                ),
                SizedBox(
                  height: 7,
                ),
                StepsForBuyingWidget(
                  imgUrl: "assets/hands.png",
                  title: "Test Drive the car",
                  subtitle: "Visit our store and\nexperience the car",
                ),
                SizedBox(
                  height: 7,
                ),
                StepsForBuyingWidget(
                  imgUrl: "assets/makeityours.jpeg",
                  title: "Make it yours",
                  subtitle: "Make the car yours by \nfinancing or pay in full",
                ),
              ],
            ),
          ),
          //////////////////////////////////////// why buy from us///////////////////////////////////////////////
          // Container(
          //   width: width,
          //   color: Colors.blue.shade50,
          //   height: 100,
          //   child: Column(
          //     children: [
          //       Container(
          //         width: width,
          //         alignment: Alignment.centerLeft,
          //         padding:
          //             EdgeInsets.only(top: height * 0.02, left: width * 0.03),
          //         child: Text(
          //           "Why buy from us?",
          //           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  FloatingActionButton floatButton() {
    return FloatingActionButton(
      onPressed: () {
        Help().launchWhatsapp();
      },
      child: Image.asset("assets/whatsapp.png"),
    );
  }
}

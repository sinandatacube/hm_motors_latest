import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/view/home_page.dart';
import 'package:hm_motors/view/sell_car.dart';
import 'package:hm_motors/view/settings.dart';
import 'package:hm_motors/view/wishlist.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  List tabs = [
    const HomePage(),
    const SellCar(),
    const WishList(),
    const Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (isSkip) {
            SystemNavigator.pop();
          } else {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  'Are you sure you want to leave?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'No',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        // willLeave = true;
                        // Navigator.of(context).pop();
                        SystemNavigator.pop();
                      },
                      child: Text('yes',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)))
                ],
              ),
            );
          }

          return false;
        },
        child:
            Scaffold(bottomNavigationBar: bottom1(), body: tabs[currentPage]));
  }

  Widget bottom1() {
    return SalomonBottomBar(
      currentIndex: currentPage,
      onTap: (i) => setState(() => currentPage = i),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Home"),
          selectedColor: mainColor,
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.car_rental),
          title: const Text("Sell Car"),
          selectedColor: mainColor,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: const Icon(Icons.favorite_border),
          title: const Text("Favourite"),
          selectedColor: mainColor,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: const Icon(Icons.settings),
          title: const Text("Settings"),
          selectedColor: mainColor,
        ),
      ],
    );
  }

  Widget bottom() {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: Icons.home, title: "Home", onclick: () {}),
        TabData(iconData: Icons.search, title: "Search", onclick: () {}),
        TabData(
            iconData: Icons.car_rental_outlined,
            title: "Sell Car",
            onclick: () {}),
        TabData(iconData: Icons.person, title: "Profile", onclick: () {}),
      ],
      initialSelection: 1,
      onTabChangedListener: (position) {
        setState(() {
          currentPage = position;
        });
      },
    );
  }
}

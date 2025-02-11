import 'package:final_pro/pages/Home.dart';
import 'package:final_pro/pages/Order.dart';
import 'package:final_pro/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'home1.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;
  late Home1 home1Page;
  late Order orderPage;
  late Profile profilePage;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    home1Page = Home1();
    orderPage = Order();
    profilePage = Profile();
    pages = [home1Page, orderPage, profilePage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.brown,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

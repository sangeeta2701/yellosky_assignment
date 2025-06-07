import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellosky_assignment/Screens/Tabs/home_screen.dart';
import 'package:yellosky_assignment/Screens/Tabs/map_screen.dart';
import 'package:yellosky_assignment/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, });
  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<IconData> iconList = [
    // CupertinoIcons.home,
    // CupertinoIcons.map,
    Icons.home_outlined,
    Icons.location_on_outlined
    
  ];
  int _bottomNavIndex = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    pages = [
      HomeScreen(
        
      ),
      MapScreen(),
      
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: wColor,
        body: pages[_bottomNavIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeColor,
          shape: CircleBorder(),
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: wColor,
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: bgColor,
          icons: iconList,
          activeColor: themeColor,
          inactiveColor: gColor,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) {
            setState(() => _bottomNavIndex = index);
          },
          //other params
        ));
  }
}
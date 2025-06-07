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
       
        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //   elevation: 1,
        //   backgroundColor: wColor,
        //   icons: iconList,
        //   activeColor: themeColor,
        //   inactiveColor: gColor,
        //   activeIndex: _bottomNavIndex,
        //   gapLocation: GapLocation.center,
        //   notchSmoothness: NotchSmoothness.verySmoothEdge,
        //   leftCornerRadius: 32,
        //   rightCornerRadius: 32,
        //   onTap: (index) {
        //     setState(() => _bottomNavIndex = index);
        //   },
         
        // ),
        bottomNavigationBar: Container(
  decoration: BoxDecoration(
    color: wColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 2,
        blurRadius: 10,
        offset: Offset(0, -3), // shadow upwards
      ),
    ],
  ),
  child: AnimatedBottomNavigationBar(
    elevation: 0, // remove default elevation since shadow is manually added
    backgroundColor: Colors.transparent, // transparent to let container bg show
    icons: iconList,
    iconSize: 30,
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
  ),
),

        );
  }
}
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yellosky_assignment/Screens/Tabs/chart_screen.dart';
import 'package:yellosky_assignment/Screens/Tabs/home_screen.dart';
import 'package:yellosky_assignment/Screens/Tabs/map_screen.dart';
import 'package:yellosky_assignment/utils/colors.dart';
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key, });
  

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   List<IconData> iconList = [
//     // CupertinoIcons.home,
//     // CupertinoIcons.map,
//     Icons.home_outlined,
//     Icons.location_on_outlined,
//     Icons.bar_chart_outlined
    
//   ];
//   int _bottomNavIndex = 0;

//   List<Widget> pages = [];

//   @override
//   void initState() {
//     pages = [
//       HomeScreen(
        
//       ),
//       MapScreen(),
//       ChartScreen(),
      
//     ];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: wColor,
//         body: pages[_bottomNavIndex],
       
//         bottomNavigationBar: Container(
//   decoration: BoxDecoration(
//     color: wColor,
//     borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(24),
//       topRight: Radius.circular(24),
//     ),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.1),
//         spreadRadius: 2,
//         blurRadius: 10,
//         offset: Offset(0, -3), // shadow upwards
//       ),
//     ],
//   ),
//   child: AnimatedBottomNavigationBar(
//     elevation: 0, 
//     backgroundColor: Colors.transparent,
//     icons: iconList,
//     iconSize: 30,
//     activeColor: themeColor,
//     inactiveColor: gColor,
//     activeIndex: _bottomNavIndex,
//     // gapLocation: GapLocation.center,
//     notchSmoothness: NotchSmoothness.verySmoothEdge,
//     leftCornerRadius: 32,
//     rightCornerRadius: 0,
//     onTap: (index) {
//       setState(() => _bottomNavIndex = index);
//     },
//   ),
// ),

//         );
//   }
// } 


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MapScreen(),
    ChartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      body: _pages[_selectedIndex],
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
    ],),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: themeColor,
          selectedItemColor: wColor,
          unselectedItemColor: gColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Chart',
            ),
          ],
        ),
      ),
    );
  }
}
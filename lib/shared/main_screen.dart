import 'package:flutter/material.dart';

import '../screens/asset_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import 'const.dart';

class MainScreeen extends StatefulWidget {
  MainScreeen({Key? key}) : super(key: key);

  @override
  State<MainScreeen> createState() => _MainScreeenState();
}

class _MainScreeenState extends State<MainScreeen> {
  int _selectedIndex = 0;
  final _layoutPage = [HomeScreen(), AssetScreen(), ProfileScreen()];
  void _onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 40,
              ),
              backgroundColor: grey,
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.play_circle,
                size: 40,
              ),
              backgroundColor: grey,
              label: 'Assets'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_sharp,
                size: 40,
              ),
              backgroundColor: grey,
              label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: orange,
        onTap: _onTabItem,
      ),
    );
  }
}

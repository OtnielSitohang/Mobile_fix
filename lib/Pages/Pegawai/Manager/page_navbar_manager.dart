import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Pages/Pegawai/Manager/page_manager_profile.dart';

import 'home_manager.dart';

class NavbarManager extends StatefulWidget {
  const NavbarManager({super.key});

  @override
  State<NavbarManager> createState() => _NavbarManagerState();
}

class _NavbarManagerState extends State<NavbarManager> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Kelas Hari Ini ',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        HomeManager(),
        ProfileManager(),
      ][currentPageIndex],
    );
  }
}

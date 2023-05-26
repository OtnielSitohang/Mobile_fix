import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/indexInstruktur.dart';
import 'package:gofid_mobile_fix/Pages/Instruktur/profileInstruktur.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeInstruktur extends StatefulWidget {
  const HomeInstruktur({super.key});

  @override
  State<HomeInstruktur> createState() => _HomeInstrukturState();
}

class _HomeInstrukturState extends State<HomeInstruktur> {
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
            label: 'Booking',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.bookmark),
          //   icon: Icon(Icons.bookmark_border),
          //   label: 'Saved',
          // ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        IndexInstruktur(),
        ProfileInstruktur(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

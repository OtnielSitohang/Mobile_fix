import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Pages/Member/HistoryMember/history_kelas_member.dart';
import 'package:gofid_mobile_fix/Pages/Member/Profile/profile_member.dart';
import 'package:gofid_mobile_fix/Pages/Member/index_member.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeMember extends StatefulWidget {
  const HomeMember({super.key});

  @override
  State<HomeMember> createState() => _HomeMemberState();
}

class _HomeMemberState extends State<HomeMember> {
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
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history),
            label: 'Hisotry',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        IndexMember(),
        HistoryKelasPage(),
        ProfileMember(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

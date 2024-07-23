// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gotaps/view/connection/connection2.dart';
import 'package:gotaps/view/profile/profile.dart';
import 'package:gotaps/view/settings/settings.dart';
import 'package:gotaps/view/share/share.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> pagelist = [
    const Profile(),
    const Connection2(),
    const Share(),
    const Settings(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagelist.elementAt(
        _selectedIndex,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          selectedFontSize: 13,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          unselectedItemColor: const Color(0xFF9AA0A6),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/Profile.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/Profile.svg",
                color: Colors.black,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/Connection.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/Connection.svg",
                color: Colors.black,
              ),
              label: 'Connection',
            ),
            /* BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/Scan.svg"),
              ),
              label: '',
            ),*/
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/Share.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/Share.svg",
                color: Colors.black,
              ),
              label: 'Share',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/Settings.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/Settings.svg",
                color: Colors.black,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

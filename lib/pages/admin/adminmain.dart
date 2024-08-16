import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adminhome_page.dart';
import 'adminprofile_page.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  //late List<User> users;

  final screens = [
    const AdminHomePageScreen(),
    const AdminProfile(),
  ];

  /* void initState() {
    users = User.getUsers();
    super.initState();
  }*/

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.logout, size: 30),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xffC4A195),
        height: 60,
        index: index,
        items: items,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}

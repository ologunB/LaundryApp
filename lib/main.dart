import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'E_Libs/bottom_bar.dart';
import 'Pages/home_page.dart';
import 'Pages/laundry_page.dart';
import 'Pages/orders_page.dart';
import 'Pages/profile_page.dart';

main() {
  runApp(new MaterialApp(
    home: MyApp(),
    theme: ThemeData(fontFamily: 'Raleway'),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

int pageSelectedIndex = 0;

class _MyAppState extends State<MyApp> {
  final List<Widget> pages = [
    HomePage(
      key: PageStorageKey('Page1'),
    ),
    LaundryPage(
      key: PageStorageKey('Page2'),
    ),
    OrdersPage(
      key: PageStorageKey('Page3'),
    ),
    ProfilePage(
      key: PageStorageKey('Page4'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: pages[pageSelectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index) => setState(() {
          pageSelectedIndex = index;
        }),
        iconSize: 27,
        selectedIndex: pageSelectedIndex,
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ),
              inactiveColor: Colors.black38,
              activeColor: Colors.indigo),
          BottomNavyBarItem(
              icon: Icon(Icons.local_laundry_service),
              title: Text(
                "Laundry",
                style: TextStyle(fontSize: 20),
              ),
              inactiveColor: Colors.black38,
              activeColor: Colors.indigo),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_basket),
              inactiveColor: Colors.black38,
              title: Text(
                "Orders",
                style: TextStyle(fontSize: 20),
              ),
              activeColor: Colors.indigo),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 20),
              ),
              inactiveColor: Colors.black38,
              activeColor: Colors.indigo)
        ],
      ),
    );
  }
}

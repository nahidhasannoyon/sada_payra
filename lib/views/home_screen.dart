import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sada_payra/views/profile.dart';

import 'bus_schedule/down_trips_body.dart';
import 'bus_schedule/up_trips_body.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int _index = 0;
  final _screenBody = [
    const UpTripBody(),
    const DownTripBody(),
    const ProfileBody(),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Center(
            child: Text('Sada Payra'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
          elevation: 5,
        ),
        body: _screenBody[_index],
        bottomNavigationBar: CurvedNavigationBar(
          height: size.height * 0.1,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          items: [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.location_city_outlined,
                size: size.height * 0.04,
              ),
              label: 'Up-Trips',
              labelStyle: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.house_outlined,
                size: size.height * 0.04,
              ),
              label: 'Down-Trips',
              labelStyle: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.camera_front_rounded,
                size: size.height * 0.04,
              ),
              label: 'Profile',
              labelStyle: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          index: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          color: Theme.of(context).colorScheme.secondary,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

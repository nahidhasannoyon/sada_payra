import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import 'down_trips_body.dart';
import 'up_trips_body.dart';

class BusScheduleScreen extends StatefulWidget {
  static const routeName = '/bus-schedule';

  const BusScheduleScreen({super.key});

  @override
  State<BusScheduleScreen> createState() => _BusScheduleScreenState();
}

class _BusScheduleScreenState extends State<BusScheduleScreen> {
  static int _index = 0;
  final _screenBody = [
    const UpTripBody(),
    const DownTripBody(),
  ];

  final List<CurvedNavigationBarItem> _navbarItems = [
    const CurvedNavigationBarItem(
      child: Icon(Icons.location_city_outlined),
      label: 'Up-Trips',
    ),
    const CurvedNavigationBarItem(
      child: Icon(Icons.house_outlined),
      label: 'Down-Trips',
    ),
  ];
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: const Center(child:   Text('Sada Payra'),),
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
          height: 75,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          // buttonBackgroundColor: Colors.red,
          items: _navbarItems,
          index: _index,
          // height: 75,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          color: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

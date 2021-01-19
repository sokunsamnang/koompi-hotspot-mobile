import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/home_page.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/buy_plan.dart';
import 'package:koompi_hotspot/src/screen/map/MyLocationView.dart';
import 'package:koompi_hotspot/src/screen/option_page/more_page.dart';
import 'package:koompi_hotspot/src/screen/speedtest/speedtest.dart';
import 'package:koompi_hotspot/src/services/network_status.dart';
import 'package:line_icons/line_icons.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MyLocationView(),
    SpeedTestNet(),
    MorePage(),
  ];

  NetworkStatus _networkStatus = NetworkStatus();
  
  @override
  void initState(){
    super.initState();
    internet();
    
  }

  void internet() async {
    _networkStatus.connectivityResult = await Connectivity().checkConnectivity();
    _networkStatus.connectivitySubscription = _networkStatus.connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        _networkStatus.connectivityResult = event;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: _networkStatus.connectivityResult != ConnectivityResult.none ? Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.map,
                    text: 'Map',
                  ),
                  GButton(
                    icon: FontAwesome.wifi,
                    text: 'Speed Test',
                  ),
                  GButton(
                    icon: LineIcons.bars,
                    text: 'More',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ) : _networkStatus.noNetwork(context),
    );
  }
}

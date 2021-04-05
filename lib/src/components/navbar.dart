import 'package:koompi_hotspot/all_export.dart';

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

  @override
  void dispose(){
    super.dispose();
    _networkStatus.connectivitySubscription.cancel();
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
    var _lang = AppLocalizeService.of(context);
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
                    text: _lang.translate('home'),
                  ),
                  GButton(
                    icon: LineIcons.map,
                    text: _lang.translate('map'),
                  ),
                  GButton(
                    icon: Icons.wifi_outlined,
                    text: _lang.translate('speed_test'),
                  ),
                  GButton(
                    icon: LineIcons.bars,
                    text: _lang.translate('more'),
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

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:koompi_hotspot/all_export.dart';

class NetworkStatus {

  
  final Connectivity connectivity = Connectivity();
  var connectivityResult;
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  
  Widget noNetwork(BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: FlareActor(
              'assets/animations/lost_network.flr',
              animation: 'no_network',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 30),
          Text('No Internet Connection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 10),
          Text('Please check your internet connection and try again.'),
        ],
      ),
    );
  }

  Widget restartApp(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FlareActor(
                'assets/animations/lost_network.flr',
                animation: 'no_network',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30),
            Text('No Internet Connection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            Text('Please check your internet connection and try again.'),
            SizedBox(height: 10),
            Center(
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF17ead9),
                        Color(0xFF6078ea)
                      ]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => App()),
                          ModalRoute.withName('/'),
                        );
                      },  
                      child: Center(
                        child: Text("Try Again",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


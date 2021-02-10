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
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => App()),
                ModalRoute.withName('/'),
              );
            },
            child: const Text('Try Again', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
  
}


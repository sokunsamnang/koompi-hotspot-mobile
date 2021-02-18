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
  
  Widget captivePortal(BuildContext context){
    final flutterWebViewPlugin = FlutterWebviewPlugin();
    const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

    String selectedUrl = 'connectivitycheck.gstatic.com/generate_204';

    // ignore: prefer_collection_literals
    final Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'Print',
          onMessageReceived: (JavascriptMessage message) {
            print('Logs: ${message.message}');
          }),
    ].toSet();

    return WillPopScope(
      onWillPop: () async{
        flutterWebViewPlugin.close();
        return Navigator.canPop(context);
      },
      child: WebviewScaffold(
        url: selectedUrl,
        withJavascript: true,
        javascriptChannels: jsChannels,
        userAgent: kAndroidUserAgent,
        withLocalUrl: true,
        allowFileURLs: true,
        withLocalStorage: true,
        hidden: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Hotspot Login', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  flutterWebViewPlugin.close();
                  Navigator.pop(context);
                });
          }),
        ),
        ignoreSSLErrors: true,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  flutterWebViewPlugin.goBack();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  flutterWebViewPlugin.goForward();
                },
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: () {
                  flutterWebViewPlugin.reload();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}


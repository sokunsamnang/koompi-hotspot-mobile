import 'package:koompi_hotspot/all_export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class CaptivePortalWeb extends StatefulWidget {
  @override
  _CaptivePortalWebState createState() => _CaptivePortalWebState();
}
class _CaptivePortalWebState extends State<CaptivePortalWeb> {

  InAppWebViewController webView;

  String url = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InAppWebView")
      ),
      body: Container(
          child: Column(children: <Widget>[
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrl: "https://hotspot.koompi.pi/hotspotlogin.php?res=notyet&uamip=172.16.1.1&uamport=3990&challenge=95af4b58d43e1e9e83ab467b6ab0738c&called=01&mac=34-41-5D-83-E0-4B&ip=172.16.1.12&ssid=Koompi-wifi&nasid=nas01&sessionid=161285869000000001&userurl=http%3a%2f%2fconnectivitycheck.gstatic.com%2f&md=454E6FBF87E667C84A4346A074B59FDE",
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
                    )
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onReceivedServerTrustAuthRequest: (InAppWebViewController controller, ServerTrustChallenge challenge) async {
                    return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                  },
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
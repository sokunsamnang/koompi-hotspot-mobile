import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/utils/auto_login_hotspot_constants.dart'
    as global;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

String selectedUrl = 'http://connectivitycheck.android.com/generate_204';
String otherUrl = 'https://koompi.com/';

class CaptivePortalWeb extends StatefulWidget {
  @override
  _CaptivePortalWebState createState() => _CaptivePortalWebState();
}

class _CaptivePortalWebState extends State<CaptivePortalWeb> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  String url = "";
  final urlController = TextEditingController();

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
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('login_hotspot'),
            style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              });
        }),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return Navigator.canPop(context);
        },
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(selectedUrl)),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStart: (controller, url) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            return new ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
          },
          onLoadResource: (controller, url) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            setState(() {
              global.phone = prefs.getString('phone');
              global.password = prefs.getString('password');

              controller.evaluateJavascript(source: '''
                document.getElementById("user").value="${global.phone}";
                document.getElementById("password").value="${global.password}";
                document.getElementById("btnlogin").click();
              ''');
            });
          },
          onLoadStop: (controller, url) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            setState(() {
              global.phone = prefs.getString('phone');
              global.password = prefs.getString('password');

              this.url = url.toString();
              urlController.text = this.url;
              controller.evaluateJavascript(source: '''
                document.getElementById("user").value="${global.phone}";
                document.getElementById("password").value="${global.password}";
                document.getElementById("btnlogin").click();
              ''');
            });
          },
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
        ),
      ),
    );
  }
}

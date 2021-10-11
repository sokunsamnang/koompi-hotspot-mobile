import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/utils/auto_login_hotspot_constants.dart' as global;

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'http://connectivitycheck.android.com/generate_204';
String otherUrl = 'https://koompi.com/';
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print('Logs: ${message.message}');
      }),
].toSet();

class CaptivePortalWeb extends StatefulWidget {
  @override
  _CaptivePortalWebState createState() => _CaptivePortalWebState();
}
class _CaptivePortalWebState extends State<CaptivePortalWeb> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onchanged; 

  @override
  void initState() { 
    super.initState();
    _onchanged = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if(state.type == WebViewState.finishLoad){ // if the full website page loaded
          print('web laoded');
          flutterWebViewPlugin.evalJavascript('document.getElementById("user").value="${global.phone}"'); // Replace with the id of username field
          flutterWebViewPlugin.evalJavascript('document.getElementById("password").value="${global.password}"'); // Replace with the id of password field
          flutterWebViewPlugin.evalJavascript('document.getElementById("btnlogin").click()');  // Replace with Submit button id
          flutterWebViewPlugin.dispose();
        }else if (state.type== WebViewState.abortLoad){ // if there is a problem with loading the url
          print("there is a problem...");
        } else if(state.type== WebViewState.startLoad){ // if the url started loading
          print("start loading...");
        }
      }
    });
  }

  @override
  void dispose() {
    _onchanged.onDone(() {
      _onchanged.cancel();
    });
    
    flutterWebViewPlugin.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return WillPopScope(
      onWillPop: () async{
        return Navigator.canPop(context);
      },
      child: WebviewScaffold(
        url: selectedUrl,
        withJavascript: true,
        javascriptChannels: jsChannels,
        userAgent: kAndroidUserAgent,
        withZoom: true,
        useWideViewPort: true,
        displayZoomControls:true,
        withOverviewMode: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(_lang.translate('login_hotspot'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
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
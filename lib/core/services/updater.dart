import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=com.koompi.hotspot';

versionCheck(context) async {
  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  //Get Latest version info from firebase config
  final RemoteConfig remoteConfig = RemoteConfig.instance;

  var _lang = AppLocalizeService.of(context);

  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetch();
    await remoteConfig.activate();
    remoteConfig.getString('force_update_current_version');
    double newVersion = double.parse(remoteConfig
        .getString('force_update_current_version')
        .trim()
        .replaceAll(".", ""));
    if (newVersion > currentVersion) {
      print('New version available');
      await Components.dialogUpdateApp(
        context,
        Text(_lang.translate('msg_update'), textAlign: TextAlign.center),
        Text(
          _lang.translate('title_update'),
          style: TextStyle(fontFamily: 'Poppins-Bold'),
        ),
        callbackAction: Platform.isIOS
            ? _launchURL(APP_STORE_URL)
            : _launchURL(PLAY_STORE_URL),
      );
    }
  } on NoConfigFoundException catch (exception) {
    // Fetch throttled.
    print('new version not found');
    print(exception);
  } catch (exception) {
    print('Unable to fetch remote config. Cached or default values will be '
        'used');
  }
}

// _showVersionDialog(context) async {
//   await showDialog<String>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       var _lang = AppLocalizeService.of(context);
//       String title = _lang.translate('title_update');
//       String message = _lang.translate('msg_update');
//       String btnLabel = _lang.translate('btn_update');
//       return WillPopScope(
//         child: Platform.isIOS
//           ? new CupertinoAlertDialog(
//             title: Text(title),
//             content: Text(message),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text(btnLabel),
//                 onPressed: () => _launchURL(APP_STORE_URL),
//               ),
//             ],
//           )
//           : new AlertDialog(
//               title: Text(title),
//               content: Text(message),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text(btnLabel),
//                   onPressed: () => _launchURL(PLAY_STORE_URL),
//                 ),
//               ],
//             ),
//         onWillPop: () async => false,
//       );
//     },
//   );
// }

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

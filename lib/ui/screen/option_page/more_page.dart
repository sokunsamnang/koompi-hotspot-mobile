import 'package:koompi_hotspot/all_export.dart';
import 'package:package_info/package_info.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String name = mData.fullname;

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  
  Widget _infoApp(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        // SizedBox(width: 5),
        // Text(subtitle.isNotEmpty ? subtitle : 'Not set'),
        Text(subtitle),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _initPackageInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: ListTile(
                  onTap: () async {
                    Navigator.push(context,
                      PageTransition(type: PageTransitionType.rightToLeft, 
                        child: MyAccount(),
                      ),
                    );
                  },
                  title: Text(
                    name ?? 'KOOMPI',
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Bold"),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: mData.image == null ? AssetImage('assets/images/avatar.png') : NetworkImage("${ApiService.getAvatar}/${mData.image}"),
                  ),
                  trailing: Icon(LineIcons.edit),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(LineIcons.key, color: primaryColor),
                      title: Text(_lang.translate('change_password')),
                      trailing: Icon(LineIcons.angleRight),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.rightToLeft, 
                            child: ChangePassword(),
                          ),
                        );
                      }
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(LineIcons.language, color: primaryColor),
                      title: Text(_lang.translate('language')),
                      trailing: Icon(LineIcons.angleRight),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.rightToLeft, 
                            child: LanguageView(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(LineIcons.wifi, color: primaryColor),
                      title: Text(_lang.translate('login_hotspot')),
                      trailing: Icon(LineIcons.angleRight),
                      onTap: () async {
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.rightToLeft, 
                            child: CaptivePortalWeb()
                          ),
                        );
                      },
                    ),
                    // _buildDivider(),
                    // ListTile(
                    //   leading: Icon(Icons.wifi_outlined),
                    //   title: Text('Wi-Fi'),
                    //   trailing: Icon(LineIcons.angle_right),
                    //   onTap: () async {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => WifiConnect()),
                    //     );
                    //   },
                    // ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(LineIcons.alternateSignOut, color: Colors.red),
                      title: Text(_lang.translate('sign_out')),
                      onTap: () async {
                        await Components.dialogSignOut(
                          context,
                          Text(_lang.translate('sign_out_warn'), textAlign: TextAlign.center),
                          Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
                        );
                      },
                    ),
                    _buildDivider(),
                    Center(child: _infoApp('${_packageInfo.appName}: ', _packageInfo.version)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

// showLogoutDialog(context) async {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         var _lang = AppLocalizeService.of(context);
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(Icons.warning, color: Colors.yellow),
//               Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text(_lang.translate('sign_out_warn')),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text(_lang.translate('cancel')),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             FlatButton(
//               child: Text(_lang.translate('ok')),
//               onPressed: () async {
//                 dialogLoading(context);
//                 await StorageServices().clearToken('token');
//                 await StorageServices().clearToken('phone');
//                 await StorageServices().clearToken('password');
//                 Future.delayed(Duration(seconds: 2), () {
//                   Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPhone()),
//                     ModalRoute.withName('/loginPhone'),
//                   ));
//                 });
//               },
//             ),
//           ],
//         );
//       });
// }

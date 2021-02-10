import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/screen/web_view/captive_portal_web.dart';
import 'package:koompi_hotspot/src/utils/language.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String name = mData.fullname;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
                      MaterialPageRoute(builder: (context) => MyAccount()));
                  },
                  title: Text(
                    name ?? 'KOOMPI',
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Bold"),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: mData.image == null ? AssetImage('assets/images/avatar.png') : NetworkImage("https://api-hotspot.koompi.org/uploads/${mData.image}"),
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
                      leading: Icon(LineIcons.key),
                      title: Text(_lang.translate('change_password')),
                      trailing: Icon(LineIcons.angle_right),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()
                          )  
                        );
                      }
                    ),
                    // _buildDivider(),
                    // ListTile(
                    //   leading: Icon(LineIcons.money),
                    //   title: Text("Quick Top Up"),
                    //   trailing: Icon(LineIcons.angle_right),
                    //   onTap: () async {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => ReceiveRequest()),
                    //     );
                    //   },
                    // ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(LineIcons.language),
                      title: Text(_lang.translate('language')),
                      trailing: Icon(LineIcons.angle_right),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LanguageView()),
                        );
                      },
                    ),
                    // _buildDivider(),
                    // ListTile(
                    //   leading: Icon(Icons.wifi_outlined),
                    //   title: Text('Login Hotspot'),
                    //   trailing: Icon(LineIcons.angle_right),
                    //   onTap: () async {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => CaptivePortalWeb()),
                    //     );
                    //   },
                    // ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(LineIcons.sign_out),
                      title: Text(_lang.translate('sign_out')),
                      onTap: () async {
                        showLogoutDialog(context);
                      },
                    ),
                    _buildDivider(),
                    Text('Beta Version 0.2.2'),
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

showLogoutDialog(context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.yellow),
              Text('WARNING', style: TextStyle(fontFamily: 'Poppins-Bold'),),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to sign out?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                dialogLoading(context);
                await StorageServices().clearToken('token');
                Future.delayed(Duration(seconds: 2), () {
                  Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPhone()),
                    ModalRoute.withName('/loginPhone'),
                  ));
                });
              },
            ),
          ],
        );
      });
}

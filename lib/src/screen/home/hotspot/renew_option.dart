import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:provider/provider.dart';

class RenewOption extends StatefulWidget {
  @override
  _RenewOptionState createState() => _RenewOptionState();
}

class _RenewOptionState extends State<RenewOption>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String lang;
  bool automatically;
  String automaticallyTrue = "true";
  String automaticallyFalse = "false";
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

  Future <void> renewOptionTrue(BuildContext context) async {
    dialogLoading(context);
    var response = await PostRequest().renewOption(
      automaticallyTrue.toString(),
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Navbar()),
            ModalRoute.withName('/navbar'),
          );
        }
        else{
          Navigator.of(context).pop();
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              var _lang = AppLocalizeService.of(context);
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.yellow),
                    Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
                  ],
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(responseJson['message']),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(_lang.translate('ok')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        }
      
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
  }

  Future <void> renewOptionFalse(BuildContext context) async {
    dialogLoading(context);
    var response = await PostRequest().renewOption(
      automaticallyFalse.toString(),
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Navbar()),
            ModalRoute.withName('/navbar'),
          );
        }
        else{
          Navigator.of(context).pop();
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              var _lang = AppLocalizeService.of(context);
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.yellow),
                    Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
                  ],
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(responseJson['message']),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(_lang.translate('ok')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        }
      
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
  }


  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('renew_option'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 4.0,
                margin:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.autorenew),
                      title: Text(_lang.translate('auto')),
                      trailing: mPlan.automatically == true 
                        ? 
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue[700],
                        )
                        : 
                        Icon(
                          Icons.check_circle,
                          color: Colors.transparent,
                        ),
                      onTap: () async { 
                        await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
                        await renewOptionTrue(context);
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(Icons.touch_app_sharp),
                      trailing: mPlan.automatically == false 
                        ? 
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue[700],
                        )
                        : 
                        Icon(
                          Icons.check_circle,
                          color: Colors.transparent,
                        ),
                      title: Text(_lang.translate('manual')),
                      onTap: () async {
                        await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
                        await renewOptionFalse(context);
                      }
                    ),
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


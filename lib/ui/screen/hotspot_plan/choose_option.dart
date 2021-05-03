import 'package:koompi_hotspot/all_export.dart';
class ChooseOption extends StatefulWidget {
  @override
  _ChooseOptionState createState() => _ChooseOptionState();
}

class _ChooseOptionState extends State<ChooseOption>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String lang;
  bool renewOption = mPlan.automatically;
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

  changeIndex(bool index) {
    setState(() {
      renewOption = index;
    });
  }

  Future <void> renewPlanOption() async {
    dialogLoading(context);
    var response = await PostRequest().renewOption(
      renewOption,
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Future.delayed(Duration(seconds: 2), () async {
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CompletePlan()),
              ModalRoute.withName('/navbar'),
            ));
          });
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
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.blueAccent,
                ),
                onPressed: () async {
                  setState(() {
                    renewPlanOption();
                  });
                },
              ),
            ),
          ),
        ],
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
                    GestureDetector(
                      onTap: () => setState(() => changeIndex(true)),
                      child: ListTile(
                        leading: Icon(Icons.autorenew),
                        title: Text(_lang.translate('auto')),
                        trailing: renewOption == true 
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
                        onTap: () { 
                          setState(() => changeIndex(true));
                          changeIndex(true) == true ? Icon(
                            Icons.check_circle,
                            color: Colors.blue[700],
                          )
                          : 
                          Icon(
                            Icons.check_circle,
                            color: Colors.transparent,
                          );
                        }
                      ),
                    ),
                    _buildDivider(),
                    GestureDetector(
                      onTap: () => setState(() => changeIndex(false)),
                      child: ListTile(
                        leading: Icon(Icons.touch_app_sharp),
                        trailing: renewOption == false 
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
                        onTap: () { 
                          setState(() => changeIndex(false));
                          changeIndex(false) == false ? Icon(
                            Icons.check_circle,
                            color: Colors.blue[700],
                          )
                          : 
                          Icon(
                            Icons.check_circle,
                            color: Colors.transparent,
                          );
                        }
                      )
                    )
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


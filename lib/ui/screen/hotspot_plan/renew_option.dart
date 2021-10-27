import 'package:koompi_hotspot/all_export.dart';
import 'package:provider/provider.dart';

class RenewOption extends StatefulWidget {
  @override
  _RenewOptionState createState() => _RenewOptionState();
}

class _RenewOptionState extends State<RenewOption>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  String lang;
  bool renewOption = mPlan.automatically;
  
  @override
  void initState() {
    super.initState();
    AppServices.noInternetConnection(globalKey);
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
    var _lang = AppLocalizeService.of(context);

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
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.bottomToTop, 
              child: Navbar(),
            ),
            ModalRoute.withName('/navbar'),
          );
        }
        else{
          await Components.dialog(
            context,
            textAlignCenter(text: responseJson['message']),
            warningTitleDialog()
          );
          Navigator.of(context).pop();
        }
      
      }
    } on SocketException catch (_) {
        await Components.dialog(
          context,
          textAlignCenter(text: _lang.translate('no_internet_message')),
          warningTitleDialog()
        );
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      key: globalKey,
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
                        leading: Icon(Icons.autorenew, color: primaryColor),
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
                        leading: Icon(Icons.touch_app_sharp, color: primaryColor),
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


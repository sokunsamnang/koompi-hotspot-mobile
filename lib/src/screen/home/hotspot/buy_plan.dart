import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:provider/provider.dart';

class UserPlan extends StatefulWidget {
  @override
  _UserPlanState createState() => _UserPlanState();
}

class _UserPlanState extends State<UserPlan> {

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _passwordController = new TextEditingController();

  Future <void> buyHotspot30days(BuildContext context) async {
    dialogLoading(context);

    var response = await PostRequest().buyHotspotPlan(
      mData.phone,
      _passwordController.text,
      '30',
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Future.delayed(Duration(seconds: 2), () async{
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
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
                      Text(responseJson['message']),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
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

  Future <void> buyHotspot365days(BuildContext context) async {
     dialogLoading(context);

    var response = await PostRequest().buyHotspotPlan(
      mData.phone,
      _passwordController.text,
      '365',
    );
    var responseJson = json.decode(response.body);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        if(response.statusCode == 200){    
          Future.delayed(Duration(seconds: 2), () async{
            await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
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
                      Text(responseJson['message']),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
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


  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
              ModalRoute.withName('/'),
            );
          }
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Hotspot Plan', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
      ),
      body: WillPopScope(
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        'Choose Plan', 
                        style: GoogleFonts.nunito(
                        textStyle: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w700)
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    plan30DaysButton(context),
                    SizedBox(height: 50.0),
                    plan365DaysButton(context),
                  ],
                ),
              ),
            ),
          ),
        onWillPop: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navbar()),
          ModalRoute.withName('/navbar'),
        ),
      )
    );
  }

  Widget plan30DaysButton(BuildContext context){
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * .27, 
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ],
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left:15, top: 15),
              child: Image.asset(
                "assets/images/logo.png",
                // height: 100,
                // width: 100,
                scale: 5,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '50 SEL', 
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w700)
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    'Device:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '2 Devices', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    'Expire:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '30 Days', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    'Speed:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '5 MB', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                child: Container(
                  // width: ScreenUtil.getInstance().setWidth(330),
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                      // borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      _showDialog30Days(context);
                    },
                    child: Center(
                      child: Text("GET THIS PLAN",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 18,
                              letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ],
    ),
    );
  }

  Widget plan365DaysButton(BuildContext context){
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * .27, 
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ],
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left:15, top: 15),
              child: Image.asset(
                "assets/images/logo.png",
                // height: 100,
                // width: 100,
                scale: 5,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '600 SEL', 
                style: GoogleFonts.nunito(
                textStyle: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w700)
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    'Device:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '2 Devices', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    'Expire:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '365 Days', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25, left:25),
              child: Row(
                children: [
                  Text(
                    'Speed:', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '5 MB', 
                    style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                child: Container(
                  // width: ScreenUtil.getInstance().setWidth(330),
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                      // borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      _showDialog365Days(context);
                    },
                    child: Center(
                      child: Text("GET THIS PLAN",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 18,
                              letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ],
    ),
    );
  }

   Future<String> _showDialog30Days(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: new Text("Please enter your password"),
            content: TextFormField(
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              ),
              obscureText: _obscureText,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passwordController.clear(); 
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        dialogLoading(context);
                        buyHotspot30days(context);
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK"))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

   Future<String> _showDialog365Days(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child:AlertDialog(
            title: new Text("Please enter your password"),
            content: TextFormField(
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              ),
              obscureText: _obscureText,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passwordController.clear(); 
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        dialogLoading(context);
                        buyHotspot365days(context);
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK"))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';

class UserPlan extends StatefulWidget {
  @override
  _UserPlanState createState() => _UserPlanState();
}

class _UserPlanState extends State<UserPlan>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController planUserController = TextEditingController();


  // Expiration DATE

  String finalDate = '';

  String finalDate30Days = '';
  String finalDate365Days = '';


  //Plan Select 

  List<String> planList = ['30 Days', '365 Days'];
  var selectedPlanIndex;
  
  void changeIndex(String index) {
    setState(() {
      selectedPlanIndex = index;
    });
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    dateFormatter();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void dateFormatter(){
    //DATE FORMAT Expiration
    var date30Days = DateTime.now().add(Duration(days: 30));
    var date365Days = DateTime.now().add(Duration(days: 365));

    var formattedDate30days = "Time ${date30Days.hour}:${date30Days.minute}, Date ${date30Days.day}-${date30Days.month}-${date30Days.year}";
    var formattedDate365days = "Time ${date365Days.hour}:${date365Days.minute}, Date ${date365Days.day}-${date365Days.month}-${date365Days.year}";

    setState(() {
      
      finalDate30Days = formattedDate30days;
      finalDate365Days = formattedDate365days;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Buy Hotspot Plan', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 16.0),
                Text('Select user:'),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: planCustomRadio(planList[0], '30 Days'),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: planCustomRadio(planList[1], '365 Days'),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Center(
                  child: InkWell(
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                        ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => _reviewPlan(
                                    usernameController,
                                    selectedPlanIndex
                                )
                              )
                            );
                          },
                          child: Center(
                            child: Text("SUBMIT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget planCustomRadio(String txt, String index) {
    return ButtonTheme(
      height: 50.0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        splashColor: Colors.transparent,
        borderSide: BorderSide(
            color: selectedPlanIndex == index ? Colors.cyan : Colors.grey),
        child: Text(txt,
          style: TextStyle(
              color: selectedPlanIndex == index ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget _expirationDate(){
    if(selectedPlanIndex == planList[0]){
      return Text(
        'Expiration: $finalDate30Days ', 
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Poppins-Medium'
          )
        );
    }
    else if(selectedPlanIndex == planList[1]){
      return Text(
        'Expiration: $finalDate365Days', 
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Poppins-Medium'
        )
      );
    }
    else{
      return Container();
    }
  }

  Widget _reviewPlan(
      usernameController,
      _selectPlanDate) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  child: FlareActor( 
                    'assets/animations/alert_icon.flr', 
                    alignment: Alignment.topCenter,
                    fit: BoxFit.contain,
                    animation: 'show',
                  ),
                ),
                Center(
                  child: Text('Please review before buy', 
                  style: TextStyle(
                    fontFamily: 'Medium',
                    fontWeight: FontWeight.bold, 
                    fontSize: 25),
                  ),
                ),
                SizedBox(height: 25.0),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Container(
                        child: Text('Username: ${usernameController.text}',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Poppins-Medium',
                          )
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: Text('Date: $_selectPlanDate',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Poppins-Medium',
                          )
                        ),
                      ),
                      SizedBox(height: 10.0),
                      _expirationDate(),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Center(
                  child: InkWell(
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          dialogLoading(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Navbar()),
                            ModalRoute.withName('/')
                          );
                        },
                        child: Center(
                          child: Text("BUY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 18,
                                  letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

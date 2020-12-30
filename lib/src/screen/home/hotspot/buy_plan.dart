import 'dart:async';
import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:koompi_hotspot/index.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/buy_plan_complete.dart';
import 'package:line_icons/line_icons.dart';

class UserPlan extends StatefulWidget {
  @override
  _UserPlanState createState() => _UserPlanState();
}

class _UserPlanState extends State<UserPlan>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool _autoValidate = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController planUserController = TextEditingController();


  //check connection and login
  Future <void> buyHotspot(BuildContext context) async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');

        var paymentResponse = await PostRequest().hotspotPayment(selectedPlanIndex.toString());
        
        if (paymentResponse.statusCode == 200) {
          var response = await PostRequest().buyHotspotPlan(
          usernameController.text,
          passwordController.text,
          selectedPlanIndex.toString());

          if(response.statusCode == 200){
            print('Buy plan successfully');
            print(usernameController.text);
            print(passwordController.text);
            print(confirmPasswordController.text);
            print(selectedPlanIndex);
            Future.delayed(Duration(seconds: 2), () {
              Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CompletePlan()),
                ModalRoute.withName('/'),
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
                  title: Text('Error'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(response.body),
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
        else {
          Navigator.of(context).pop();
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(paymentResponse.body),
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


  String lastChoiceChipSelection = '';
  // Expiration DATE

  String finalDate30Days = '';
  String finalDate365Days = '';


  //Plan Select 

  List<String> planList = ['30', '365'];
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

  // Initially password is obscure2
  bool _obscureText2 = true;

  // Toggles2 the password show status
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    setState(() {
      dateFormatter();
    });
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

  void _submitValidate(BuildContext context){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _reviewPlan(
            usernameController,
            selectedPlanIndex
          )
        )
      );
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Buy Hotspot Plan', style: TextStyle(color: Colors.black)),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          // autovalidate: _autoValidate,
          child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    Text('Hotspot Username'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: usernameController,
                      validator: (val) => val.length < 3 ? 'Username is required.' : null,
                      onSaved: (val) => usernameController.text = val,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.people_outline),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Hotspot Password'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      validator: (val) {
                        if(val.isEmpty){
                          return 'Password is required.';
                        }
                        if(val.length < 8){
                          return 'Password too short';
                        }
                        return null;
                      },
                      onSaved: (val) => passwordController.text = val,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(LineIcons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
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
                    Text('Hotspot Confirm Password'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (val) {
                        if(val.isEmpty){
                          return 'Confirm password is required.';
                        }
                        if(val != passwordController.text){
                          return 'Password not match';
                        }
                        return null;
                      },
                      onSaved: (val) => confirmPasswordController.text = val,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(LineIcons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
                        ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle2();
                          },
                          child: Icon(
                            _obscureText2 ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: _obscureText2,
                    ),
                    SizedBox(height: 16.0),
                    FormBuilderChoiceChip(
                      onSaved: (newValue) => selectedPlanIndex = newValue,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Plan Date',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 20)
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Medium"
                      ),
                      selectedColor: Colors.cyan,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      alignment: WrapAlignment.spaceBetween,
                      labelPadding: EdgeInsets.only(left: 35, right: 35),
                      attribute: "planDate",
                      options: [
                        FormBuilderFieldOption(value: '30', label: '30 Days',),
                        FormBuilderFieldOption(value: '365', label: '365 Days',),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          //* If chip unselected, set value to last selection
                          formKey.currentState.fields['planDate'].currentState
                              .didChange(lastChoiceChipSelection);
                        } else {
                          //* If chip selected, save the value and rebuild
                          setState(() {
                            lastChoiceChipSelection = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 50.0),
                    Center(
                      child: InkWell(
                        child: Container(
                          // width: MediaQuery.of(context).copyWith().size.height/2,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(12),
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
                                _submitValidate(context);
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
        ),
      )
    );
  }



  // Widget planCustomRadio(String txt, String index) {
  //   return ButtonTheme(
  //     height: 50.0,
  //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  //     child: OutlineButton(
  //       onPressed: () => changeIndex(index),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  //       splashColor: Colors.transparent,
  //       borderSide: BorderSide(
  //           color: selectedPlanIndex == index ? Colors.cyan : Colors.grey),
  //       child: Text(txt,
  //         style: TextStyle(
  //             color: selectedPlanIndex == index ? Colors.black : Colors.grey),
  //       ),
  //     ),
  //   );
  // }

  Widget _planBalance(){
    if(selectedPlanIndex == planList[0]){
      return Text(
        'Balance: 50 RSEL', 
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Poppins-Medium'
          )
        );
    }
    else if(selectedPlanIndex == planList[1]){
      return Text(
        'Balance: 600 RSEL', 
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

  Widget _expirationDate(){
    if(selectedPlanIndex == planList[0]){
      return Text(
        'Expiration: $finalDate30Days', 
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
                        child: Text('Date: $_selectPlanDate Days',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Poppins-Medium',
                          )
                        ),
                      ),
                      SizedBox(height: 10.0),
                      _planBalance(),
                      SizedBox(height: 10.0),
                      _expirationDate(),
                    ],
                  ),
                ),
                // SizedBox(height: 50.0),
                Center(
                  child: InkWell(
                    child: Container(
                     margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                          borderRadius: BorderRadius.circular(12),
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
                          buyHotspot(context);
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


void checkLoading(BuildContext context, {String content}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        child: FlareActor( 
          'assets/animations/success_check.flr', 
          animation: 'success',
          ), 
          onWillPop: () async{return false;},);
    });
}



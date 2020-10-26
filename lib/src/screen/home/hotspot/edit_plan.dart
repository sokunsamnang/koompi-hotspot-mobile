import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';

class EditUserPlan extends StatefulWidget {
  @override
  _EditUserPlanState createState() => _EditUserPlanState();
}

class _EditUserPlanState extends State<EditUserPlan>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool _autoValidate = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController planUserController = TextEditingController();


  //check connection and login
  Future <void> buyHotspot(BuildContext context) async {
    // dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().buyHotspotPlan(
          usernameController.text,
          passwordController.text,
          selectedPlanIndex);
        if (response.statusCode == 200) {
          print('Buy plan successfully');
          print(usernameController.text);
          print(passwordController.text);
          print(selectedPlanIndex);
          // var responseJson = json.decode(response.body);
          Future.delayed(Duration(seconds: 2), () {
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
              ModalRoute.withName('/'),
            ));
          });
        } 
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
  }


  String lastChoiceChipSelection = '';
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

  void _submitValidate(BuildContext context){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('Edit Hotspot Plan', style: TextStyle(color: Colors.black)),
      ),
      body: FormBuilder(
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
                  Text('Wifi Hotspot Username'),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: usernameController,
                    validator: (val) => val.length < 3 ? 'Username is required' : null,
                    onSaved: (val) => usernameController.text = val,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                    ),
                  ),
                  // SizedBox(height: 16.0),
                  // Text('Wifi Hotspot Password'),
                  // SizedBox(height: 10.0),
                  // TextFormField(
                  //   controller: passwordController,
                  //   validator: (val) => val.length < 8 ? 'Password is required more than 8 digits' : null,
                  //   onSaved: (val) => passwordController.text = val,
                  //   decoration: InputDecoration(
                  //     hintText: 'Password',
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black),
                  //       borderRadius: BorderRadius.all(Radius.circular(30.0))
                  //     ),
                  //   suffixIcon: GestureDetector(
                  //       onTap: () {
                  //         _toggle();
                  //       },
                  //       child: Icon(
                  //         _obscureText ? Icons.visibility_off : Icons.visibility,
                  //       ),
                  //     ),
                  //   ),
                  //   obscureText: _obscureText,
                  // ),
                  SizedBox(height: 16.0),
                  FormBuilderChoiceChip(
                    onSaved: (newValue) => selectedPlanIndex = newValue,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Plan Date:',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Medium"
                    ),
                    selectedColor: Colors.cyan,
                    elevation: 2,
                    alignment: WrapAlignment.spaceEvenly,
                    labelPadding: EdgeInsets.only(left: 30, right: 30),
                    attribute: "planDate",
                    options: [
                      FormBuilderFieldOption(value: '30 Days'),
                      FormBuilderFieldOption(value: '365 Days'),
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
    );
  }
}




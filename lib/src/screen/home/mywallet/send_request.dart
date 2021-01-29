import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/qr_scanner.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/send_payment_complete.dart';

class SendRequest extends StatefulWidget {
  final String walletKey;

  SendRequest(this.walletKey);
  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  TextEditingController recieveWallet;
  TextEditingController asset = TextEditingController(text: 'SEL');
  TextEditingController amount = TextEditingController();
  TextEditingController memo = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Backend _backend = Backend();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submitValidate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _showDialogPassword(context, recieveWallet, amount, memo);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> _onSubmit() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        _backend.response = await PostRequest().sendPayment(_passwordController.text, recieveWallet.text, amount.text, memo.text);
        var responseJson = json.decode(_backend.response.body);
        if (_backend.response.statusCode == 200) {
          Future.delayed(Duration(seconds: 2), () {
            Timer(
                Duration(milliseconds: 500),
                () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompletePayment()),
                      ModalRoute.withName('/navbar'),
                    ));
          });
        } else {
          await Components.dialog(
              context,
              textAlignCenter(text: responseJson['message']),
              warningTitleDialog());
          Navigator.pop(context);
          _passwordController.clear();
          recieveWallet.clear();
          amount.clear();
          memo.clear();
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

   Future<String> _showDialogPassword(
     BuildContext context, 
     TextEditingController recieveWallet, 
     TextEditingController asset,
     TextEditingController memo,
    ) {
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
              obscureText: true,
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
                        Navigator.of(context).pop();
                        dialogLoading(context);
                        _onSubmit();
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


  @override
  void initState() {
    recieveWallet = TextEditingController(text: widget.walletKey);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Send Request',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Medium',
              fontSize: 22.0),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Receive Address'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) => val.isEmpty
                          ? 'Receiver address is required'
                          : null,
                      onSaved: (val) => recieveWallet.text = val,
                      autovalidateMode: AutovalidateMode.always,
                      maxLength: null,
                      controller: recieveWallet ?? widget.walletKey,
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            color: Colors.blueAccent,
                            icon: Icon(Icons.qr_code),
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QrScanner(
                                            portList: [],
                                          )));
                            }),
                          hintText: 'Receive Address',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          )),
                    ),
                    SizedBox(height: 16.0),
                    Text('Wallet'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: asset,
                      readOnly: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_balance_wallet),
                          hintText: 'Wallet',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          )),
                    ),
                    SizedBox(height: 16.0),
                    Text('Amont'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Amount is required' : null,
                      onSaved: (val) => amount.text = val,
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      controller: amount,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          hintText: 'Amount',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          )),
                    ),
                    SizedBox(height: 16.0),
                    Text('Memo'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: memo,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.my_library_books),
                          hintText: 'Memo',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          )),
                    ),
                    SizedBox(height: 50.0),
                    Center(
                      child: InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onTap: () async {
                                _submitValidate();
                              },
                              child: Center(
                                child: Text("SEND",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 2.5)),
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
      ),
    );
  }
}

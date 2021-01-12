import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/my_wallet.dart';
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

  Backend _backend = Backend();

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _submitValidate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _onSubmit();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> _onSubmit() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        _backend.response = await PostRequest()
            .sendPayment(recieveWallet.text, amount.text, memo.text);

        if (_backend.response.statusCode == 200) {
          Future.delayed(Duration(seconds: 3), () {
            Timer(
                Duration(milliseconds: 500),
                () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompletePayment()),
                      ModalRoute.withName('/'),
                    ));
          });
        } else {
          print('${_backend.response.statusCode.toString()}');
          await Components.dialog(
              context,
              textAlignCenter(text: _backend.response.body),
              warningTitleDialog());
          Navigator.pop(context);
          recieveWallet.clear();
          amount.clear();
          memo.clear();
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
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
    return WillPopScope(
        onWillPop: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyWallet()),
              ModalRoute.withName('/'),
            ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              'Send Request',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyWallet()),
                    ModalRoute.withName('/'),
                  );
                }),
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
                autovalidate: _autoValidate,
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
                          validator: (val) => val == null
                              ? 'Receiver address is required'
                              : null,
                          onSaved: (val) => recieveWallet.text = val,
                          autovalidate: true,
                          maxLength: null,
                          controller: recieveWallet ?? widget.walletKey,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
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
                              val == null ? 'Amount is required' : null,
                          onSaved: (val) => amount.text = val,
                          autovalidate: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
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
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
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
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/models/model_wallet.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_btn_social.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_myButton.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SendRequest extends StatefulWidget {
  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Send Request',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22.0),
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(LineIcons.qrcode),
                        hintText: 'Receive Address',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Wallet'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      readOnly: true,
                      initialValue: 'RSEL',
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet),
                        hintText: 'Wallet',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Amont'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        hintText: 'Amount',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Remark'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.my_library_books),
                        hintText: 'Remark',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Center(
                      child: InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
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

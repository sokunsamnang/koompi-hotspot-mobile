import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/home/topup/transfer_amount.dart';

class TransferCredit extends StatefulWidget {
  @override
  _TransferCreditState createState() => _TransferCreditState();
}

class _TransferCreditState extends State<TransferCredit> {
  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _emailController = TextEditingController();
  String userName = '';

  void _submitValidate(BuildContext context){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfrimTransferAmount(_emailController.text, userName)),
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
        backgroundColor: Colors.white,
        title: Text('Transfer Credit', style: TextStyle(color: Colors.black)),
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
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter Koompi hotspot user's email to transfer credit",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Medium'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      autovalidate: _autoValidate,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child:  TextFormField(
                          controller: _emailController,
                          validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
                          onSaved: (val) => _emailController.text = val,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                            )
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 60),
                  InkWell(
                    child: Container(
                      width: 125,
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
                            child: Text("NEXT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 3.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

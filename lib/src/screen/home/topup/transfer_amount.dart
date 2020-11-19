import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';

class ConfrimTransferAmount extends StatefulWidget {
  
  final String email; 
  final String userName;

  ConfrimTransferAmount(this.email, this.userName);

  @override
  _ConfrimTransferAmountState createState() => _ConfrimTransferAmountState();
}

class _ConfrimTransferAmountState extends State<ConfrimTransferAmount> with SingleTickerProviderStateMixin{

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  var _amountController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  bool showPageLoader = false;
  bool showSpinner = false;
  bool showChecked = false;
  AnimationController animationController;
  bool _isButtonDisabled = true;
  
  _checkInputForConfirm(double amount) {
    if (amount > 0.0) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }
  
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animationController.addListener(() {
      if (animationController.status.toString() ==
          'AnimationStatus.completed') {
        setState(() {
          showSpinner = false;
          showChecked = true;
        });
        Timer(
          Duration(seconds: 1),
          () => setState(() {
                showPageLoader = false;
                Navigator.of(context).pop();
              }),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _startPayment() {
    setState(() {
      showPageLoader = true;
      showSpinner = true;
      animationController.forward();
    });
  }

  Widget _showPageLoader() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 10,
              sigmaX: 10,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        showSpinner
            ? Align(
                heightFactor: 15,
                alignment: Alignment.center,
                child: Image.asset('assets/images/koompi_logo.png', height: 60),
              )
            : Container(),
        showSpinner
            ? Align(
                alignment: Alignment.center,
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 2.0).animate(animationController),
                  child: Image.asset('assets/images/loading.png'),
                ),
              )
            : Container(),
        showChecked
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/checked.png'),
                    SizedBox(height: 25),
                    Material(
                      child: Text(
                        'Transaction Successful',
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontSize: 17,
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  void _submitValidate(BuildContext context){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      Future.delayed(Duration(seconds: 2), () {
        Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navbar()),
          ModalRoute.withName('/'),
        ));
      });
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
        title: Text('Send to', style: TextStyle(color: Colors.black)),
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _nameBar(context),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _creditAmount(context),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: _btnTransfter(context),
                  ),
                ],
              ),
              showPageLoader ? _showPageLoader() : Container(),
            ],
          ),
        )
      ),
    );
  }

  Widget _nameBar(BuildContext context) {

    return Row(
      children: <Widget>[
        CircleAvatar(
          // backgroundImage: image == null ? AssetImage('assets/images/avatar.png') : NetworkImage(image),
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 
              'User',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent)
            ),
            Text( 
              widget.email,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent)
            ),
          ],
        )
      ],
    );
  }

  Widget _creditAmount(BuildContext context){
    return Form(
      key: formKey,
      autovalidate: _autoValidate,
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        child:  TextFormField(
          controller: _amountController,
          validator: (val) => val.length <= 0.00 ? 'Amount Required' : null,
          onSaved: (val) => _amountController.text = val,
          keyboardType: TextInputType.numberWithOptions(
            signed: false, decimal: true),
          decoration: InputDecoration(
            isDense: true, 
            contentPadding: EdgeInsets.all(12),
            prefix: Text('៛\t', style: TextStyle(fontSize: 18),),
            hintText: 'Enter Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))
            )
          ),
        ),
      ),
    );
  }

  Widget _btnTransfter(BuildContext context){
    return InkWell(
      child: Container(
        width: 200,
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
              // _submitValidate(context);
              _startPayment();
            },
            child: Center(
              child: Text("TRANSFER",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Bold",
                      fontSize: 18,
                      letterSpacing: 3.0)),
            ),
          ),
        ),
      ),
    );
  }
}

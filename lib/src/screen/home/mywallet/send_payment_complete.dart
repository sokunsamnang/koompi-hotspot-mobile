import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:provider/provider.dart';

class CompletePayment extends StatefulWidget {
  @override
  _CompletePaymentState createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Completed',
            style: TextStyle(fontFamily: 'Medium', color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 300,
                    child: FlareActor(
                      'assets/animations/success.flr',
                      animation: 'play',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Your Transfer is successfully.',
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 100.0),
                  Center(
                    child: InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 25.0),
                        width: MediaQuery.of(context).size.width,
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
                              dialogLoading(context);
                              await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
                              Future.delayed(Duration(seconds: 1), () {
                                Timer(
                                    Duration(milliseconds: 500),
                                    () => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Navbar()),
                                          ModalRoute.withName('/'),
                                        ));
                              });
                            },
                            child: Center(
                              child: Text("BACK HOME",
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
        onWillPop: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navbar()),
          ModalRoute.withName('/'),
        ),
      ),
    );
  }
}

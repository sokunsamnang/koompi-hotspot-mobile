import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';

class CompletePlan extends StatefulWidget {
  @override
  _CompletePlanState createState() => _CompletePlanState();
}

class _CompletePlanState extends State<CompletePlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Completed', style: TextStyle(fontFamily: 'Medium', color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  child: Text('You bought plan is successfully.', 
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
                          Future.delayed(Duration(seconds: 1), () {
                            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Navbar()),
                              ModalRoute.withName('/'),
                            ));
                          });
                        },
                        child: Center(
                          child: Text("HOME",
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

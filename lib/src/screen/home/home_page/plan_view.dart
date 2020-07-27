import 'package:flutter/material.dart';

class PlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text('Your Plans', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey[350],
                child: Column(
                  children: <Widget>[
                    Text('Username: koompi'),
                    Text('User: 5 User'),
                    Text('Expiring in: 999 days'),
                    
                  ],
                ),
              ),
              Text(' '),
              Container(
                color: Colors.grey[350],
                child: Column(
                  children: <Widget>[
                    Text('Username: koompi'),
                    Text('User: 5 User'),
                    Text('Expiring in: 100 days'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
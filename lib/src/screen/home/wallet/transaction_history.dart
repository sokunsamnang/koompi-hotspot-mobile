import 'package:flutter/material.dart';


class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              displayAccoutList(),
            ],
          ),
        ),
      ),
    );
  }

  Container accountItems(
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
        ),
      );

  displayAccoutList() {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          accountItems("Top Up", r"+ 600000 ៛", "28-10-20", "Balance",
            oddColour: const Color(0xFFF7F7F9)),
          accountItems("Hotspot Plan 30 Days", r"- 5000 ៛", "26-04-20", "Balance"),
          accountItems("Top Up", r"+ 5000 ៛", "28-04-20", "Balance",
            oddColour: const Color(0xFFF7F7F9)),
          accountItems("Hotspot Plan 365 Days", r"- 600000 ៛", "26-04-20", "Balance"),
          accountItems("Top Up", r"+ 10000 ៛", "14-04-20", "Balance",
            oddColour: const Color(0xFFF7F7F9)),
        ],
      ),
    );
  }
}
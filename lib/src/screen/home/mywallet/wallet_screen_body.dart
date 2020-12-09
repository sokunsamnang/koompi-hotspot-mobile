import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/my_wallet.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/wallet_choice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  showAlertDialog(BuildContext context, String alertText) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      content: Text(alertText),
      actions: [
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      }, context: null,
    );
  }

  onGetWallet() async {
    String _token;
    SharedPreferences isToken = await SharedPreferences.getInstance();
    _token = isToken.get('token');
    if (_token == null) {
      String alertText = 'Please Sign up with Email or Phone to get wallet';
      showAlertDialog(context, alertText);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyWallet()),
      );
    }
  }

  void resetState() {
    setState(() {});
  }

  // void fetchHistory() async {
  //   await _getRequest.getTrxHistory();
  // }

  @override
  void initState() {
    // fetchHistory();
    super.initState();
    // Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
  }

  @override
  Widget build(BuildContext context) {
    return mBalance.data == null
      ? Center(
          child: WalletChoice(onGetWallet, showAlertDialog),
        )
      : MyWallet();
  }
}

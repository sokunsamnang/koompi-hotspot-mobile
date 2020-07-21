import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:postgres/postgres.dart';

errorDialog(context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Error Services'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future registerPhoneNumberConnection(
    String phoneNumber, String userName, String passWord) async {
  try {
    var connection = new PostgreSQLConnection(
        "ec2-52-221-199-235.ap-southeast-1.compute.amazonaws.com",
        5431,
        "radius",
        username: "koompi-hotspot-wifi",
        password: "0256b64ed0db750636bd0d145b9385d4");
    await connection.open();
    connection.execute("SELECT user from user_login");
    PostgreSQLResult result = await connection.query('''
        INSERT INTO user_login (users, password, phonenumber)
        VALUES ('$userName', '$passWord', '$phoneNumber')
        ''');

    print(result);
  } catch (error) {
    print("Error $error");
  }
}

Future registerEmailConnection(
    String email, String userName, String passWord) async {
  try {
    var connection = new PostgreSQLConnection(
        "ec2-52-221-199-235.ap-southeast-1.compute.amazonaws.com",
        5431,
        "radius",
        username: "koompi-hotspot-wifi",
        password: "0256b64ed0db750636bd0d145b9385d4");
    await connection.open();
    connection.execute("SELECT * from user_login");
    PostgreSQLResult result = await connection.query('''
        INSERT INTO user_login (users, password, email)
        VALUES ('$userName', '$passWord', '$email')
        ''');

    print(result);
  } catch (error) {
    print("Error $error");
  }
}

Future loginConnection(String userName, String passWord) async {
  try {
    var connection = new PostgreSQLConnection(
        "ec2-52-221-199-235.ap-southeast-1.compute.amazonaws.com",
        5431,
        "radius",
        username: "koompi-hotspot-wifi",
        password: "0256b64ed0db750636bd0d145b9385d4");
    await connection.open();
    connection.execute("SELECT * FROM user_login");
    PostgreSQLResult result = await connection.query('''
        SELECT users, password from user_login
        WHERE users = '$userName' and password = '$passWord'
        ''');
    return result;
  } catch (context) {
    return errorDialog(context);
  }
}

Future userData(String userName) async {
  try {
    var connection = new PostgreSQLConnection(
        "ec2-52-221-199-235.ap-southeast-1.compute.amazonaws.com",
        5431,
        "radius",
        username: "koompi-hotspot-wifi",
        password: "0256b64ed0db750636bd0d145b9385d4");
    await connection.open();
    connection.execute("SELECT * FROM user_login");
    PostgreSQLResult result = await connection.query('''
        SELECT users from user_login
        WHERE users = '$userName' 
        ''');
    return result;
  } catch (error) {
    print("Error $error");
  }
}

Future updatePassword(String userName, String passWord) async {
  try {
    var connection = new PostgreSQLConnection(
        "ec2-52-221-199-235.ap-southeast-1.compute.amazonaws.com",
        5431,
        "radius",
        username: "koompi-hotspot-wifi",
        password: "0256b64ed0db750636bd0d145b9385d4");
    await connection.open();
    connection.execute("SELECT * FROM user_login");
    PostgreSQLResult result = await connection.query('''
        UPDATE user_login
        SET password = '$passWord'
        WHERE users = '$userName'
        ''');
    return result;
  } catch (error) {
    print("Error $error");
  }
}

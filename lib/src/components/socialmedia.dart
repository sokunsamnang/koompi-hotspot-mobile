import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

void _signInFacebook() async {
  FacebookLogin facebookLogin = FacebookLogin();
  final result = await facebookLogin.logIn(['email']);
  final token = result.accessToken.token;
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,gender,birthday&access_token=${token}');
  print(graphResponse.body);
}

Widget onPressFB(BuildContext context) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 135.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1346b4),
              Color(0xff0cb2eb),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                FontAwesomeIcons.facebookF,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () async {
                _signInFacebook();
              }),
        ),
      ),
    ]),
  );
}

Widget onPressGoogle(BuildContext context) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(
        width: 10,
      ),
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xffff4645),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                print('Google Button');
              }),
        ),
      ),
    ]),
  );
}

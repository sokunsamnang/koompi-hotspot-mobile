import 'package:koompi_hotspot/all_export.dart';


Widget onPressFB(BuildContext context) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 125.0),
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
                
              }),
        ),
      ),
    ]),
  );
}

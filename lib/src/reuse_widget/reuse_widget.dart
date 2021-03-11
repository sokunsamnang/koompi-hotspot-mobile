import 'package:koompi_hotspot/all_export.dart';

Widget textAlignCenter({String text: ""}) {
  return Text(text, textAlign: TextAlign.center);
}

Widget warningTitleDialog() {
  return Text(
    'Oops...',
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget titleDialog() {
  return Text(
    'Congratulation...!',
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}

void snackBar(BuildContext context){
  final snackBar = SnackBar(
    content: Text('Coming Soon!!!'),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
}
class Components {
  static void dialogLoading({BuildContext context, String contents}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        // valueColor: AlwaysStoppedAnimation(hexaCodeToColor(AppColors.lightBlueSky))
                      ),
                      contents == null
                          ? Container()
                          : Padding(
                              child: Text(
                                contents,
                                style: TextStyle(color: Color(0xffFFFFFF)),
                              ),
                              padding:
                                  EdgeInsets.only(bottom: 10.0, top: 10.0)),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  /* Dialog of response from server */
  static Future dialog(BuildContext context, var text, var title,
      {FlatButton action, Color bgColor}) async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
            title: Align(
              alignment: Alignment.center,
              child: title,
            ),
            content: Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: text,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CLOSE', style: GoogleFonts.nunito(
                  textStyle: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w700)
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(text),
              ),
              action
            ],
          );
        });
    return result;
  }
}

class ItemList extends StatelessWidget {

  final String title;
  final String trailing;


  ItemList({
    this.title,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text("$title: ", textAlign: TextAlign.left, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(trailing, style: TextStyle(fontSize: 13)),
            )
          ),
        ],
      )
    );
  }
}


/* Loading Progress */
Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation(Colors.blueAccent)
    ),
  );
}

/* Progress */
Widget progress({String content}) {
  return Material(
    color: Colors.transparent,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent)
            ),
            content == null 
            ? Container() 
            : Padding(
              child: textScale(
                text: content,
                hexaColor: "#FFFFFF"
              ),
              padding: EdgeInsets.only(bottom: 10.0, top: 10.0)
            ),
          ],
        )
      ],
    ),
  );
}

void dialogLoading(BuildContext context, {String content}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(child: progress(content: content), onWillPop: () async{return false;},);
    });
}

Widget textScale({
  String text,
  double fontSize = 18.0,
  String hexaColor = "#1BD2FA",
  TextDecoration underline,
  BoxFit fit = BoxFit.contain,
  FontWeight fontWeight}
) {
  return FittedBox(
    fit: fit,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.blueAccent,
        decoration: underline,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    ),
  );
}
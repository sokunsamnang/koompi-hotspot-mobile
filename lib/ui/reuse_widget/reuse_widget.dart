import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';

final primaryColor = HexColor('0CACDA');


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
  // static void dialogLoading({BuildContext context, String contents}) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return WillPopScope(
  //           onWillPop: () => Future(() => false),
  //           child: Material(
  //             color: Colors.transparent,
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children: <Widget>[
  //                 Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     CircularProgressIndicator(
  //                       backgroundColor: Colors.transparent,
  //                       // valueColor: AlwaysStoppedAnimation(hexaCodeToColor(AppColors.lightBlueSky))
  //                     ),
  //                     contents == null
  //                         ? Container()
  //                         : Padding(
  //                             child: Text(
  //                               contents,
  //                               style: TextStyle(color: Color(0xffFFFFFF)),
  //                             ),
  //                             padding:
  //                                 EdgeInsets.only(bottom: 10.0, top: 10.0)),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

 /* Dialog of response from server */
  static Future dialog(
    BuildContext context, 
    var text, 
    var title, 
    {
      Widget action, 
      String firsTxtBtn = "OK", 
      Color bgColor = Colors.white, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5
    }
  ) async {
    var result = await showDialog(
      context: context,
      barrierColor: barrierColor ?? Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, setState){
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
            title: title != null ? Align(
              alignment: Alignment.center,
              child: title,
            ) : null,
            content: text,
            actions: !removeBtn ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text(firsTxtBtn),
                    onPressed: () => Navigator.of(context).pop(text),
                  ),
                ],
              ),
              action ?? Container()
            ] : null,
          );
        });
      }
    );
    return result;
  }

  static Future dialogSignOut(
    BuildContext context, 
    var text, 
    var title, 
    {
      Widget action, 
      String firsTxtBtn = "OK",
      String secTxtBtn = "CANCEL",  
      Color bgColor = Colors.white, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5
    }
  ) async {
    var result = await showDialog(
      context: context,
      barrierColor: barrierColor ?? Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, setState){
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
            title: title != null ? Align(
              alignment: Alignment.center,
              child: title,
            ) : null,
            content: text,
            actions: !removeBtn ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                      ),
                    ),
                    child: Text(secTxtBtn),
                    onPressed: () => Navigator.of(context).pop(text),
                  ),

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text(firsTxtBtn),
                    onPressed: () async{
                      dialogLoading(context);
                      await StorageServices().clearToken('token');
                      await StorageServices().clearToken('phone');
                      await StorageServices().clearToken('password');
                      Future.delayed(Duration(seconds: 2), () {
                        Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPhone()),
                          ModalRoute.withName('/loginPhone'),
                        ));
                      });
                    }
                  ),
                ],
              ),
              action ?? Container()
            ] : null,
          );
        });
      }
    );
    return result;
  }

  static Future dialogResetPw(
    BuildContext context, 
    var text, 
    var title, 
    {
      Widget action, 
      String firsTxtBtn = "OK",
      Color bgColor = Colors.white, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5
    }
  ) async {
    var result = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor ?? Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, setState){
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
            title: title != null ? Align(
              alignment: Alignment.center,
              child: title,
            ) : null,
            content: text,
            actions: !removeBtn ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text(firsTxtBtn),
                    onPressed: () async{
                      dialogLoading(context);
                      Future.delayed(Duration(seconds: 2), () {
                        Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPhone()),
                          ModalRoute.withName('/loginPhone'),
                        ));
                      });
                    }
                  ),
                ],
              ),
              action ?? Container()
            ] : null,
          );
        });
      }
    );
    return result;
  }

  static Future dialogUpdateApp(
    BuildContext context, 
    var text, 
    var title, 
    {
      Widget action, 
      String firsTxtBtn, 
      Color bgColor = Colors.white, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5,
      CallbackAction callbackAction
    }
  ) async {
    var _lang = AppLocalizeService.of(context);
    var result = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor ?? Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, setState){
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
              title: title != null ? Align(
                alignment: Alignment.center,
                child: title,
              ) : null,
              content: text,
              actions: !removeBtn ? <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                        ),
                      ),
                      child: Text(_lang.translate('btn_update')),
                      onPressed: () => {
                        callbackAction
                      }
                    ),
                  ],
                ),
                action ?? Container()
              ] : null,
            ),
          );
        });
      }
    );
    return result;
  }

  static Future dialogGPS(
    BuildContext context, 
    var text, 
    var title, 
    {
      Widget action, 
      String firsTxtBtn = "OK",
      String secTxtBtn = "CANCEL",  
      Color bgColor = Colors.white, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5,
    }
  ) async {
    var result = await showDialog(
      context: context,
      barrierColor: barrierColor ?? Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, setState){
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
            title: title != null ? Align(
              alignment: Alignment.center,
              child: title,
            ) : null,
            content: text,
            actions: !removeBtn ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                      ),
                    ),
                    child: Text(secTxtBtn),
                    onPressed: () => Navigator.of(context).pop(text),
                  ),

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text(firsTxtBtn),
                    onPressed: () => {
                      AppSettings.openLocationSettings(),

                      Navigator.of(context).pop(),
                    }
                  ),
                ],
              ),
              action ?? Container()
            ] : null,
          );
        });
      }
    );
    return result;
  }

  static Future<String> dialogPassword(
    BuildContext context, 
    var text, 
    var title, 
    {
      Widget action, 
      String firsTxtBtn = "OK",
      String secTxtBtn = "CANCEL",  
      Color bgColor = Colors.white, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5,
      var actionFirstBtn,
      var actionSecBtn,
    }
  ) async {
    var result = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: barrierColor ?? Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, setState){
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
            title: title != null ? Align(
              alignment: Alignment.center,
              child: title,
            ) : null,
            content: text,
            actions: !removeBtn ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 35)
                      ),
                    ),
                    child: Text(secTxtBtn),
                    onPressed: () => {
                      actionSecBtn,
                      Navigator.of(context).pop(text),
                    }
                  ),

                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('0CACDA')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)
                      ),
                    ),
                    child: Text(firsTxtBtn),
                    onPressed: () => {
                      actionFirstBtn,
                      Navigator.of(context).pop(),
                      Navigator.pop(context),
                    }
                  ),
                ],
              ),
              action ?? Container()
            ] : null,
          );
        });
      }
    );
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
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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


// /* Loading Progress */
// Widget loading() {
//   return Center(
//     child: CircularProgressIndicator(
//       backgroundColor: Colors.transparent,
//       valueColor: AlwaysStoppedAnimation(Colors.blueAccent)
//     ),
//   );
// }

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
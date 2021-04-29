// import 'package:flutter/cupertino.dart';
// import 'package:koompi_hotspot/all_export.dart';

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Center(
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.all(30.0),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Welcome to',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 22,
//                         //color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         'KOOMPI Hotspot',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 28,
//                           color: Colors.lightBlueAccent,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.05,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       child: Image.asset(
//                         'assets/images/wifi.png',
//                         // height: MediaQuery.of(context).size.height * 0.32,
//                         // width: MediaQuery.of(context).size.width * 0.3,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.05,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 50,
//                     child: OutlineButton(
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginPage()),
//                           ModalRoute.withName('/loginEmail'),
//                         );
//                       },
//                         child: Stack(
//                             children: <Widget>[
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Icon(Icons.email)
//                                 ),
//                                 Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                         "Sign In With Email",
//                                         textAlign: TextAlign.center,
//                                     )
//                                 )
//                             ],
//                         ),
//                         highlightedBorderColor: Colors.orange,
//                         color: Colors.green,
//                         borderSide: new BorderSide(color: Colors.green),
//                         shape: new RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(5.0)
//                         )
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 50,
//                     child: OutlineButton(
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginPhone()),
//                           ModalRoute.withName('/loginPhone'),
//                         );
//                       },
//                         child: Stack(
//                             children: <Widget>[
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Icon(Icons.phone)
//                                 ),
//                                 Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                         "Sign In With Phone Number",
//                                         textAlign: TextAlign.center,
//                                     )
//                                 )
//                             ],
//                         ),
//                         highlightedBorderColor: Colors.orange,
//                         color: Colors.green,
//                         borderSide: new BorderSide(color: Colors.green),
//                         shape: new RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(5.0)
//                         )
//                     ),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: new Container(
//                             margin: const EdgeInsets.only(left: 20.0, right: 10.0),
//                             child: Divider(
//                               color: Colors.black,
//                               height: 36,
//                             )),
//                       ),
//                       Text("OR",
//                         style: TextStyle(
//                           fontFamily: "Poppins-BoldItalic",
//                           letterSpacing: .6)),
//                       Expanded(
//                         child: new Container(
//                             margin: const EdgeInsets.only(left: 20.0, right: 10.0),
//                             child: Divider(
//                               color: Colors.black,
//                               height: 36,
//                             )),
//                       ),
//                     ],
//                   ),
//                   Text("SIGN IN WITH",
//                     style: TextStyle(
//                       fontFamily: "Poppins-Bold",
//                       letterSpacing: .6)),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       onPressFB(context),
//                       onPressGoogle(context),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

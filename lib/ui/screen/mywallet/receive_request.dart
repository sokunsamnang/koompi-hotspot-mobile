import 'dart:typed_data';
import 'dart:ui';

import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:path_provider/path_provider.dart';

class ReceiveRequest extends StatefulWidget {
  @override
  _ReceiveRequestState createState() => _ReceiveRequestState();
}

class _ReceiveRequestState extends State<ReceiveRequest> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  GlobalKey _keyQrShare = GlobalKey();

  void showSnackBar() {
    final snackBarContent = SnackBar(
      content: Text("Copied"),
    );

    // ignore: deprecated_member_use
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  void copyWallet(String _wallet) {
    Clipboard.setData(
      ClipboardData(
        text: _wallet,
      ),
    );
  }

  void qrShare(GlobalKey globalKey, String _wallet) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 5.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file =
          await new File("${tempDir.path}/KOOMPI_HOTSPOT.png").create();
      await file.writeAsBytes(pngBytes);
      Share.shareFiles(['${file.path}'], text: _wallet);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          _lang.translate('receive_request'),
          style: TextStyle(
              color: Colors.black, fontFamily: 'Medium', fontSize: 22.0),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.74,
          margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    child: RepaintBoundary(
                      key: _keyQrShare,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'SELENDRA WALLET',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            QrImage(
                              data: mData.wallet ?? '',
                              version: QrVersions.auto,
                              embeddedImage:
                                  AssetImage('assets/images/SelendraQr.png'),
                              size: 225.0,
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                size: Size(50, 50),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              mData.fullname ?? '',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              mData.wallet ?? '',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onTap: () async {
                              copyWallet(mData.wallet);
                              showSnackBar();
                            },
                            child: Center(
                              child: Text(
                                _lang.translate('copy'),
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        primary: Colors.white,
                        elevation: 2.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          side: BorderSide(color: HexColor('0CACDA'), width: 2),
                        ),
                      ),
                      onPressed: () {
                        qrShare(_keyQrShare, mData.wallet);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        child: Text(
                          _lang.translate('share'),
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

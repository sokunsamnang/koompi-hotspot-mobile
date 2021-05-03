import 'package:koompi_hotspot/all_export.dart';

class QrScanner extends StatefulWidget {
  final List portList;

  QrScanner({this.portList});

  @override
  State<StatefulWidget> createState() {
    return QrScannerState();
  }
}

class QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey();

  // Backend _backend = Backend();

  Barcode result;


  void _onQrViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        return result;
      });
      controller.pauseCamera();
      // Navigator.pop(context, scanData);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SendRequest(result.code, "")),
        // ModalRoute.withName('/navbar'),
      );
    });
  }

Widget build(BuildContext context) {
  var _lang = AppLocalizeService.of(context);
  return Scaffold(
    body: BodyScaffold(
      height: MediaQuery.of(context).size.height,
      bottom: 0,
      child: Column(
        children: [
          MyAppBar(
            title: _lang.translate('qr_scanner'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQrViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.red, borderRadius: 10, borderWidth: 10),
              )),
        ],
      ),
    ));
  }
}

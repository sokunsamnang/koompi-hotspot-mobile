import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/components/my_widget/my_appbar.dart';
import 'package:koompi_hotspot/src/components/my_widget/my_scaffold.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/send_request.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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

  Backend _backend = Backend();

  Barcode result;


  void _onQrViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        return result;
      });
      controller.pauseCamera();
      // Navigator.pop(context, scanData);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SendRequest(result.code)),
        ModalRoute.withName('/'),
      );
    });
  }

Widget build(BuildContext context) {
  return Scaffold(
    body: BodyScaffold(
      height: MediaQuery.of(context).size.height,
      bottom: 0,
      child: Column(
        children: [
          MyAppBar(
            title: "QR Scanner Transaction",
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

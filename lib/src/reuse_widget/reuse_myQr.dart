import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_myButton.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

class ReuseQrCard extends StatelessWidget {
  final String image;
  final String title;
  
  ReuseQrCard({this.image, this.title});

  void copyWallet(String _wallet) {
    Clipboard.setData(
      ClipboardData(
        text: _wallet,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Consumer<ModelUserData>(
            builder: (context, value, child) => Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                QrImage(
                  embeddedImage: AssetImage(image),
                  data: mData.wallet,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  mData.wallet,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 40.0,
                ),
                ReuseButton.getItem('Copy', () {
                  copyWallet(mData.wallet);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Copied"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

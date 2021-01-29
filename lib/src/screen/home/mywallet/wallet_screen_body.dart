import 'package:koompi_hotspot/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GetRequest _getRequest = GetRequest();

  void resetState() {
    setState(() {});
  }

  void fetchHistory() async {
    await _getRequest.getTrxHistory();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return mBalance == null ? WalletChoice() : MyWallet(resetState: resetState);
  }
}

import 'package:provider/provider.dart';
import 'package:koompi_hotspot/all_export.dart';

class WalletChoice extends StatefulWidget {
  // final Function onGetWallet;
  // final Function showAlertDialog;

  // WalletChoice(this.onGetWallet, this.showAlertDialog);

  @override
  _WalletChoiceState createState() => _WalletChoiceState();
}

class _WalletChoiceState extends State<WalletChoice> {
  String alertText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // brightness: Brightness.light,
        title: Text(
          _lang.translate('my_wallet'),
          style: TextStyle(color: Colors.black, fontFamily: 'Medium'),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: SvgPicture.asset(
                  'assets/images/undraw_wallet.svg',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  placeholderBuilder: (context) => Center(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
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
                        dialogLoading(context);
                        var response = await GetRequest().getWallet();
                        var responseJson = json.decode(response.body);
                        if (response.statusCode == 200) {
                          print(response.body);
                          await Components.dialog(
                            context,
                            textAlignCenter(text: responseJson['message']),
                            titleDialog());
                          await Provider.of<BalanceProvider>(context, listen: false).fetchPortfolio();
                          await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
                          StorageServices().read('token').then((value) async{
                            String _token = value;
                            await GetRequest().getUserProfile(_token);
                          });
                          Navigator.pushReplacement(
                            context,
                            PageTransition(type: PageTransitionType.rightToLeft, 
                              child: MyWallet(),
                            ),
                          );
                        } else {
                          await Components.dialog(
                            context,
                            textAlignCenter(text: responseJson['message']),
                            warningTitleDialog()
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Text(_lang.translate('get_wallet'),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

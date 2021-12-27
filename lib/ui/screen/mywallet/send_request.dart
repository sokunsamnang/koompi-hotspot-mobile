import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/reuse_widget/customDropDown.dart';
import 'package:provider/provider.dart';

class SendRequest extends StatefulWidget {
  final String walletKey;
  final String assetName;
  final String amount;
  SendRequest(this.walletKey, this.assetName, this.amount);
  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  TextEditingController recieveWallet;
  String asset = "";
  TextEditingController amount;
  TextEditingController memo = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Backend _backend = Backend();

  final List<TokenTypeModel> _tokenTypeModelList = [
    TokenTypeModel(
        tokenName: 'RISE',
        imageToken: Image.asset(
          'assets/images/rise-coin-icon.png',
          width: 22,
        )),
    TokenTypeModel(
        tokenName: 'SEL',
        imageToken: Image.asset(
          'assets/images/sel-coin-icon.png',
          width: 22,
        )),
  ];

  TokenTypeModel _tokenTypeModel = TokenTypeModel();
  List<DropdownMenuItem<TokenTypeModel>> _tokenTypeModelDropdownList;
  List<DropdownMenuItem<TokenTypeModel>> _buildTokenTypeModelDropdown(
      List tokenTypeModelList) {
    List<DropdownMenuItem<TokenTypeModel>> items = [];
    for (TokenTypeModel tokenTypeModel in tokenTypeModelList) {
      items.add(DropdownMenuItem(
        value: tokenTypeModel,
        child: Row(
          children: [
            tokenTypeModel.imageToken,
            SizedBox(width: 10.0),
            Text(tokenTypeModel.tokenName),
          ],
        ),
      ));
    }
    return items;
  }

  _onChangetokenTypeModelDropdown(TokenTypeModel tokenTypeModel) {
    setState(() {
      _tokenTypeModel = tokenTypeModel;
      asset = _tokenTypeModel.tokenName;
      amount.clear();
    });
  }

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submitValidate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _showDialogPassword(context, recieveWallet, amount, memo);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> _onSubmit() async {
    var _lang = AppLocalizeService.of(context);

    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        _backend.response = await PostRequest().sendPayment(
            _passwordController.text,
            recieveWallet.text,
            asset,
            amount.text,
            memo.text);
        var responseJson = json.decode(_backend.response.body);
        if (_backend.response.statusCode == 200) {
          Future.delayed(Duration(seconds: 2), () async {
            await Provider.of<BalanceProvider>(context, listen: false)
                .fetchPortfolio();
            await Provider.of<TrxHistoryProvider>(context, listen: false)
                .fetchTrxHistory();
            Timer(
                Duration(milliseconds: 500),
                () => Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: CompletePayment(),
                      ),
                      ModalRoute.withName('/navbar'),
                    ));
          });
        } else {
          await Components.dialog(
              context,
              textAlignCenter(text: responseJson['message']),
              warningTitleDialog());
          Navigator.of(context).pop();
          _passwordController.clear();
        }
      }
    } on SocketException catch (_) {
      await Components.dialog(
          context,
          textAlignCenter(text: _lang.translate('no_internet_message')),
          warningTitleDialog());
      Navigator.of(context).pop();
      _passwordController.clear();
    }
  }

  Future<String> _showDialogPassword(
    BuildContext context,
    TextEditingController recieveWallet,
    TextEditingController amount,
    TextEditingController memo,
  ) {
    var _lang = AppLocalizeService.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            // backgroundColor: Col,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            contentPadding:
                EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 5),
            title: new Text(
              'Enter Password',
              textAlign: TextAlign.center,
            ),
            content: TextFormField(
              controller: _passwordController,
              onSaved: (val) => _passwordController.text = val,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: _lang.translate('password_tf'),
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              obscureText: true,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            HexColor('0CACDA')),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 35)),
                      ),
                      child: Text('CANCEL'),
                      onPressed: () => {
                            Navigator.of(context).pop(),
                            _passwordController.clear(),
                          }),
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor('0CACDA')),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                      ),
                      child: Text('OK'),
                      onPressed: () => {
                            Navigator.of(context).pop(),
                            dialogLoading(context),
                            _onSubmit(),
                            Navigator.of(context).pop(),
                          }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    AppServices.noInternetConnection(globalKey);
    recieveWallet = TextEditingController(text: widget.walletKey);
    amount = TextEditingController(text: widget.amount.toString());

    // Value Dropdown
    _tokenTypeModelDropdownList =
        _buildTokenTypeModelDropdown(_tokenTypeModelList);
    _tokenTypeModel = _tokenTypeModelList[0];
    asset = _tokenTypeModel.tokenName;

    if (widget.assetName == "RISE") {
      _tokenTypeModel = _tokenTypeModelList[0];
      asset = _tokenTypeModel.tokenName;
    }

    if (widget.assetName == "SEL") {
      _tokenTypeModel = _tokenTypeModelList[1];
      asset = _tokenTypeModel.tokenName;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          _lang.translate('send_request'),
          style: TextStyle(
              color: Colors.black, fontFamily: 'Medium', fontSize: 22.0),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(_lang.translate('receive_address')),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) => val.isEmpty
                          ? _lang.translate('receive_address_validate')
                          : null,
                      onSaved: (val) => recieveWallet.text = val,
                      autovalidateMode: AutovalidateMode.always,
                      maxLength: null,
                      controller: recieveWallet ?? widget.walletKey,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.contact_page, color: HexColor('0CACDA')),
                        hintText: _lang.translate('receive_address'),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(_lang.translate('asset')),
                    SizedBox(height: 10.0),
                    CustomDropdown(
                      dropdownMenuItemList: _tokenTypeModelDropdownList,
                      onChanged: _onChangetokenTypeModelDropdown,
                      value: _tokenTypeModel,
                      isEnabled: true,
                    ),
                    SizedBox(height: 16.0),
                    Text(_lang.translate('amount')),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) => val.isEmpty
                          ? _lang.translate('amount_validate')
                          : null,
                      onSaved: (val) => amount.text = val,
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        _tokenTypeModel == _tokenTypeModelList[0]
                            ? FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,3}'))
                            : FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,5}'))
                      ],
                      controller: amount,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.coins,
                          color: primaryColor,
                        ),
                        hintText: _lang.translate('amount'),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Memo'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: memo,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.my_library_books,
                            color: HexColor('0CACDA')),
                        hintText: 'Memo (Optional)',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Center(
                      child: InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
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
                                _submitValidate();
                              },
                              child: Center(
                                child: Text(_lang.translate('send'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18)),
                              ),
                            ),
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
      ),
    );
  }
}

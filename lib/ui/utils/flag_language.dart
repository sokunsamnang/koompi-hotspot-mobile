import 'package:koompi_hotspot/core/models/lang.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:provider/provider.dart';

class LanguageView extends StatefulWidget {
  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String lang;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var data = Provider.of<LangProvider>(context);
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('language'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              });
        }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 4.0,
                margin:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(
                        "https://cdn.webshopapp.com/shops/94414/files/53596372/cambodia-flag-image-free-download.jpg",
                        height: 50,
                        width: 50,
                      ),
                      title: Text(_lang.translate('khmer')),
                      trailing: Consumer<LangProvider>(
                        builder: (context, value, child) => value.lang == 'KH'
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.blue[700],
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Colors.transparent,
                              ),
                      ),
                      onTap: () async { 
                        data.setLocal('KH', context);

                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => LoginPhone()),
                        //   ModalRoute.withName('/loginPhone'),
                        // );
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Image.network(
                        "https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/1200px-Flag_of_the_United_Kingdom.svg.png",
                        width: 50,
                        height: 50,
                      ),
                      trailing: Consumer<LangProvider>(
                        builder: (context, value, child) =>
                          value.lang == 'EN' || value.lang == 'US'
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.blue[700],
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: Colors.transparent,
                                ),
                      ),
                      title: Text(_lang.translate('english')),
                      onTap: () async {
                        data.setLocal('EN', context);
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => LoginPhone()),
                        //   ModalRoute.withName('/loginPhone'),
                        // );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

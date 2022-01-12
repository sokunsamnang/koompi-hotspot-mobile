import 'package:koompi_hotspot/all_export.dart';

class CompletePlan extends StatefulWidget {
  @override
  _CompletePlanState createState() => _CompletePlanState();
}

class _CompletePlanState extends State<CompletePlan> {
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(_lang.translate('complete'),
            style: TextStyle(fontFamily: 'Medium', color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 300,
                      child: FlareActor(
                        'assets/animations/success.flr',
                        animation: 'play',
                      ),
                    ),
                    Center(
                      child: Text(
                        _lang.translate('subscribe_complete'),
                        style: TextStyle(
                            fontFamily: 'Medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 100.0),
                    Center(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 25.0),
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
                                dialogLoading(context);
                                await Provider.of<BalanceProvider>(context,
                                        listen: false)
                                    .fetchPortfolio();
                                await Provider.of<TrxHistoryProvider>(context,
                                        listen: false)
                                    .fetchTrxHistory();
                                await Provider.of<GetPlanProvider>(context,
                                        listen: false)
                                    .fetchHotspotPlan();
                                Future.delayed(Duration(seconds: 3), () async {
                                  Timer(
                                      Duration(milliseconds: 500),
                                      () => Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: Navbar(0),
                                            ),
                                            ModalRoute.withName('/navbar'),
                                          ));
                                });
                              },
                              child: Center(
                                child: Text(_lang.translate('home'),
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
              ],
            ),
          ),
        ),
        onWillPop: () => Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: Navbar(0),
          ),
          ModalRoute.withName('/navbar'),
        ),
      ),
    );
  }
}

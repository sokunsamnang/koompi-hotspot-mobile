import 'package:koompi_hotspot/all_export.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // configOneSignal();
    AppServices.noInternetConnection(globalKey);
    versionCheck(context);
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(LineIcons.bars),
          color: primaryColor,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: RichText(
          text: TextSpan(
            text: 'KOOMPI ',
            style: GoogleFonts.nunito(
                fontSize: 18,
                letterSpacing: 1.0,
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700)),
            children: <TextSpan>[
              TextSpan(
                text: 'Fi-Fi',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
        actions: [
          InkWell(
            child: Badge(
              elevation: 0,
              badgeColor: Colors.transparent,
              toAnimate: false,
              position: BadgePosition.topEnd(top: 0, end: -2.5),
              badgeContent: Container(
                height: 20,
                width: 20,
                child: FlareActor(
                  'assets/animations/notification_badge.flr',
                  animation: 'hasNotification',
                ),
              ),
              child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: primaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Notifications()));
                  }),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Notifications()));
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<GetPlanProvider>(context, listen: false)
              .fetchHotspotPlan();
          await Provider.of<TrxHistoryProvider>(context, listen: false)
              .fetchTrxHistory();
          await Provider.of<BalanceProvider>(context, listen: false)
              .fetchPortfolio();
          await Provider.of<NotificationProvider>(context, listen: false)
              .fetchNotification();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: bodyPage(context),
          ),
        ),
      ),
    );
  }
}

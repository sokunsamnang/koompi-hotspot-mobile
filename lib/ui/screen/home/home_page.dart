import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    super.initState();
    versionCheck(context);
  }


  void dispose(){
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async{
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccount()));
              },
              child: CircleAvatar(
                backgroundImage: mData.image == null ? AssetImage('assets/images/avatar.png') : NetworkImage("${ApiService.avatar}/${mData.image}"),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'KOOMPI ',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins-Bold",
                  fontSize: 18,
                  letterSpacing: 1.0),
                children: <TextSpan>[
                  TextSpan(text: 'Fi-Fi', style: TextStyle(color: Color(0xff0caddb),fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications), 
              color: Colors.grey,
              onPressed: (){
                Navigator.push(
                  context, 
                  PageTransition(type: PageTransitionType.rightToLeft, 
                    child: NotificationScreen()));
              })
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
          await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio(context);
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
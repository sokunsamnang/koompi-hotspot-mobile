import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchWallet();
    });
    print('run version check');
    versionCheck(context);
  }

  void fetchWallet() async{
    await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
    await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
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
                backgroundImage: mData.image == null ? AssetImage('assets/images/avatar.png') : NetworkImage("https://api-hotspot.koompi.org/uploads/${mData.image}"),
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
                  TextSpan(text: 'Wi-Fi', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications), 
              color: Colors.grey,
              onPressed: (){
                snackBar(context);
              })
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: bodyPage(context),
          ),
        ),
      ),
    );   
  }
}
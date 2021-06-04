import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:koompi_hotspot/all_export.dart';

class TransactionDetail extends StatefulWidget {
  final List<TrxHistoryModel> history;
  final int index;
  TransactionDetail({this.history, this.index});
  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    var history = widget.history;
    var i = widget.index;
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details', style: TextStyle(color: Colors.black, fontSize: 18,fontFamily: 'Medium')),
        backgroundColor: HexColor('0CACDA'),
        centerTitle: true,
        elevation: 0,
        shadowColor: HexColor('0CACDA'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.black,
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ),
      backgroundColor: HexColor('0CACDA'),
      body: SingleChildScrollView(
        child: Container(
          color: HexColor('0CACDA'),
          child: Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.5, bottom: 0, left: 0, right: 0),  ///here we create space for the circle avatar to get ut of the box
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, right: 25, left: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),

                              mData.wallet == history[i].destination
                              ? 
                              Text(
                                _lang.translate('recieved'),
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700)
                                ),
                              )
                              : 
                              Text(
                                _lang.translate('sent'),
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w700)
                                ),
                              ),
                              
                              SizedBox(
                                height: 30.0,
                              ),

                              //========= Date & Time Transaction =========
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date',
                                        style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                        ),
                                      ),
                                      Text(
                                        AppUtils.timeStampToDate(history[i].createdAt),
                                        style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time',
                                        style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                        ),
                                      ),
                                      Text(
                                        AppUtils.timeStampToTime(history[i].createdAt),
                                        style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey[300],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              
                              //========= Amount Transaction =========
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount (SEL)',
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/sld.png', width: 15,),
                                      SizedBox(width: 5),
                                      Text(
                                        history[i].amount.toString() + " SEL",
                                        style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              //========= Fee Transaction =========
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fee (SEL)',
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/sld.png', width: 15,),
                                      SizedBox(width: 5),
                                      Text(
                                        history[i].fee.toString() + " SEL",
                                        style: GoogleFonts.nunito(
                                        textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                        ),
                                      ),
                                    ]
                                  )
                                ],
                              ),

                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey[300],
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //========= Transaction ID =========
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Transaction ID',
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Text(
                                    history[i].id,
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(
                                height: 15,
                              ),
                              //========= Sender ID =========
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'From',
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Text(
                                    history[i].sender,
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //========= Reciever ID =========
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'To',
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Text(
                                    history[i].destination,
                                    style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 25,
                              ),
                              //========= Repeat or Return Button =========
                              mData.wallet == history[i].destination 
                              ?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: HexColor('0CACDA'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SendRequest(history[i].sender, history[i].amount.toString())),
                                    );
                                  },
                                  elevation: 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    child: Text(
                                      'RETURN',
                                      style: GoogleFonts.nunito(
                                      textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              :
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: HexColor('0CACDA'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SendRequest(history[i].destination, history[i].amount.toString())),
                                    );
                                  },
                                  elevation: 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    child: Text(
                                      'REPEAT',
                                      style: GoogleFonts.nunito(
                                      textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              //========= Back Button =========
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(color: HexColor('0CACDA'), width: 2)
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  elevation: 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    child: Text(
                                      'BACK TO WALLET',
                                      style: GoogleFonts.nunito(
                                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),

                  // ========= Stack Center Image =========
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Container(
                          child: Image(
                            image: mData.wallet == history[i].destination 
                              ?
                              AssetImage('assets/images/circle_down_left.png')
                              :
                              AssetImage('assets/images/circle_right_up.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}
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
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  
  @override
  Widget build(BuildContext context) {
    
    var history = widget.history;
    var i = widget.index;
    var _lang = AppLocalizeService.of(context);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Transaction Details', style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Medium')),
        backgroundColor: HexColor('00336A'),
        centerTitle: true,
        elevation: 0,
        shadowColor: HexColor('00336A'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // background image and bottom contents
                  Column(
                    children: <Widget>[
                      Container(
                        height: 75.0,
                        color: HexColor('00336A'),
                      ),
                      Container(
                        color: Colors.white,
                      ),

                      SizedBox(
                        height: 40.0,
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

                      Padding(
                        padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 38),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
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
                                      AppUtils.timeStampToDate(history[i].datetime),
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
                                      AppUtils.timeStampToTime(history[i].datetime),
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
                                  'Amount (${history[i].symbol})',
                                  style: GoogleFonts.nunito(
                                  textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                  ),
                                ),
                                Row(
                                  children: [
                                    history[i].symbol == 'SEL' ?
                                    Image.asset('assets/images/sel-coin-icon.png', width: 22)
                                    :
                                    Image.asset('assets/images/rise-coin-icon.png', width: 22),
                                    SizedBox(width: 5),
                                    Text(
                                      '${history[i].amount} ${history[i].symbol}',
                                      style: GoogleFonts.nunito(
                                      textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            // SizedBox(
                            //   height: 15,
                            // ),
                            // //========= Fee Transaction =========
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Fee (SEL)',
                            //       style: GoogleFonts.nunito(
                            //       textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                            //       ),
                            //     ),
                            //     Row(
                            //       children: [
                            //         Image.asset('assets/images/sld.png', width: 15,),
                            //         SizedBox(width: 5),
                            //         Text(
                            //           history[i].fee+ " SEL",
                            //           style: GoogleFonts.nunito(
                            //           textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                            //           ),
                            //         ),
                            //       ]
                            //     )
                            //   ],
                            // ),

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
                            
                            history[i].memo != "" ? SizedBox(
                              height: 15,
                            ) : Container(),
                            // Memo
                            history[i].memo != "" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Memo',
                                  style: GoogleFonts.nunito(
                                  textStyle: TextStyle(color: HexColor('0CACDA'), fontSize: 15, fontWeight: FontWeight.w600)
                                  ),
                                ),
                                Text(
                                  history[i].memo,
                                  style: GoogleFonts.nunito(
                                  textStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400)
                                  ),
                                ),
                              ],
                            )
                            : Container(),

                            SizedBox(
                              height: 25,
                            ),
                            //========= Repeat or Return Button =========
                            mData.wallet == history[i].destination 
                            ?
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  primary: HexColor('0CACDA'),
                                  elevation: 2.5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(type: PageTransitionType.bottomToTop, 
                                      child: SendRequest(history[i].sender, history[i].amount.toString()),
                                    ),
                                  );
                                },
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
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  primary: HexColor('0CACDA'),
                                  elevation: 2.5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(type: PageTransitionType.bottomToTop, 
                                      child: SendRequest(history[i].destination, history[i].amount.toString()),
                                    ),
                                  );
                                },
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
                              height: 20,
                            ),
                            //========= Back Button =========
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  primary: HexColor('0CACDA'),
                                  elevation: 2.5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                          ],
                        ),
                      )
                    ],
                  ),

                  //  image
                  Positioned(
                    top: 25.0, // (background container size) - (circle height / 2)
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: mData.wallet == history[i].destination 
                            ?
                            AssetImage('assets/images/receive.png')
                            :
                            AssetImage('assets/images/send.png'),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
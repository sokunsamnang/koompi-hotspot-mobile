import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';

class UserPlan extends StatefulWidget {
  @override
  _UserPlanState createState() => _UserPlanState();
}

class _UserPlanState extends State<UserPlan>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController planUserController = TextEditingController();


  // DATE

  String finalDate = '';

  String finalDate1Hour = '';
  String finalDate3Hour = '';
  String finalDate5Hour = '';

  String finalDate1Day = '';
  String finalDate5Day = '';
  String finalDate7Day = '';

  //DropDown Variable
  
  final _planDropdown = const [
    "Hour",
    "Day",
  ];

  final hour = const {
    "1": "1 Hour",
    "2": "3 Hours",
    "3": "5 Hours"
  };

  final day = const {
    "1": "1 Day",
    "2": "5 Days",
    "3": "7 Days",
  };
  
  var _selectedPlanVal;
  var _selectedDateVal;
  List<String> _dateItem = [];

 void _changeDept({String currentPlan}) {
    setState(
      () {
        // update current university
        _selectedPlanVal = currentPlan;
        // reset dept val
        _selectedDateVal = 'Select Date';
        // update corresponding department
        // clear list
        _dateItem = ['Select Date'];
        _dateItem.addAll(_getDateItem(_selectedPlanVal));
      },
    );
  }

  List<String> _getDateItem(String currentPlan) {
    switch (currentPlan) {
      case 'Hour':
        return hour.values.toList();
        break;
      case 'Day':
        return day.values.toList();
        break;
      default:
        return null;
    }
  }


  //User Plan Button variable

  int user;
  List<int> userButton = [1, 3, 5];
  int userSelectedIndex;

  String userText = '';

  void userChangeIndex(
    int userIndex, TextEditingController planUserController) {
    setState(() {
      userSelectedIndex = userIndex;
      userText = planUserController.text;
    });
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    //DATE FORMAT
    var date = new DateTime.now().toString();
 
    var dateParse = DateTime.parse(date);

    var formattedDate1Hour = "Time ${dateParse.hour + 1}:${dateParse.minute} Date ${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var formattedDate3Hour = "Time ${dateParse.hour + 3}:${dateParse.minute} Date ${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var formattedDate5Hour = "Time ${dateParse.hour + 5}:${dateParse.minute} Date ${dateParse.day}-${dateParse.month}-${dateParse.year}";
 
    var formattedDate1day = "Time ${dateParse.hour}:${dateParse.minute} Date ${dateParse.day + 1}-${dateParse.month}-${dateParse.year}";
    var formattedDate5day = "Time ${dateParse.hour}:${dateParse.minute} Date ${dateParse.day + 5}-${dateParse.month}-${dateParse.year}";
    var formattedDate7day = "Time ${dateParse.hour}:${dateParse.minute} Date ${dateParse.day + 7}-${dateParse.month}-${dateParse.year}";
 
    setState(() {

      finalDate1Hour = formattedDate1Hour.toString();
      finalDate3Hour = formattedDate3Hour.toString();
      finalDate5Hour = formattedDate5Hour.toString();
      
      finalDate1Day = formattedDate1day.toString();
      finalDate5Day = formattedDate5day.toString();
      finalDate7Day = formattedDate7day.toString();
 
    });

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _expirationDate(){
    if(_selectedDateVal == day['1']){
      return Text('Expiration: $finalDate1Day ', style: TextStyle(fontSize: 20.0));
    }
    else if(_selectedDateVal == day['2']){
      return Text('Expiration: $finalDate5Day', style: TextStyle(fontSize: 20.0));
    }
    else if(_selectedDateVal == day['3']){
      return Text('Expiration: $finalDate7Day', style: TextStyle(fontSize: 20.0));
    }
    else if(_selectedDateVal == hour['1']){
      return Text('Expiration: $finalDate1Hour', style: TextStyle(fontSize: 20.0));
    }
    else if(_selectedDateVal == hour['2']){
      return Text('Expiration: $finalDate3Hour', style: TextStyle(fontSize: 20.0));
    }
    else if(_selectedDateVal == hour['3']){
      return Text('Expiration: $finalDate5Hour', style: TextStyle(fontSize: 20.0));
    }
    else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Hotspot Plan', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 16.0),
                Text('Select user:'),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child:
                          userCustomRadio(userButton[0], 0, planUserController),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child:
                          userCustomRadio(userButton[1], 1, planUserController),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child:
                          userCustomRadio(userButton[2], 2, planUserController),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text('Select plan:'),
                SizedBox(height: 5.0),
                selectPlan(),
                SizedBox(height: 50.0),
                Center(
                  child: RaisedButton(
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        fontSize: 20,
                        letterSpacing: 1,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blueAccent)),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => _reviewPlan(
                                  usernameController,
                                  user,
                                  _selectedDateVal,)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectPlan(){
    print(_selectedDateVal);
    print(_selectedPlanVal);
    return Row(
      children: <Widget>[
        //First DropdownBox              
        Expanded(
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))
                )),
              hint: Text('Select Plan'),
              value: _selectedPlanVal,
              onChanged: (val) => _changeDept(currentPlan: val),
              items: _planDropdown.map(
                (item) {
                  return DropdownMenuItem(
                    child: Text('$item'),
                    value: item,
                  );
                },
              ).toList(),
            ),
          
        ),
        SizedBox(width: 20),
        //Second DropdownBox
        Expanded(        
          child: DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))
                )),
              hint: Text('Select Date'),
              value: _selectedDateVal,
              onChanged: (val) => setState(() => _selectedDateVal = val),
              items: _dateItem.map(
                (item) {
                  return DropdownMenuItem(
                    child: Text('$item'),
                    value: item,
                );
              },
            ).toList(),
          ), 
        ),
      ],
    );
  }
  Widget userCustomRadio(int userButton, int userIndex, TextEditingController planUserController) {
    return ButtonTheme(
      height: 50.0,
      child: OutlineButton(
        onPressed: () async {
          userChangeIndex(userIndex, planUserController);
          user = userButton;
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        splashColor: Colors.transparent,
        borderSide: BorderSide(
            color: userSelectedIndex == userIndex ? Colors.cyan : Colors.grey),
        child: Text(
          "$userButton User",
          style: TextStyle(
              color:
                  userSelectedIndex == userIndex ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget _reviewPlan(
      usernameController,
      user,
      _selectedDateVal) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  child: FlareActor( 
                    'assets/animations/alert_icon.flr', 
                    alignment: Alignment.topCenter,
                    fit: BoxFit.contain,
                    animation: 'show',
                  ),
                ),
                Center(
                  child: Text('Please review before buy', 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                SizedBox(height: 25.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Container(
                      child: Text('Username: ${usernameController.text}',style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Text('User: $user user',style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Text('Date: $_selectedDateVal',style: TextStyle(fontSize: 20.0)),
                    ),
                    SizedBox(height: 10.0),
                    _expirationDate(),
                  ],
                ),
                
                SizedBox(height: 50.0),
                Center(
                  child: RaisedButton(
                    child: Text(
                      'BUY',
                      style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        fontSize: 20,
                        letterSpacing: 1,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blueAccent)),
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Navbar()),
                        ModalRoute.withName('/navbar')
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


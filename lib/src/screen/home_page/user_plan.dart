import 'package:flutter/material.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Hotspot Plan', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
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
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
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
              Row(
                children: <Widget>[
                  //First DropdownBox              
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
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
                  ),

                  //Second DropdownBox
                  Expanded(        
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
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
                  ),
                ],
              ),
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
                      side: BorderSide(color: Colors.deepOrange)),
                  onPressed: () async {
                    print(user);
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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
      TextEditingController usernameController,
      user,
      _selectedDateVal) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Username: ${usernameController.text}'),
            Text('User: $user user'),
            Text('User: $_selectedDateVal'),
          ],
        ),
      ),
    );
  }
}


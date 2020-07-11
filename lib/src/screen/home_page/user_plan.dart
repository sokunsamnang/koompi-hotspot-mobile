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
  final TextEditingController planDateController = TextEditingController();
  final TextEditingController planTimeController = TextEditingController();

  int user;

  String value = "";
  List<DropdownMenuItem<String>> menuitems = List();  
  bool disabledropdown = true;

  final hour = {
    "1" : "1 Hour",
    "2" : "3 Hours",
    "3" : "5 Hours",
  };

  final day = {
    "1" : "1 Days",
    "2" : "3 Days",
    "3" : "5 Days",
  };

  void dropdownHour(){
    for(String key in hour.keys){
      menuitems.add(DropdownMenuItem<String>(
        child : Center(
          child: Text(
            hour[key]
          ),
        ),
        value: hour[key],
      ));
    }
  }

  void dropdownDay(){
    for(String key in day.keys){
      menuitems.add(DropdownMenuItem<String>(
        child : Center(
          child: Text(
            day[key]
          ),
        ),
        value: day[key],
      ));
    }
  }

  void firstDropdownselected(_value){
    if(_value == "Hour"){
      menuitems = [];
      dropdownHour();
    }else if(_value == "Day"){
      menuitems = [];
      dropdownDay();
    }
    setState(() {
      value = _value;
      disabledropdown = false;
    });
  }

  void secondDropdownselected(_value){
    setState(() {
      value = _value;    
    });
  }




  //User Plan Button variable
  List<int> userButton = [1, 3, 5];
  int userSelectedIndex = 0;

  String userText = '';

  void userChangeIndex(
      int userIndex, TextEditingController planUserController) {
    setState(() {
      userSelectedIndex = userIndex;
      userText = planUserController.text;
    });
  }

  //Plan Time Dropdown variable
  String _selectedPlan;
  String _selectedDate;

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
              Row(
                children: <Widget>[
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem<String>(
                        value: "Hour",
                        child: Center(
                          child: Text("Hour"),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Day",
                        child: Center(
                          child: Text("Day"),
                        ),
                      ),
                    ],
                    onChanged: (_value) => firstDropdownselected(_value),
                    hint: Text(
                      "Select Plan"
                    ),
                  ),
                  DropdownButton<String>(
                    items: menuitems,
                    onChanged: disabledropdown ? null : (_value) => secondDropdownselected(_value),
                    hint: Text(
                      "Select Date"
                    ),
                    disabledHint: Text(
                      "First Select Plan"
                    ),
                  ),
                  Text(
                    "$value",
                    style: TextStyle(
                      fontSize: 20.0,
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => _reviewPlan(
                    //             usernameController,
                    //             passwordController,
                    //             planUserController,
                    //             planDateController,
                    //             planTimeController)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userCustomRadio(int userButton, int userIndex,
      TextEditingController planUserController) {
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

  Widget planDropdown(Function plandropdown) {
    return DropdownButton<String>(
      hint: Text('Select Plan'),
      value: _selectedPlan,
      items: ['Hour', 'Day']
          .map((plan) =>
              DropdownMenuItem<String>(child: Text(plan), value: plan))
          .toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedPlan = newValue;
        });
      },
    );
  }

  Widget _addSecondDropdown(List select) {
    return select != null
        ? DropdownButton<String>(
            hint: Text('Select Date'),
            value: _selectedDate,
            items: select
                .map((date) =>
                    DropdownMenuItem<String>(child: Text(date), value: date))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedDate = newValue;
              });
            })
        : Container(); // Return an empty Container instead.
  }

  Widget _reviewPlan(
      TextEditingController usernameController,
      passwordController,
      planUserController,
      planDateController,
      planTimeController) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Username: ${usernameController.text}'),
            Text('User: ${planUserController.text}')
          ],
        ),
      ),
    );
  }
}

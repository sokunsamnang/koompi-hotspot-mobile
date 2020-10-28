import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_location.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/services/services.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _submitValidate(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      _onSubmit();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
  
  Future <void> _onSubmit() async {
    dialogLoading(context);
    try {
      
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().completeInfoUser(
          emailController.text,
          fullnameController.text,
          gender,
          birthdate,
          address);
          
        if (response.statusCode == 200) {
          setState(() {
            StorageServices().updateUserData(context);
          });
          
        } 
        else {
          print('update info not Successful');
          showErrorServerDialog(context);
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
  
  showErrorServerDialog(BuildContext context) async {
    var response = await PostRequest().completeInfoUser(
          emailController.value.text,
          fullnameController.value.text,
          gender,
          birthdate,
          address);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${response.body}'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
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


  //Get Data
  String name = mData.name;
  String gender = mData.gender;
  String email = mData.email;
  String birthdate = mData.birthdate;
  String address = mData.address;
  

  TextEditingController fullnameController = TextEditingController(text: '${mData.name}');
  TextEditingController emailController = TextEditingController(text: '${mData.email}');

  //LocationPicker
  var locationModel = LocationList();

  //Image Profile
  File _image;

  //Gender Select 
  List<String> lst = ['Male', 'Female'];
  String selectedIndex;
  
  void changeIndex(String index) {
    setState(() {
      gender = index;
    });
  }

  //DOB Picker
  DateTime selectedDate = DateTime.now();

  final dateFormart = new DateFormat('dd-MMM-yyyy');

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1770, 1),
      lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        birthdate = dateFormart.format(selectedDate);
      });
  }
  
  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit Account', style: TextStyle(color: Colors.black)),
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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.blueAccent,
                ),
                onPressed: () async {
                  setState(() {
                    _submitValidate();
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 2,
        child: Form(
          key: formKey,
          autovalidate: _autoValidate,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: const Color(0xff476cfb),
                      child: ClipOval(
                        child: SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: (_image != null)
                              ? Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                )
                              : CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: FlatButton(
                      colorBrightness: Brightness.dark,
                      child: Text('Edit Profile Photo',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontFamily: 'Medium')
                            ),
                      onPressed: () => getImage(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Full Name'),
                  SizedBox(height: 10.0),
                  TextFormField(
                    validator: (val) => val.length < 3 ? 'Full Name is required' : null,
                    onSaved: (val) => fullnameController.text = val,
                    autovalidate: true,
                    controller: fullnameController ?? '',
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black, width: 2),
                      // ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Email'),
                  SizedBox(height: 10.0),
                  Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))
                    ),
                    child: ListTile(
                      title: Text(
                        mData.email
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Date Of Birth'),
                  SizedBox(height: 10.0),
                  dateOfbirth(selectedDate, _selectDate, dateFormart, context),
                  SizedBox(height: 16.0),
                  Text('Gender'),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: genderCustomRadio(lst[0], 'Male'),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: genderCustomRadio(lst[1], 'Female'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text('Location'),
                  SizedBox(height: 10.0),
                  locationPicker(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget genderCustomRadio(String txt, String index) {
    return ButtonTheme(
      height: 50.0,
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        splashColor: Colors.transparent,
        borderSide: BorderSide(
            color: gender == index ? Colors.cyan : Colors.grey),
        child: Text(txt,
          style: TextStyle(
              color: gender == index ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget locationPicker(BuildContext context) {
    return _LocationDropdown(
      valueText: address ?? locationModel.selectedKhLocation.toString(),
      onPressed: () => showMaterialScrollPicker(
        context: context,
        title: "Pick Your Location",
        items: locationModel.khLocation,
        selectedItem: locationModel.selectedKhLocation,
        onChanged: (value) =>
          setState(() => locationModel.selectedKhLocation = value),
        onCancelled: () => print("Scroll Picker cancelled"),
        onConfirmed: () => address = locationModel.selectedKhLocation,
      ),
    );
  }

  Widget dateOfbirth(DateTime selectedDate, _selectDate, dateFormart, context){
    return _DateDropdown(
      valueText: birthdate ?? 'Select Date of Birth',
      onPressed: (){
        _selectDate(context);
        
      },
    );
  }
}


class _DateDropdown extends StatelessWidget {
  const _DateDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          hoverColor: Colors.black,
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.date_range,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}


class _LocationDropdown extends StatelessWidget {
  const _LocationDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          hoverColor: Colors.black,
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.location_city,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_location.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';

class CompleteInfo extends StatefulWidget {

  final String email;
  CompleteInfo(this.email);
  
  @override
  _CompleteInfoState createState() => _CompleteInfoState();
}

class _CompleteInfoState extends State<CompleteInfo>{
  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController;

  
  @override
  void initState() {
    
    _emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  String _address;
  
  //Location
  var locationModel = LocationList();

  //Image Profile
  File _image;

  //Gender 
  
  List<String> lst = ['Male', 'Female'];
  String selectedIndex;
  String _gender;
  void changeIndex(String index) {
    setState(() {
      _gender = index;
    });
  }

  //DOB Picker
  DateTime selectedDate = DateTime.now();
  
  String _birthdate;

  final dateFormart = new DateFormat('dd-MMM-yyyy');
  
  Future <void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1770, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _birthdate = dateFormart.format(selectedDate);
      });
  }
  
  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      print('Validated');
      print(_usernameController.text);
      print(_emailController.text);
      print(_birthdate);
      print(_gender);
      print(_address);
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
  
  Future <void> _onSubmitBtn() async {
    _submit();
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().completeInfoUser(
          _emailController.text,
          _usernameController.text,
          _gender,
          _birthdate,
          _address);
        
        if (response.statusCode == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            ModalRoute.withName('/'),
          );
        } 
        else {
          Navigator.pop(context);
          print('register not Successful');
        }
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
    }
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
        title: Text('Complete Profile', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
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
                  _onSubmitBtn();
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
                      child: Text('Add Profile Photo',
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
                    controller: _usernameController,
                    validator: (val) => val.length < 3 ? 'Full Name is required' : null,
                    onSaved: (val) => _usernameController.text = val,
                    autovalidate: true,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Email'),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController ?? widget.email,
                    autovalidate: true,
                    validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
                    onSaved: (val) => _emailController.text = val,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Date Of Birth'),
                  SizedBox(height: 10.0),
                  
                  // dateOfbirth(selectedDate, _selectDate, dateFormart, context),
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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        splashColor: Colors.transparent,
        borderSide: BorderSide(
            color: _gender == index ? Colors.cyan : Colors.grey),
        child: Text(txt,
          style: TextStyle(
              color: _gender == index ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget locationPicker(BuildContext context) {
    return _LocationDropdown(
      valueText: _address ?? locationModel.selectedKhLocation.toString(),
      onPressed: () => showMaterialScrollPicker(
        context: context,
        title: "Pick Your Location",
        items: locationModel.khLocation,
        selectedItem: locationModel.selectedKhLocation,
        onChanged: (value) =>
          setState(() => locationModel.selectedKhLocation = value),
        onCancelled: () => print("Scroll Picker cancelled"),
        onConfirmed: () => _address = locationModel.selectedKhLocation,
      ),
    );
  }

  Widget dateOfbirth(DateTime selectedDate, _selectDate, dateFormart, context){
    return _DateDropdown(
      valueText: _birthdate ?? 'Select Date of Birth',
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
            borderRadius: BorderRadius.all(Radius.circular(30.0))
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
            borderRadius: BorderRadius.all(Radius.circular(30.0))
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
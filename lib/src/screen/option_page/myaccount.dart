import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:koompi_hotspot/src/models/model_location.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
  String myName = mData.fullname;

  TextEditingController fullnameController = TextEditingController(text: '${mData.fullname}') ;

  //LocationPicker
  var locationModel = LocationList();

  //Image Profile
  File _image;

  //Gender Select 
  List<String> lst = ['Male', 'Female'];
  int selectedIndex;
  
  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
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
                  
                },
              ),
            ),
          ),
        ],
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
                TextFormField(
                  controller: fullnameController,
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
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                Text('Date Of Birth'),
                SizedBox(height: 10.0),
                dateOfbirth(selectedDate, _selectDate, dateFormart, context),
                SizedBox(height: 16.0),
                Text('Gender'),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: genderCustomRadio(lst[0], 0),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: genderCustomRadio(lst[1], 1),
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
    );
  }

  Widget genderCustomRadio(String txt, int index) {
    return ButtonTheme(
      height: 50.0,
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        splashColor: Colors.transparent,
        borderSide: BorderSide(
            color: selectedIndex == index ? Colors.cyan : Colors.grey),
        child: Text(
          txt,
          style: TextStyle(
              color: selectedIndex == index ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget locationPicker(BuildContext context) {
    print(locationModel.selectedKhLocation);

    return _LocationDropdown(
      valueText: locationModel.selectedKhLocation.toString(),
      onPressed: () => showMaterialScrollPicker(
        context: context,
        title: "Pick Your Location",
        items: locationModel.khLocation,
        selectedItem: locationModel.selectedKhLocation,
        onChanged: (value) =>
            setState(() => locationModel.selectedKhLocation = value),
        onCancelled: () => print("Scroll Picker cancelled"),
        onConfirmed: () => print("Scroll Picker confirmed"),
      ),
    );
  }
}

  Widget dateOfbirth(DateTime selectedDate, _selectDate, dateFormart, context){
    return _DateDropdown(
      valueText: dateFormart.format(selectedDate),
      onPressed: (){
        _selectDate(context);
      },
    );
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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class VerificationAccount extends StatefulWidget {
  @override
  _VerificationAccountState createState() => _VerificationAccountState();
}

class _VerificationAccountState extends State<VerificationAccount>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  File _image;

  List<String> lst = ['Male', 'Female'];
  int selectedIndex = 0;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  DateTime selectedDate = DateTime.now();

  final dateFormart = new DateFormat('dd-MM-yyyy');

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
  void dispose() {
    super.dispose();
    _controller.dispose();
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
        title: Text('User Infomation', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.blueAccent,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                              backgroundImage: NetworkImage(
                                "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  colorBrightness: Brightness.dark,
                  child: Text('Add Profile',
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
                decoration: InputDecoration(
                  hintText: 'First Name',
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
                  hintText: 'Last Name',
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
              Text('Gender:'),
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
              dateOfbirth(selectedDate, _selectDate, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderCustomRadio(String txt, int index) {
    return ButtonTheme(
      height: 50.0,
      child: OutlineButton(
        onPressed: () async {
          changeIndex(index);
        },
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
}

  Widget dateOfbirth(DateTime selectedDate, _selectDate, context){
    return _InputDropdown(
      labelText: 'Date Of Birth',
      valueText: DateFormat.yMMMMd().format(selectedDate),
      onPressed: (){
        _selectDate(context);
      },
    );
  }

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
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
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
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
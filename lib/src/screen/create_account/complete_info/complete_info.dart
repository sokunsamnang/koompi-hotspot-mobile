import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:intl/intl.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_location.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/login/login_email.dart';
import 'package:koompi_hotspot/src/welcome_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CompleteInfo extends StatefulWidget {

  final String email;
  CompleteInfo(this.email);
  
  @override
  _CompleteInfoState createState() => _CompleteInfoState();
}

class _CompleteInfoState extends State<CompleteInfo>{
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool _autoValidate = false;
  String lastChoiceChipSelection = '';

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController;

  
  @override
  void initState() {
    _address = 'Phnom Penh';
    _birthdate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    _emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Location
  String _address;
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
  
  void _submitValidate(BuildContext context){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      _submit();
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
  
  Future <void> _submit() async {
    // _submit(context);
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
          Future.delayed(Duration(seconds: 2), () {
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
              ModalRoute.withName('/welcome'),
            ));
          });
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

  Future<void> loadAsset() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: false,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        maxImages: 1,
        materialOptions: MaterialOptions(
          actionBarColor: '#${Color(0xFF303F9F).value.toRadixString(16)}',
          actionBarTitle: "KOOMPI Hotspot",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      setState(() {
        getAssettoFile(resultList);
      });
    } catch (e) {
      e.toString();
    }
    if (!mounted) return;
  }

  Future<void> getAssettoFile(List<Asset> resultList) async {
    for (Asset asset in resultList) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      _image = File(filePath);
      if (filePath != null) {
        print("Image $filePath");
        await PostRequest().upLoadImage(File(filePath)).then((value) {
          print("My response $value");
          // setState(() {
          //   imageUrl = json.decode(value.body)['uri'];
          //   mData.image = imageUrl;
          // });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  // _onSubmitBtn();
                  _submitValidate(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
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
                                    backgroundImage: mData.image == null
                                        ? AssetImage('assets/images/avatar.png')
                                        : NetworkImage(
                                            "https://api-hotspot.koompi.org/uploads/${mData.image}"),
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
                        onPressed: () => loadAsset(),
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
                        prefixIcon: Icon(LineIcons.user),
                        hintText: 'Full Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Email'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _emailController ?? widget.email,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Date Of Birth'),
                    SizedBox(height: 10.0),
                    // FormBuilderDateTimePicker(
                    //   onFieldSubmitted: (value) {
                    //     if(value != null && value != selectedDate){
                    //       selectedDate = value;
                    //       _birthdate = dateFormart.format(selectedDate);
                    //     }
                    //   },
                    //   validators: [
                    //     FormBuilderValidators.required(),
                    //   ],
                    //   attribute: "date",
                    //   inputType: InputType.date,
                    //   format: DateFormat("dd-MMM-yyyy"),
                    //   decoration:
                    //     InputDecoration(labelText: "Date Of Birth"),
                    // ),
                    dateOfbirth(selectedDate, _selectDate, dateFormart, context),
                    SizedBox(height: 10.0),
                    // Text('Gender'),
                    // SizedBox(height: 10.0),
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: genderCustomRadio(lst[0], 'Male'),
                    //     ),
                    //     SizedBox(width: 20.0),
                    //     Expanded(
                    //       child: genderCustomRadio(lst[1], 'Female'),
                    //     ),
                    //   ],
                    // ),
                    FormBuilderChoiceChip(
                      onSaved: (newValue) => _gender = newValue,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 20)
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Medium"
                      ),
                      selectedColor: Colors.cyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 2,
                      alignment: WrapAlignment.spaceBetween,
                      labelPadding: EdgeInsets.only(left: 35, right: 35),
                      attribute: "gender",
                    options: [
                        FormBuilderFieldOption(value: 'Male'),
                        FormBuilderFieldOption(value: 'Female'),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          //* If chip unselected, set value to last selection
                          formKey.currentState.fields['gender'].currentState
                              .didChange(lastChoiceChipSelection);
                        } else {
                          //* If chip selected, save the value and rebuild
                          setState(() {
                            lastChoiceChipSelection = value;
                          });
                        }
                      },
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
      ),
    );
  }

  Widget genderCustomRadio(String txt, String index) {
    return ButtonTheme(
      height: 50.0,
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
        title: "Phnom Penh",
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
      valueText: _birthdate ?? "Pick your DOB",
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(Icons.date_range_outlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
            SizedBox(width: 10),
            new Text(valueText, style: valueStyle),
            
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(Icons.location_city_outlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
            SizedBox(width: 10),
            new Text(valueText, style: valueStyle),
          ],
        ),
      ),
    );
  }
}
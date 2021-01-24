import 'package:intl/intl.dart';
import 'package:koompi_hotspot/src/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/all_export.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String imageUrl;

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

  void _submitValidate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _onSubmit();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> _onSubmit() async {
    dialogLoading(context);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        var response = await PostRequest().completeInfoUser(
          fullnameController.text,
          phoneController.text,
          gender,
          birthdate,
          address);
        if (response.statusCode == 200) {
          setState(() {
            StorageServices().updateUserData(context);
          });
        } else {
          Navigator.pop(context);
          print('update info not Successful');
          showErrorServerDialog(context);
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  showErrorServerDialog(BuildContext context) async {
    
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Update info not successfully'),
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
  String name = mData.fullname;
  String gender = mData.gender;
  String email = mData.email;
  String birthdate = mData.birthdate;
  String address = mData.address;

  TextEditingController fullnameController =
      TextEditingController(text: '${mData.fullname}');
  TextEditingController phoneController =
      TextEditingController(text: '${mData.phone}');

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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        child: Text('Edit Profile Photo',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontFamily: 'Medium')),
                        onPressed: () => loadAsset(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text('Full Name'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) =>
                          val.length < 3 ? 'Full Name is required' : null,
                      onSaved: (val) => fullnameController.text = val,
                      autovalidateMode: AutovalidateMode.always,
                      controller: fullnameController ?? '',
                      decoration: InputDecoration(
                        prefixIcon: Icon(LineIcons.user),
                        hintText: 'Full Name',
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black, width: 2),
                        // ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                        )),
                    ),
                    SizedBox(height: 16.0),
                    Text('Phone Number'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      readOnly: true,
                      controller: phoneController ?? '',
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          )),
                    ),
                    SizedBox(height: 16.0),
                    Text('Date Of Birth'),
                    SizedBox(height: 10.0),
                    dateOfbirth(selectedDate, _selectDate, dateFormart, context),
                    SizedBox(height: 16.0),
                    Text('Location'),
                    SizedBox(height: 10.0),
                    locationPicker(context),
                    SizedBox(height: 16.0),
                    Text('Gender'),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => changeIndex('Male')),
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 1),
                                  ],
                                  color: gender == 'Male'
                                      ? Colors.cyan
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.male),
                                    Text('Male',
                                        style: TextStyle(
                                            fontFamily: "Medium",
                                            color: gender == 'Male'
                                                ? Colors.black
                                                : Colors.grey))
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => changeIndex('Female')),
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 1),
                                  ],
                                  color: gender == 'Female'
                                      ? Colors.cyan
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.female),
                                    Text('Female',
                                        style: TextStyle(
                                            fontFamily: "Medium",
                                            color: gender == 'Female'
                                                ? Colors.black
                                                : Colors.grey))
                                  ],
                                )),
                          ),
                        ),
                        // Expanded(
                        //   child: genderCustomRadio(lst[0], 'Male'),
                        // ),
                        // SizedBox(width: 20.0),
                        // Expanded(
                        //   child: genderCustomRadio(lst[1], 'Female'),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget genderCustomRadio(String txt, String index) {
  //   return ButtonTheme(
  //     height: 50.0,
  //     child: OutlineButton(
  //       onPressed: () => changeIndex(index),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  //       splashColor: Colors.transparent,
  //       borderSide: BorderSide(
  //           color: gender == index ? Colors.cyan : Colors.grey),
  //       child: Text(txt,
  //         style: TextStyle(
  //             color: gender == index ? Colors.black : Colors.grey),
  //       ),
  //     ),
  //   );
  // }

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

  Widget dateOfbirth(DateTime selectedDate, _selectDate, dateFormart, context) {
    return _DateDropdown(
      valueText: birthdate ?? 'Select Date of Birth',
      onPressed: () {
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
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
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

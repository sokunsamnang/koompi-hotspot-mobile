import 'package:koompi_hotspot/all_export.dart';
import 'package:intl/intl.dart';
import 'package:koompi_hotspot/ui/reuse_widget/reuse_widget.dart';

class CompleteInfo extends StatefulWidget {

  final String phone;
  CompleteInfo(this.phone);
  
  @override
  _CompleteInfoState createState() => _CompleteInfoState();
}

class _CompleteInfoState extends State<CompleteInfo>{
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String lastChoiceChipSelection = '';

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController;

  
  @override
  void initState() {
    _address = 'Phnom Penh';
    _birthdate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    _phoneController = TextEditingController(text: widget.phone);
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
  File image;

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
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: primaryColor),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
    );
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
        autovalidateMode = AutovalidateMode.always;
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
          _usernameController.text,
          widget.phone,
          _gender,
          _birthdate,
          _address);
        
        if (response.statusCode == 200) {
          Future.delayed(Duration(seconds: 2), () {
            Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
              context,
              PageTransition(type: PageTransitionType.rightToLeft, 
                child: LoginPhone(),
              ),
              ModalRoute.withName('/loginPhone'),
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

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_lang.translate('complete_profile_appbar'), style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 36.0),
                    Text(_lang.translate('fullname')),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _usernameController,
                      validator: (val) => val.length < 3 ? _lang.translate('fullname_validate') : null,
                      onSaved: (val) => _usernameController.text = val,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        prefixIcon: Icon(LineIcons.user, color: primaryColor),
                        hintText: _lang.translate('fullname'),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.red
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.red
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(_lang.translate('phone_number_tf'),),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _phoneController ?? widget.phone,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: _lang.translate('phone_number_tf'),
                        prefixIcon: Icon(Icons.phone, color: primaryColor),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.red
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.red
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(_lang.translate('dateofbirth'),),
                    SizedBox(height: 10.0),
                    dateOfbirth(selectedDate, _selectDate, dateFormart, context),
                    SizedBox(height: 16.0),
                    Text(_lang.translate('locaton'),),
                    SizedBox(height: 10.0),
                    locationPicker(context),
                    SizedBox(height: 10.0),
                    FormBuilderChoiceChip(
                      onSaved: (newValue) => _gender = newValue,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: _lang.translate('gender'),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 20)
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Medium"
                      ),
                      selectedColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 2,
                      alignment: WrapAlignment.spaceBetween,
                      labelPadding: EdgeInsets.only(left: 35, right: 35),
                      attribute: "gender",
                      options: [
                        FormBuilderFieldOption(value: 'Male', child: Text(_lang.translate('male'))),
                        FormBuilderFieldOption(value: 'Female', child: Text(_lang.translate('female')))
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
                  ],
                ),
              ),
            ),
          ),
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.red
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.red
            ),
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
                color: primaryColor),
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.red
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.red
            ),
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
                color: primaryColor),
            SizedBox(width: 10),
            new Text(valueText, style: valueStyle),
          ],
        ),
      ),
    );
  }
}
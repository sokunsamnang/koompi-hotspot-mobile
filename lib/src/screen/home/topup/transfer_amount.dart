import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';

class ConfrimTransferAmount extends StatefulWidget {

  final String email; String userName;

  ConfrimTransferAmount(this.email, this.userName);

  @override
  _ConfrimTransferAmountState createState() => _ConfrimTransferAmountState();
}

class _ConfrimTransferAmountState extends State<ConfrimTransferAmount> {

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _amountController = TextEditingController();

  void _submitValidate(BuildContext context){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Navbar()),
        ModalRoute.withName('/'),
      );
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Transfer Credit', style: TextStyle(color: Colors.black)),
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
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _nameBar(context),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _creditAmount(context),
            ),
            SizedBox(height: 50),
            Center(
              child: _btnTransfter(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _nameBar(BuildContext context) {

    return Row(
      children: <Widget>[
        CircleAvatar(
          // backgroundImage: image == null ? AssetImage('assets/images/avatar.png') : NetworkImage(image),
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 
              'User',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent)
            ),
            Text( 
              widget.email,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent)
            ),
          ],
        )
      ],
    );
  }

  Widget _creditAmount(BuildContext context){
    return Form(
      key: formKey,
      autovalidate: _autoValidate,
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        child:  TextFormField(
          controller: _amountController,
          validator: (val) => val.length < 1 ? 'Amount Required' : null,
          onSaved: (val) => _amountController.text = val,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            hintText: 'Enter Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))
            )
          ),
        ),
      ),
    );
  }

  Widget _btnTransfter(BuildContext context){
    return InkWell(
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6078ea).withOpacity(.3),
              offset: Offset(0.0, 8.0),
              blurRadius: 8.0)
          ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              _submitValidate(context);
                
            },
            child: Center(
              child: Text("TRANSFER",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Bold",
                      fontSize: 18,
                      letterSpacing: 3.0)),
            ),
          ),
        ),
      ),
    );
  }

}
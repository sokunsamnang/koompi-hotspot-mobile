import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/edit_plan.dart';
import 'package:line_icons/line_icons.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('My Plan', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Edit Your Plan"),
                      trailing: Icon(LineIcons.angle_right),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUserPlan()));
                      }
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(Icons.cancel),
                      title: Text("Unsubscribe"),
                      onTap: () async {
                        
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
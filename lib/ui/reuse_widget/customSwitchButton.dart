import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/all_export.dart';

class SwitchControl extends StatefulWidget {
  SwitchControl({
    this.value = false,
    @required this.onChanged,
  });

  bool value;
  final ValueChanged<bool> onChanged;

  @override
  _SwitchControlState createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl> {
  Alignment switchControlAlignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: widget.value ? primaryColor : Color(0xFFDCDCDC),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.decelerate,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          widget.value = !widget.value;
          widget.onChanged(widget.value);
        });
      },
    );
  }
}
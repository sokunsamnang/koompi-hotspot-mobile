import 'package:flutter/material.dart';

class PersistentHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 3,
                  width: 30,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}

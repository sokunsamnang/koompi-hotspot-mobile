import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class NoInterntConnection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height * 2,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: FlareActor( 
                    'assets/animations/no_internet_connection.flr', 
                    animation: 'start',
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}

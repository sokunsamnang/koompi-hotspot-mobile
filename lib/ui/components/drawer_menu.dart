import 'package:flutter/material.dart';
import 'package:koompi_hotspot/all_export.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Drawer(
      child: ListView(
        children: [
          // DrawerHeader(
          //   child: Image.asset("assets/images/logo.png"),
          // ),
          DrawerListTile(
            title: "Home",
            iconSrc: LineIcons.home,
            press: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(type: PageTransitionType.leftToRight, 
                  child: Navbar(0),
                ),
                ModalRoute.withName('/navbar'),
              );
            },
          ),
          DrawerListTile(
            title: "Fi-Fi Maps",
            iconSrc: LineIcons.map,
            press: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(type: PageTransitionType.rightToLeft, 
                  child: Navbar(1),
                ),
                ModalRoute.withName('/navbar'),
              );
            },
          ),
          DrawerListTile(
            title: "Fi-Fi",
            iconSrc: Icons.wifi_outlined,
            press: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(type: PageTransitionType.rightToLeft, 
                  child: Navbar(2),
                ),
                ModalRoute.withName('/navbar'),
              );
            },
          ),
          DrawerListTile(
            title: "Profile",
            iconSrc: LineIcons.portrait,
            press: () {
              Navigator.push(context,
                PageTransition(type: PageTransitionType.rightToLeft, 
                  child: MyAccount(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "More",
            iconSrc: LineIcons.bars,
            press: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(type: PageTransitionType.rightToLeft, 
                  child: Navbar(3),
                ),
                ModalRoute.withName('/navbar'),
              );
            },
          ),
          DrawerListTile(
            title: "Sign Out",
            iconSrc: LineIcons.alternateSignOut,
            iconColor: Colors.red,
            press: () async {
              await Components.dialogSignOut(
                context,
                Text(_lang.translate('sign_out_warn'), textAlign: TextAlign.center),
                Text(_lang.translate('warning'), style: TextStyle(fontFamily: 'Poppins-Bold'),),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.iconSrc,
    this.iconColor,
    this.press,
  }) : super(key: key);

  final String title;
  final IconData iconSrc;
  final Color iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        iconSrc,
        color: iconColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}

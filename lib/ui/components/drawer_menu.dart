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
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: UserProfile(onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: MyAccount(),
                ),
              );
            }),
          ),
          buildDivider(),
          // DrawerHeader(
          //   margin: EdgeInsets.zero,
          //   padding: EdgeInsets.zero,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       CircleAvatar(
          //         radius: 40.0,
          //         backgroundImage: mData.image == null
          //             ? AssetImage('assets/images/avatar.png')
          //             : NetworkImage("${ApiService.getAvatar}/${mData.image}"),
          //       ),
          //       Text(
          //         mData.fullname ?? 'KOOMPI',
          //         style: TextStyle(
          //             color: Colors.black, fontFamily: "Poppins-Bold"),
          //       ),
          //       Text(
          //         mData.phone ?? 'KOOMPI',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ],
          //   ),
          // ),
          DrawerListTile(
            title: "Home",
            iconSrc: LineIcons.home,
            press: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
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
                PageTransition(
                  type: PageTransitionType.rightToLeft,
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
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: Navbar(2),
                ),
                ModalRoute.withName('/navbar'),
              );
            },
          ),
          DrawerListTile(
            title: "More",
            iconSrc: LineIcons.bars,
            press: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
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
                Text(_lang.translate('sign_out_warn'),
                    textAlign: TextAlign.center),
                Text(
                  _lang.translate('warning'),
                  style: TextStyle(fontFamily: 'Poppins-Bold'),
                ),
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
      onTap: (press),
      horizontalTitleGap: 0.0,
      leading: Icon(
        iconSrc,
        color: iconColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class UserProfileData {
  final ImageProvider image;
  final String name;
  final String phone;

  const UserProfileData({
    @required this.image,
    @required this.name,
    @required this.phone,
  });
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                _buildImage(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildName(),
                      _buildPhone(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CircleAvatar(
      radius: 25,
      backgroundImage: mData.image == null
          ? AssetImage('assets/images/avatar.png')
          : NetworkImage("${ApiService.getAvatar}/${mData.image}"),
    );
  }

  Widget _buildName() {
    return Text(
      mData.fullname ?? 'KOOMPI',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPhone() {
    return Text(
      mData.phone ?? 'Not Set',
      style: TextStyle(
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

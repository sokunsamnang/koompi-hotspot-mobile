import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koompi_hotspot/ui/reuse_widget/reuse_widget.dart';
import 'package:koompi_hotspot/ui/screen/notification/announcements/announcements_screen.dart';
import 'package:koompi_hotspot/ui/screen/notification/transactions/transactions.dart';
import 'package:koompi_hotspot/ui/utils/app_localization.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _lang.translate('notifications'),
          style: TextStyle(color: Colors.black, fontFamily: 'Medium'),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: primaryColor,
          tabs: [
            Tab(
              child: Text(_lang.translate('transactions'),
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            Tab(
              child: Text(_lang.translate('announcements'),
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ],
          controller: _tabController,
          indicatorColor: primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          Center(child: transaction(context)),
          Center(child: AnnouncementsScreen()),
        ],
        controller: _tabController,
      ),
    );
  }
}

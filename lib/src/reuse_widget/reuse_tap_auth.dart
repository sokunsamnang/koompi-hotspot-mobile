import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class ReuseAuthTab extends StatefulWidget {
  final TabController _tabController;
  final String firstTab;
  final String secondTab;
  ReuseAuthTab(this._tabController, this.firstTab, this.secondTab);

  @override
  _ReuseAuthTabState createState() => _ReuseAuthTabState();
}

class _ReuseAuthTabState extends State<ReuseAuthTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: TabBar(
        controller: widget._tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: new BubbleTabIndicator(
          indicatorHeight: 40,
          indicatorRadius: 12,
          indicatorColor: Colors.deepPurpleAccent,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            child: Text(
              widget.firstTab,
              style: TextStyle(
                color: widget._tabController.index == 1
                    ? Colors.grey
                    : Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              widget.secondTab,
              style: TextStyle(
                color: widget._tabController.index == 0
                    ? Colors.grey
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

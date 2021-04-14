import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_advisor/HomePage.dart';
import 'package:travel_advisor/MapPage.dart';
import 'package:travel_advisor/SavePage.dart';
import 'package:travel_advisor/ScenicPages.dart';
import 'package:travel_advisor/SettingsPage.dart';
import 'package:weather/weather.dart';

class NavigatorTab extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const NavigatorTab({Key key, this.navigatorKey, this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (tabItem == "homePage") {
      child = HomePage();
    } else if (tabItem == "mapPage") {
      child = MapPage();
    } else if (tabItem == "savePage") {
      child = SavePage();
    } else if (tabItem == "scenicPage") {
      child = ScenicPages();
    } else if (tabItem == "settingsPage") {
      child = SettingsPage();
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_advisor/NavigatorTab.dart';
import 'package:travel_advisor/ScenicPages.dart';
import 'package:travel_advisor/HomePage.dart';
import 'package:travel_advisor/LoginPage.dart';
import 'package:travel_advisor/MapPage.dart';
import 'package:travel_advisor/SavePage.dart';
import 'package:travel_advisor/SettingsPage.dart';
import 'package:travel_advisor/AuthService.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:travel_advisor/StartupPage.dart';
import 'package:travel_advisor/model/MarkerInformationWindow.dart';
import 'package:vm_service/vm_service.dart';
import 'package:flutter/src/widgets/basic.dart' as Stack;
import 'package:vm_service/src/vm_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Ali: Wrapping in widget to provide custom marker functionality
  runApp(ChangeNotifierProvider(
      create: (context) => MarkerInformationWindow(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return new MaterialApp(
    //   // home: MyBottomNavigationBar(),
    // );

    // provides AuthenticationService class and user stream from said class
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          // gets access to getter from service
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // can maybe create their preferences at Sign Up:
    // * Which state should be default when looking for NPs
    // * Their username
    // * We also need to add Saved/Favorites to Profile settings/pref
    if (firebaseUser != null) {
      return MyBottomNavigationBar();
    }
    return StartupPage();
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({Key key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  String currentPage = "homePage";
  int currentIndex = 0;
  List<String> pageKeys = [
    "homePage",
    "mapPage",
    "savePage",
    "scenicPage",
    "settingsPage"
  ];

  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "HomePage": GlobalKey<NavigatorState>(),
    "mapPage": GlobalKey<NavigatorState>(),
    "savePage": GlobalKey<NavigatorState>(),
    "scenicPage": GlobalKey<NavigatorState>(),
    "settingsPage": GlobalKey<NavigatorState>(),
  };

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    MapPage(),
    SavePage(),
    ScenicPages(),
    SettingsPage()
  ];

  void onTappedBar(String tabItem, int index) {
    if (tabItem == currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        _currentIndex = index;
      });
    }
  }

  void callOnTap(String page, int index) {
    return onTappedBar(page, index);
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: NavigatorTab(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext) {
    return new WillPopScope(
        onWillPop: () async {
          final isFirstRouteunCurrentTab =
              !await _navigatorKeys[currentPage].currentState.maybePop();
          if (isFirstRouteunCurrentTab) {
            if (currentPage != "homePage") {
              onTappedBar("homePage", 0);
              return false;
            }
          }
          return isFirstRouteunCurrentTab;
        },
        child: Scaffold(
          body: Stack.Stack(children: <Widget>[
            _buildOffstageNavigator("homePage"),
            _buildOffstageNavigator("mapPage"),
            _buildOffstageNavigator("savePage"),
            _buildOffstageNavigator("scenicPage"),
            _buildOffstageNavigator("settingsPage"),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.brown,
            backgroundColor: Colors.green,
            onTap: (int index) {
              onTappedBar(pageKeys[index], index);
            },
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: new Icon(Icons.map), label: "Map"),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.save), label: "Saved"),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.camera), label: "Scenic"),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.settings), label: "Settings"),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}

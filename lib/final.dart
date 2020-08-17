import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:help_support/news/newsMain.dart';
import 'package:help_support/advice/advices.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:help_support/about/about.dart';


class Final extends StatefulWidget {
  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {

  Brightness _brightness;
  int _index = 0;
  final List<Widget> _children = [
    Dashboard(),
    NewsMain(),
    AdvicesPage(),
    About()
  ];

  void onTabTapped(int index){
    setState(() {
      _index = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'helpSupport',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
      ),

      home:Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
        tabs: [
        TabData(iconData:Icons.home ,title: 'Home'),
        TabData(iconData: Icons.speaker_notes,title: 'News'),
        TabData(iconData: Icons.book,title: 'Advice'),
        TabData(iconData: Icons.info,title: 'About'),
        ],
        onTabChangedListener: (position){onTabTapped(position);},

      ),

        body: _children[_index],
      ),
    );
  }
}

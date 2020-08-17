import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:help_support/check.dart';
import 'package:help_support/url.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Future<void> _launched;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Check()));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        logout();
        break;
      case 'Share App':
        Url.shareApp();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: Colors.deepOrange,
          accentColor: Colors.deepOrangeAccent),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.deepOrange,
              ),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Share App'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          title: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                'About Us',
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900),
              )),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage('Assets/ic_launcher.png'),
                                width: 100,
                                height: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Help Support",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Version 3.0",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Made by 💖. ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        "Help Support is a mobile application to connect essential Health services with the people and Live news around the World. The app is aimed at augmenting live news updates and health related information of current situation.",
                        style: TextStyle(color: Colors.black54, fontSize: 15.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Backend Coding and Server Handling by : \n Akshit Zatakia ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _launched = _launchURL(
                                  'https://github.com/Akshit-Zatakia/');
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Text(
                                'View Profile',
                                style: TextStyle(color: Colors.deepOrange),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "App and Logo Designed by : \n Krupali Mehta ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _launched = _launchURL(
                                  'https://github.com/Krupali-mehta');
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Text(
                                'View Profile',
                                style: TextStyle(color: Colors.deepOrange),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Under the Guidance of : \n Paras Joshi (Prof. in Computer Dept.) ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _launched = _launchURL(
                                  'https://play.google.com/store/apps/developer?id=readhere.in');
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Text(
                                'View Profile',
                                style: TextStyle(color: Colors.deepOrange),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _launched =
                                  _launchURL('http://iplextechnologies.ml/');
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.language,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Text(
                                'Visit Our Website',
                                style: TextStyle(color: Colors.deepOrange),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _launched = _launchURL('tel:9375126826');
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.deepOrange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Text(
                                '9375126826',
                                style: TextStyle(color: Colors.deepOrange),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Text(
                                '©2020 Akshit Zatakia. All Rights Reserved.',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Statistic Copyright',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        )),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total Data by :\nhttps://rapidapi.com/ShubhGupta/api/covid19-data/\n\nIndia Data by: \nhttp://www.covid19india.org/\n\nGlobal Data by: \nhttp://rapidapi.com/astsiatsko/api/coronavirus-monitor",
                        style: TextStyle(color: Colors.black54, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Advice Copyright',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        )),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WHO (World Health Organization)\nhttps://www.who.int/emergencies/diseases/novel-coronavirus-2019",
                        style: TextStyle(color: Colors.black54, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

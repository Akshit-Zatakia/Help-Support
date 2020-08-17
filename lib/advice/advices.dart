import 'dart:convert';
import 'package:flutter/material.dart';
import 'who_advice.dart';
import 'who_topic.dart';
import 'topic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:help_support/check.dart';
import 'package:help_support/url.dart';

class AdvicesPage extends StatefulWidget {
  AdvicesPage({Key key}) : super(key: key);

  @override
  _AdvicesPage createState() => _AdvicesPage();
}

class _AdvicesPage extends State<AdvicesPage> {
  Future<WHOAdvice> _adviceFuture;
  String email = "?";

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() {
    _adviceFuture = _loadJSONFile();
  }

  Future<WHOAdvice> _loadJSONFile() async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString("Assets/who_corona_advice.json");
    final json = await jsonDecode(jsonString);
    final advices = WHOAdvice.fromJson(json);
    return advices;
  }

  connectPreference() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('login'));
      String email = (prefs.getString('login')??'?');
      this.email = email[0];
    });
  }

  void logout() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Check()));
  }

  void handleClick(String value){
    switch(value){
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
    connectPreference();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert,color: Colors.deepOrange,),
            onSelected: handleClick,
            itemBuilder: (BuildContext context){
              return {'Logout','Share App'}.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        title: Padding(padding:EdgeInsets.all(10.0),child: Text('Advice',style: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900),)),
      ),
      body: FutureBuilder(
        future: _adviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('An error has occured'),
            );
          } else {
            final WHOAdvice advice = snapshot.data;
            var children = List<Widget>();

            advice.topics.forEach((element) {
              children.add(TopicCardWidget(
                topic: element,
              ));
            });

            children.add(SectionCardWidget(
              title: advice.title,
              description: advice.subtitle,
            ));

            advice.basics.forEach((element) {
              children.add(SectionCardWidget(
                title: element.title,
                description: element.subtitle,
              ));
            });

            return Center(
                child: Container(
                    constraints: BoxConstraints(maxWidth: 768),
                    child: ListView(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        children: children)));
          }
        },
      ),
    );
  }
}

class TopicCardWidget extends StatelessWidget {
  final WHOTopic topic;

  TopicCardWidget({this.topic});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 16),
        child: Card(
            child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TopicDetailWidget(
                        topic: topic,
                      )),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                title: Text(topic.title),
              ),
            ],
          ),
        )));
  }
}

class SectionCardWidget extends StatelessWidget {
  final String title;
  final String description;

  SectionCardWidget({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 16),
        child: Card(
            child: Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(title),
                subtitle: Padding(
                    padding: EdgeInsets.only(top: 8), child: Text(description)),
              ),
            ],
          ),
        )));
  }
}

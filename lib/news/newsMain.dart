import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'news.dart';
import 'package:help_support/check.dart';
import 'package:help_support/url.dart';


class NewsMain extends StatefulWidget {
  @override
  _NewsMainState createState() => _NewsMainState();
}

class _NewsMainState extends State<NewsMain> {

  String email;
  final List<Widget> _children = [
    News(url: "YOUR API URL AND KEY",),
    News(url:"YOUR API URL AND KEY"),
    News(url:"YOUR API URL AND KEY"),
    News(url:"YOUR API URL AND KEY"),
    News(url:"YOUR API URL AND KEY"),
    News(url:"YOUR API URL AND KEY"),
    News(url:"YOUR API URL AND KEY"),
  ];



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
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
          title: Padding(padding:EdgeInsets.only(top:10.0),child: Text('News',style: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900),)),
          bottom: PreferredSize(
            preferredSize: Size(80.0, 80.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.deepOrangeAccent,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: Colors.deepOrange),
                tabs: <Widget>[

                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: 
                        Padding(padding: EdgeInsets.all(10.0),child: Text('Headlines')),
                      ),
                    ),),
                  ),
                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(padding: EdgeInsets.all(10.0),child: Text('Business')),
                      ),
                    ),),
                  ),
                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: 
                        Padding(padding: EdgeInsets.all(10.0),child: Text('Entertainment')),
                      ),
                    ),),
                  ),
                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: 
                        Padding(padding: EdgeInsets.all(10.0),child: Text('Health')),
                      ),
                    ),),
                  ),
                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: 
                        Padding(padding: EdgeInsets.all(10.0),child: Text('Science')),
                      ),
                    ),),
                  ),
                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: 
                        Padding(padding:EdgeInsets.all(10.0),child: Text('Sports')),
                      ),
                    ),),
                  ),
                  Container(

                    child: Tab(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.deepOrange,width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: 
                        Padding(padding: EdgeInsets.all(10.0),child: Text('Technology')),
                      ),
                    ),),
                  ),
                ],

              ),
            ),
          ),
        ),
        body: TabBarView(children:_children),
      ),
    );
  }
}


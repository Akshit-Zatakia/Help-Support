import 'package:flutter/material.dart';
import 'home.dart';
import 'india.dart';
import 'global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'check.dart';
import 'url.dart';
import 'package:popup_menu/popup_menu.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{

  String email;
  final List<Widget> _children = [
    Home(),
    India(),
    Global(),
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
  //📲🔴

  @override
  Widget build(BuildContext context) {
    connectPreference();
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
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
                    child: Text(choice)
                  );
                }).toList();
              },
            ),

          ],
          title: Padding(padding:EdgeInsets.only(top:10.0),child: Text('Home',style: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900),)),
          bottom: PreferredSize(
            preferredSize: Size(80.0, 80.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: TabBar(

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
                          child: Padding(padding: EdgeInsets.all(5.0),child: Text('Total')),
                        ),
                      ),),
                    ),
                    Container(

                      child: Tab(child:  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.deepOrange,width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: 
                          Padding(padding: EdgeInsets.all(5.0),child: Text('India')),
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
                          Padding(padding: EdgeInsets.all(5.0),child: Text('Global')),
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


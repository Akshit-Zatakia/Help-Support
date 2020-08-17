import 'package:flutter/material.dart';
import 'check.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'final.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:help_support/news/news.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String email = "";


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /*CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image(image: AssetImage('Assets/ic_launcher.png',),color: Colors.deepOrange,),
                          radius: 70.0,
                          foregroundColor: Colors.white,
                        ),*/
                        Image(image: AssetImage('Assets/ic_launcher.png',),color: Colors.deepOrange,height: 120,width: 120,),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Help Support',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 30.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        CircularProgressIndicator(
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
  }

  connectPreference() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('login'));
      email = (prefs.getString('login')??"");
      if(email == ""){
        Timer(Duration(seconds: 5),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Check())));
      }else{
        Timer(Duration(seconds: 5),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Final())));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onLaunch: (Map<String,dynamic> msg){
        print("onLaunch called");
      },
      onResume: (Map<String,dynamic> msg){
        print("onResume called");
      },
      onMessage: (Map<String,dynamic> msg){
        print("onMessage called");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          alert: true,
          badge: true,
        )
    );
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings){
      print('IOS');
    });
    _firebaseMessaging.getToken().then((token){
      update(token);
    });
    WidgetsBinding.instance.addPostFrameCallback((_)=>connectPreference());


  }
  update(String token){
    print(token);

    setState(() {

    });
  }
}

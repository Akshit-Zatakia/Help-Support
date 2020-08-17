import 'package:flutter/material.dart';
import 'login.dart';
import 'registration.dart';

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'helpSupport',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
        buttonColor: Colors.deepOrange,
      ),
      home: UI(),
    );
  }
}

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('Assets/ic_launcher.png',),color: Colors.deepOrange,height: 100,width: 100,),
              Padding(
                padding: EdgeInsets.only(top:10.0),
              ),
              Text(
                  'Welcome to Help Support',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              RaisedButton(
                child: Text('Login',style: TextStyle(
                  color: Colors.white,
                ),),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
                },
              ),
              Padding(padding: EdgeInsets.only(top: 10.0),),
              RaisedButton(
                child: Text('Sign Up',style: TextStyle(
                  color: Colors.white
                ),),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Registration()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


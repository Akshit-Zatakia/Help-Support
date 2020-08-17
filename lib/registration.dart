import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'url.dart';
import 'login.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'helpSupport',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
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
  final phone = TextEditingController();
  final fnm = TextEditingController();
  final lnm = TextEditingController();
  final password = TextEditingController();

  bool visible = false;

  Future Registration() async {
    setState(() {
      visible = true;
    });

    var msg;
    String phoneText = phone.text;
    String passwordText = password.text;
    String fnmText = fnm.text;
    String lnmText = lnm.text;
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(phoneText);

    if(phoneText != "" && passwordText != "" && fnmText != "" && lnmText != "") {

      if (!emailValid) {
        msg = "Please enter valid email";
        setState(() {
          visible = false;
        });
      } else {
        var data = {
          'fnm': fnmText,
          'lnm': lnmText,
          'phone': phoneText,
          'password': passwordText
        };
        var response = await http.post(
            Url.URL + 'registration.php', body: data);
        msg = json.decode(response.body);


        if (response.statusCode == 200) {
          setState(() {
            visible = false;
            if (msg == '0') {
              msg = "User already exist";
            } if(msg == "1") {
              msg = "User registered successfully";
              phone.clear();
              password.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            }if(msg == "2"){
              msg = "Server error occured";
            }
          });
        }
      }
    }
    else{
      msg = "Please fill all fields";
      setState(() {
        visible = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(msg),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
            shrinkWrap: true,

        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Image(image: AssetImage('Assets/ic_launcher.png',),color: Colors.deepOrange,height: 100,width: 100,),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                labelText: 'First Name',
              ),
              controller: fnm,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                labelText: 'Last Name',
              ),
              controller: lnm,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                labelText: 'Email ID',
              ),
              controller: phone,
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                labelText: 'Password',
              ),
              obscureText: true,
              controller: password,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Colors.deepOrange,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white,fontSize: 20.0),
                ),
                onPressed: Registration,

              ),
            ),
          ),
          MaterialButton(
            onPressed: (){},
            child: Visibility(visible: visible,child: CircularProgressIndicator()),
          )
        ],
      )),
    );
  }
}

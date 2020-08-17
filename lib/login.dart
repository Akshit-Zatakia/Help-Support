import 'package:flutter/material.dart';
import 'url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'final.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'helpSupport',
      debugShowCheckedModeBanner: false,
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
  final email = TextEditingController();
  final password = TextEditingController();
  var visible = false;

  Future login() async {
    setState(() {
      visible = true;
    });

    String emailText = email.text;
    String passwordText = password.text;

    var data = {'email': emailText, 'password': passwordText};
    var response = await http.post(Url.URL + 'addData.php', body: data);
    var msg = jsonDecode(response.body);

    setLogin() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('login', emailText);
      print(prefs.getString('login'));
    }

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
        if (msg == "0") {
          msg = "Invalid email or password";
        }
        if (msg == "1") {
          msg = "Login successfull";
          setLogin();
          email.clear();
          password.clear();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Final()));
        }
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
            Image(
              image: AssetImage(
                'Assets/ic_launcher.png',
              ),
              color: Colors.deepOrange,
              height: 100,
              width: 100,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  labelText: 'Enter Email',
                ),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  labelText: 'Enter Password',
                ),
                obscureText: true,
                controller: password,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonTheme(
                height: 50.0,
                child: RaisedButton(
                  color: Colors.deepOrange,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onPressed: login,
                ),
              ),
            ),
            MaterialButton(
              child: Visibility(
                visible: visible,
                child: CircularProgressIndicator(),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

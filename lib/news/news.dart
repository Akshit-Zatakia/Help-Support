import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class News extends StatefulWidget {
  String url;

  News({this.url});

  @override
  _NewsState createState() => _NewsState(url);
}

class _NewsState extends State<News> {
  String url;


  _NewsState(this.url);

  Future<void> _launched;
  String email;

  Future<List<dynamic>> future() async {
    final response = await http.get(url);
    return json.decode(response.body)['articles'];
  }

  String _title(dynamic news) {
    return news['title'] as String;
  }

  String _desc(dynamic news) {
    return news['description'] as String;
  }

  String _url(dynamic news) {
    return news['url'] as String;
  }

  String _image(dynamic news) {
    return news['urlToImage'] as String;
  }

  String _source(dynamic news) {
    return news['source']['name'] as String;
  }

  String _date(dynamic news) {
    String day = news['publishedAt'] as String;
    String fday = day.substring(0, 10);
    DateTime dd = DateTime.parse(fday);
    String ff = DateFormat('EEE,d MMMM y').format(dd);
    return ff;
  }

  String _time(dynamic news) {
    String day = news['publishedAt'] as String;
    DateTime Day = DateTime.parse(day);
    DateTime now = DateTime.now();

    String hour = DateFormat('H').format(Day);
    String min = DateFormat('Hm').format(Day);

    String hh = DateFormat('H').format(now);
    String mm = DateFormat('Hm').format(now);

    if (hour == hh) {
      int m1 = int.parse(mm);
      int m2 = int.parse(min);
      return (m1 - m2).toString() + " minutes ago";
    } else {
      int h1 = int.parse(hh);
      int h2 = int.parse(hour);
      return (h1 - h2).toString() + " hours ago";
    }
  }

  connectPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('login'));
      String email = (prefs.getString('login') ?? null);
      this.email = email[0];
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void shareNews(String image, String title, String url) async {
    var request = await HttpClient().getUrl(Uri.parse(image));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    try {
      WcFlutterShare.share(
        sharePopupTitle: "Share App",
        subject: 'Help Support App',
        text: title +
            '\n\nLink for detail : ' +
            url +
            '\n\nShared from Help Support : https://play.google.com/store/apps/details?id=com.akshit.help_support',
        fileName: "News.png",
        bytesOfFile: bytes.buffer.asUint8List(),
        mimeType: 'text/plain',
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: future(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                String image = _image(snapshot.data[index]);
                String _image2;
                ImageProvider img() {
                  if (image == null) {
                    _image2 =
                        "YOUR IMAGE URL";
                    return AssetImage('Assets/download.png');
                  } else {
                    _image2 = image;
                    return NetworkImage(image);
                  }
                }

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 200.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                                image: img(), fit: BoxFit.fill)),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 10.0,
                                bottom: 20.0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Row(children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 17.0,
                                          color: Colors.deepOrange,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                        ),
                                        Text(
                                          _date(snapshot.data[index]),
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        )
                                      ])),
                                )),
                            Positioned(
                              right: 10.0,
                              bottom: 20.0,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () => shareNews(
                                                _image2,
                                                _title(snapshot.data[index]),
                                                _url(snapshot.data[index])),
                                            child: Row(children: <Widget>[
                                              Icon(
                                                Icons.share,
                                                size: 17.0,
                                                color: Colors.deepOrange,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(5.0),
                                              ),
                                              Text(
                                                'Share ',
                                                style: TextStyle(
                                                    color: Colors.deepOrange),
                                              )
                                            ])),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          _title(snapshot.data[index]),
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 5),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _source(snapshot.data[index]) +
                                " - " +
                                _time(snapshot.data[index]),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: MaterialButton(
                            child: Text('Open in browser >>',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.deepOrangeAccent,
                                    decoration: TextDecoration.underline)),
                            onPressed: () {
                              setState(() {
                                _launched =
                                    _launchURL(_url(snapshot.data[index]));
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

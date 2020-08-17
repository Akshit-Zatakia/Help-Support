import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'TotalResponse.dart';
import 'dart:typed_data';
import 'package:pie_chart/pie_chart.dart';
import 'url.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void shareNews(String con, String recov,String deaths,String active) async {
    try {
      WcFlutterShare.share(
        sharePopupTitle: "Share App",
        subject: 'Help Support App',
        text: 'Global Cases around the whole World :\n\nActive : '+active+'\nRecovered : '+recov+'\nDeaths : '+deaths+'\nTotal Confirmed : '+con+'\n\nKeep Distance and wear mask. Stay Healthy.\n\nShared from Help Support : https://play.google.com/store/apps/details?id=com.akshit.help_support',
        mimeType: 'text/plain',
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            FutureBuilder(
              future: Future.wait([
                getTotalStats(),
                getMaskUsageTipsImage(),

              ]),
              builder: (context, snapshot) {
                //print('http.Response:' + snapshot.data.toString());
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  TotalResponse totalResponse =
                      TotalResponse.fromJson(snapshot.data[0][0]);
                  int confirmed = totalResponse.confirmed;
                  int recovered = totalResponse.recovered;
                  int deaths = totalResponse.deaths;
                  int active = (confirmed - recovered - deaths);



                  Map<String, double> datamap = new Map();
                  /*datamap.putIfAbsent(
                      'confirmed', () => double.parse(confirmed.toString()));*/
                  datamap.putIfAbsent(
                      'recovered', () => double.parse((recovered/100).toString()));
                  datamap.putIfAbsent(
                      'deaths', () => double.parse((deaths/100).toString()));
                  datamap.putIfAbsent(
                      'active', () => double.parse((active/100).toString()));


                  List<int> list = snapshot.data[1].toString().codeUnits;
                  Uint8List bytes = Uint8List.fromList(list);

                  return Column(

                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    'Global Total Cases',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                        color: Colors.black,

                                        ),
                                  ),
                                ),
                              Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.all(10.0),
                                  child: MaterialButton(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.end,children:<Widget> [
                                      Icon(Icons.share,color: Colors.deepOrange,),
                                      Padding(padding: EdgeInsets.all(5.0),),
                                      Text('Share',style: TextStyle(color: Colors.deepOrange),)
                                    ]),
                                    onPressed: ()=>shareNews(confirmed.toString(),recovered.toString(),deaths.toString(),active.toString()),
                                  )
                              ),

                              Divider(),

                              Container(
                                child: PieChart(
                                  dataMap: datamap,
                                  animationDuration: Duration(milliseconds: 800),
                                  chartLegendSpacing: 32.0,
                                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                                  showChartValuesInPercentage: true,
                                  colorList: Url.colorList,
                                  showChartValues: true,
                                  showChartValuesOutside: false,
                                  chartValueBackgroundColor: Colors.grey[200],
                                  showLegends: true,
                                  legendPosition: LegendPosition.right,
                                  decimalPlaces: 1,
                                  showChartValueLabel: true,
                                  initialAngle: 0,
                                  chartValueStyle: defaultChartValueStyle.copyWith(
                                    color: Colors.blueGrey[900].withOpacity(0.9),
                                  ),
                                  chartType: ChartType.ring,
                                ),
                              ),

                              Padding(padding: EdgeInsets.only(top: 10.0),),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: <Widget>[
                                           Text(
                                               confirmed.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.orange)),
                                            Text(
                                                'Confirmed',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black)),
    ]
                                        )),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children:<Widget>[
                                            Text(
                                              recovered.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.blue[700])),
                                            Text(
                                                'Recovered',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black)),

                                        ])),

                                  ],
                                ),

                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0),),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children:<Widget>[ Text(
                                              deaths.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red[700])),
                                            Text(
                                                'Deaths'  ,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                        ])),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children:<Widget>[ Text(
                                              active.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green[700])),
                                            Text(
                                                'Active',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                        ])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: Image.memory(bytes),
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> getTotalStats() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-rapidapi-host': 'covid-19-data.p.rapidapi.com',
      'x-rapidapi-key': '1be69a2fefmsh87d53a6515f2d11p1b6fa1jsna3549cddf060',
    };

    http.Response response = await http.get(
        'https://covid-19-data.p.rapidapi.com/totals',
        headers: requestHeaders);

    return jsonDecode(response.body);
  }

  Future<dynamic> getMaskUsageTipsImage() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'image/jpeg',
      'x-rapidapi-host': 'coronavirus-monitor.p.rapidapi.com',
      'x-rapidapi-key': '1be69a2fefmsh87d53a6515f2d11p1b6fa1jsna3549cddf060',
    };

    http.Response response = await http.get(
        'https://coronavirus-monitor.p.rapidapi.com/coronavirus/random_masks_usage_instructions.php',
        headers: requestHeaders);

    return response.body;
  }


}

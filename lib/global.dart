import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:help_support/TotalResponse.dart';
import 'globalResponse.dart';
import 'package:pie_chart/pie_chart.dart';
import 'url.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          getGlobalStats(),
          getTotalStats()
        ]),
        builder: (context, snapshot){

          print('http.Response: '+snapshot.data.toString());
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else {

            GlobalResponse response = GlobalResponse.fromJson(jsonDecode(snapshot.data[0]));

            TotalResponse totalResponse = TotalResponse.fromJson(snapshot.data[1][0]);

            return ListView.builder(
                shrinkWrap: true,
                itemCount: response.countriesStat.length+1,
                itemBuilder: (context, index){

                  if(index==0) {

                    int confirmed = totalResponse.confirmed;
                    int recovered = totalResponse.recovered;
                    int deaths = totalResponse.deaths;
                    int active = confirmed - recovered - deaths;

//                  String confirmed = response.countriesStat[index].cases;
//                  String recovered = response.countriesStat[index].totalRecovered;
//                  String deaths = response.countriesStat[index].deaths;
//                  String active = response.countriesStat[index].activeCases;

                    String day = response.statisticTakenAt.day.toString();
                    String month = response.statisticTakenAt.month.toString();
                    String year = response.statisticTakenAt.year.toString();
                    String date = day + '-' + month + '-'+ year;
                    String hour = response.statisticTakenAt.hour.toString();
                    String min = response.statisticTakenAt.minute.toString();
                    String time = hour + ':' + min;

                    Map<String, double> datamap = new Map();
                    /*datamap.putIfAbsent(
                        'confirmed', () => double.parse(confirmed.toString()));*/
                    datamap.putIfAbsent(
                        'recovered', () => double.parse(recovered.toString()));
                    datamap.putIfAbsent(
                        'deaths', () => double.parse(deaths.toString()));
                    datamap.putIfAbsent(
                        'active', () => double.parse(active.toString()));

                    void shareNews(String con, String recov,String deaths,String active) async {
                      try {
                        WcFlutterShare.share(
                          sharePopupTitle: "Share App",
                          subject: 'Help Support App',
                          text: 'Total cases in the whole World '+' :\n\nActive : '+active+'\nRecovered : '+recov+'\nDeaths : '+deaths+'\nTotal Confirmed : '+con+'\n\nKeep Distance and wear mask. Stay Healthy.\n\nShared from Help Support : https://play.google.com/store/apps/details?id=com.akshit.help_support',
                          mimeType: 'text/plain',
                        );
                      } catch (e) {
                        print(e);
                      }
                    }

                    return Card(
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[


                            Container(alignment: Alignment.centerLeft,padding: EdgeInsets.all(5), child: Text('Updated on ' + date +' at '+time, style: TextStyle(fontSize: 14, color: Colors.black))),

                                  Container(alignment: Alignment.centerLeft, padding: EdgeInsets.all(5), child: Text('Total Cases Country Wise', style: TextStyle(fontSize: 22, color: Colors.black))),
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
                          Padding(padding: EdgeInsets.only(top: 10.0),),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: PieChart(
                              dataMap: datamap,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: 32.0,
                              chartRadius: MediaQuery.of(context).size.width / 2.7,
                              showChartValuesInPercentage: true,
                              showChartValues: true,
                              showChartValuesOutside: false,
                              chartValueBackgroundColor: Colors.grey[200],
                              showLegends: true,
                              legendPosition: LegendPosition.right,
                              colorList: Url.colorList,
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[

                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(confirmed.toString(), style: TextStyle(fontSize: 18, color: Colors.orange)),
                                          Text('Confirmed', style: TextStyle(fontSize: 14, color: Colors.orange)),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(recovered.toString(), style: TextStyle(fontSize: 18, color: Colors.blue)),
                                          Text('Recovered', style: TextStyle(fontSize: 14, color: Colors.blue)),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0),),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(deaths.toString(), style: TextStyle(fontSize: 18, color: Colors.red)),
                                          Text('Deaths', style: TextStyle(fontSize: 14, color: Colors.red)),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(active.toString(), style: TextStyle(fontSize: 18, color: Colors.lightGreen)),
                                          Text('Active', style: TextStyle(fontSize: 14, color: Colors.lightGreen)),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    String country = response.countriesStat[index-1].countryName;
                    String confirmed = response.countriesStat[index-1].cases.toString();
                    String recovered = response.countriesStat[index-1].totalRecovered.toString();
                    String deaths = response.countriesStat[index-1].deaths.toString();
                    String active = response.countriesStat[index-1].activeCases.toString();

                    void shareCountry(String con, String recov,String deaths,String active) async {
                      try {
                        WcFlutterShare.share(
                          sharePopupTitle: "Share App",
                          subject: 'Help Support App',
                          text: 'Total cases in $country '+' :\n\nActive : '+active+'\nRecovered : '+recov+'\nDeaths : '+deaths+'\nTotal Confirmed : '+con+'\n\nKeep Distance and wear mask. Stay Healthy.\n\nShared from Help Support : https://play.google.com/store/apps/details?id=com.akshit.help_support',
                          mimeType: 'text/plain',
                        );
                      } catch (e) {
                        print(e);
                      }
                    }


                    return Card(
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child:
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                  country, style: TextStyle(fontSize: 20)),
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                  onTap: ()=>shareCountry(confirmed.toString(),recovered.toString(),deaths.toString(),active.toString()),
                                                  child: Padding(
                                                      padding: EdgeInsets.all(10.0),
                                                      child: Icon(Icons.share,color: Colors.deepOrange,)
                                                  ))
                                          ),
                                        ],
                                      ),



                            Divider(),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(confirmed, style: TextStyle(fontSize: 18, color: Colors.orange)),
                                          Text('Confirmed', style: TextStyle(fontSize: 14, color: Colors.orange)),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(recovered, style: TextStyle(fontSize: 18, color: Colors.blue)),
                                          Text('Recovered', style: TextStyle(fontSize: 14, color: Colors.blue)),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0),),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(deaths, style: TextStyle(fontSize: 18, color: Colors.red)),
                                          Text('Deaths', style: TextStyle(fontSize: 14, color: Colors.red)),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:Column(
                                        children:<Widget>[
                                          Text(active, style: TextStyle(fontSize: 18, color: Colors.lightGreen)),
                                          Text('Active', style: TextStyle(fontSize: 14, color: Colors.lightGreen)),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }
                }
            );
          }
        },
      ),
    );
  }

  Future<dynamic> getGlobalStats() async {

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'HOST NANE': 'YOUR HOST NAME',
      'x-rapidapi-key': 'YOUR API KEY',
    };

    http.Response response = await http.get('YOUR API URL', headers: requestHeaders);

    return response.body;
  }

  Future<dynamic> getTotalStats() async {

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'HOST NANE': 'YOUR HOST NAME',
      'x-rapidapi-key': 'YOUR API KEY',
    };

    http.Response response = await http.get('YOUR API URL', headers: requestHeaders);

    return jsonDecode(response.body);
  }
}

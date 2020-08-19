import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'indiaResponse.dart';
import 'package:pie_chart/pie_chart.dart';
import 'url.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future: getIndiaStats(),
        builder: (context, snapshot){

          print('http.Response: '+snapshot.data.toString());

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else {

            IndiaResponse indiaResponse = IndiaResponse.fromJson(jsonDecode(snapshot.data));

            return ListView.builder(
                shrinkWrap: true,
                itemCount: indiaResponse.data.statewise.length+1,
                itemBuilder: (context, index){

                  if(index==0) {

                    String confirmed = indiaResponse.data.total.confirmed.toString();
                    String recovered = indiaResponse.data.total.recovered.toString();
                    String deaths = indiaResponse.data.total.deaths.toString();
                    String active = indiaResponse.data.total.active.toString();

                    String date_time = indiaResponse.data.lastRefreshed.toString();
                    String day = DateTime.parse(date_time).day.toString();
                    String month = DateTime.parse(date_time).month.toString();
                    String year = DateTime.parse(date_time).year.toString();
                    String date = day + '-' + month + '-'+ year;
                    String hour = DateTime.parse(date_time).hour.toString();
                    String min = DateTime.parse(date_time).minute.toString();
                    String time = hour + ':' + min;

                    Map<String, double> datamap = new Map();
                    /*datamap.putIfAbsent(
                        'confirmed', () => double.parse(confirmed));*/
                    datamap.putIfAbsent(
                        'recovered', () => double.parse(recovered));
                    datamap.putIfAbsent(
                        'deaths', () => double.parse(deaths));
                    datamap.putIfAbsent(
                        'active', () => double.parse(active));

                    void shareIndia(String con, String recov,String deaths,String active) async {
                      try {
                        WcFlutterShare.share(
                          sharePopupTitle: "Share App",
                          subject: 'Help Support App',
                          text: 'Total cases in India :\n\nActive : '+active+'\nRecovered : '+recov+'\nDeaths : '+deaths+'\nTotal Confirmed : '+con+'\n\nKeep Distance and wear mask. Stay Healthy.\n\nShared from Help Support : https://play.google.com/store/apps/details?id=com.akshit.help_support',
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

                            Padding(padding: EdgeInsets.only(top: 10.0),),
                            Container(alignment: Alignment.centerLeft,padding: EdgeInsets.all(5), child: Text('Updated on ' + date +' at '+time, style: TextStyle(fontSize: 14, color: Colors.black))),

                                  Container(alignment: Alignment.centerLeft, padding: EdgeInsets.all(5), child: Text('Total Cases In India', style: TextStyle(fontSize: 25, color: Colors.black))),
                            Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.all(10.0),
                                child: MaterialButton(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,children:<Widget> [
                                    Icon(Icons.share,color: Colors.deepOrange,),
                                    Padding(padding: EdgeInsets.all(5.0),),
                                    Text('Share',style: TextStyle(color: Colors.deepOrange),)
                                  ]),
                                  onPressed: ()=>shareIndia(confirmed.toString(),recovered.toString(),deaths.toString(),active.toString()),
                                )
                            ),
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
                            colorList: Url.colorList,
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
                  }else {

                    String state = indiaResponse.data.statewise[index-1].state;
                    String confirmed = indiaResponse.data.statewise[index-1].confirmed.toString();
                    String recovered = indiaResponse.data.statewise[index-1].recovered.toString();
                    String deaths = indiaResponse.data.statewise[index-1].deaths.toString();
                    String active = indiaResponse.data.statewise[index-1].active.toString();

                    Map<String, double> datamap2 = new Map();
                    /*datamap2.putIfAbsent(
                        'confirmed', () => double.parse(confirmed));*/
                    datamap2.putIfAbsent(
                        'recovered', () => double.parse(recovered));
                    datamap2.putIfAbsent(
                        'deaths', () => double.parse(deaths));
                    datamap2.putIfAbsent(
                        'active', () => double.parse(active));

                    void shareNews(String con, String recov,String deaths,String active) async {
                      try {
                        WcFlutterShare.share(
                          sharePopupTitle: "Share App",
                          subject: 'Help Support App',
                          text: 'Total cases in '+state+' :\n\nActive : '+active+'\nRecovered : '+recov+'\nDeaths : '+deaths+'\nTotal Confirmed : '+con+'\n\nKeep Distance and wear mask. Stay Healthy.\n\nShared from Help Support : https://play.google.com/store/apps/details?id=com.akshit.help_support',
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
                                              state, style: TextStyle(fontSize: 20)),
                                          ),
                                  ),
                                        Container(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                                onTap: ()=>shareNews(confirmed.toString(),recovered.toString(),deaths.toString(),active.toString()),
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
                              child: PieChart(
                                dataMap: datamap2,
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 32.0,
                                chartRadius: MediaQuery.of(context).size.width / 2.7,
                                showChartValuesInPercentage: true,
                                showChartValues: true,
                                showChartValuesOutside: false,
                                chartValueBackgroundColor: Colors.grey[200],
                                showLegends: true,
                                legendPosition: LegendPosition.right,
                                decimalPlaces: 1,
                                colorList: Url.colorList,
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

  Future<dynamic> getIndiaStats() async {

    http.Response response = await http.get('YOUR API');

    return response.body;
  }

}

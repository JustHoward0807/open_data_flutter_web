import 'dart:async';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_data_flutter_web/models/forecast_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Forecast Charts',
      home: MyHomeChartBody(),
    );
  }
}

class MyHomeChartBody extends StatefulWidget {
  const MyHomeChartBody({Key? key}) : super(key: key);

  @override
  State<MyHomeChartBody> createState() => _MyHomeChartBodyState();
}

class _MyHomeChartBodyState extends State<MyHomeChartBody> {
  late Future<List<Forecast>> futureForecast;
  Future<List<Forecast>> getForecast() async {
    Map<String, dynamic> mapData;
    List<Forecast> listData = [];
    final response = await http.get(Uri.parse(
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-063?Authorization=CWB-E9318A60-0D2F-41F9-8613-8B9ABB7DC9D2&limit=1&elementName=MaxT,MinT,PoP12h'));
    mapData = await json.decode(response.body);
    Forecast model = Forecast.fromJson(mapData);
    listData.add(model);
    return listData;
  }

  @override
  void initState() {
    futureForecast = getForecast();
    super.initState();
  }

  List<charts.Series<Time, String>> forecastData(List<Forecast>? data) {
    late List<Time>? pop12hList = [];
    late List<Time>? minTList = [];
    late List<Time>? maxTList = [];
    void pop12hListFactory(i) {
      pop12hList.add(Time(
          startTime: data![0]
              .records!
              .locations![0]
              .location![0]
              .weatherElement![0]
              .time![i]
              .startTime,
          elementValue: data[0]
              .records!
              .locations![0]
              .location![0]
              .weatherElement![0]
              .time![i]
              .elementValue));
    }

    void minTListFactory(i) {
      minTList.add(Time(
          
          startTime: data![0]
              .records!
              .locations![0]
              .location![0]
              .weatherElement![0]
              .time![i]
              .startTime,
          elementValue: data[0]
              .records!
              .locations![0]
              .location![0]
              .weatherElement![1]
              .time![i]
              .elementValue));
    }

    void maxTListFactory(i) {
      maxTList.add(Time(
          
          startTime: data![0]
              .records!
              .locations![0]
              .location![0]
              .weatherElement![0]
              .time![i]
              .startTime,
          elementValue: data[0]
              .records!
              .locations![0]
              .location![0]
              .weatherElement![2]
              .time![i]
              .elementValue));
    }

//?????????????????????????????????12?????????Data
    for (var i = 1;
        i <
            data![0]
                .records!
                .locations![0]
                .location![0]
                .weatherElement![0]
                .time!
                .length;
        i++) {
      pop12hListFactory(i);
      minTListFactory(i);
      maxTListFactory(i);
    }

    return [
      //PoP12h
      charts.Series<Time, String>(
          id: 'PoP12h',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Time pop12h, _) {
            final formatedTime =
                DateFormat('yyyy-MM-dd HH:mm').format(pop12h.startTime!);
            return formatedTime.toString();
          },
          measureFn: (Time pop12h, _) => pop12h.elementValue![0].value != " "
              ? int.parse('${pop12h.elementValue![0].value}') * 0.01
              : 0,
          data: pop12hList.isNotEmpty ? pop12hList : [])
        ..setAttribute(charts.rendererIdKey, 'PoP12h'),

      //MinT
      charts.Series<Time, String>(
          id: 'minT',
          colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
          domainFn: (Time minT, _) {
            final formatedTime =
                DateFormat('yyyy-MM-dd HH:mm').format(minT.startTime!);
            return formatedTime.toString();
          },
          measureFn: (Time minT, _) => minT.elementValue![0].value != " "
              ? int.parse('${minT.elementValue![0].value}')
              : 0,
          data: minTList)
        ..setAttribute(
            charts.measureAxisIdKey, charts.Axis.secondaryMeasureAxisId),

      //MaxT
      charts.Series<Time, String>(
          id: 'maxT',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (Time maxT, _) {
            final formatedTime =
                DateFormat('yyyy-MM-dd HH:mm').format(maxT.startTime!);
            return formatedTime.toString();
          },
          measureFn: (Time maxT, _) =>
              int.parse('${maxT.elementValue![0].value}'),
          data: maxTList)
        ..setAttribute(
            charts.measureAxisIdKey, charts.Axis.secondaryMeasureAxisId)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth < 1500) {
        return Scaffold(
            body: FutureBuilder<List<Forecast>>(
                future: futureForecast,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.2,
                            child: charts.OrdinalComboChart(
                              forecastData(snapshot.data),
                              defaultRenderer:
                                  charts.LineRendererConfig(strokeWidthPx: 6),
                              customSeriesRenderers: [
                                charts.BarRendererConfig(
                                    customRendererId: 'PoP12h'),
                              ],
                              animate: true,
                              behaviors: [
                                charts.SeriesLegend(
                                    position: charts.BehaviorPosition.bottom),
                                charts.SlidingViewport(),
                                charts.PanAndZoomBehavior(),
                              ],
                              primaryMeasureAxis: charts.PercentAxisSpec(),
                              domainAxis: const charts.OrdinalAxisSpec(
                                renderSpec: charts.SmallTickRendererSpec(
                                    labelRotation: 60),
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'API URL: https://opendata.cwb.gov.tw/dataset/forecast/F-D0047-063')
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }));
      } else {
        // Rotate the text so they won't overlay each other 
        return Scaffold(
            body: FutureBuilder<List<Forecast>>(
                future: futureForecast,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.2,
                            child: charts.OrdinalComboChart(
                              forecastData(snapshot.data),
                              defaultRenderer:
                                  charts.LineRendererConfig(strokeWidthPx: 6),
                              customSeriesRenderers: [
                                charts.BarRendererConfig(
                                    customRendererId: 'PoP12h'),
                              ],
                              animate: true,
                              behaviors: [
                                charts.SeriesLegend(
                                    position: charts.BehaviorPosition.bottom),
                                charts.SlidingViewport(),
                                charts.PanAndZoomBehavior(),
                              ],
                              primaryMeasureAxis: charts.PercentAxisSpec(),
                              // domainAxis: charts.OrdinalAxisSpec(
                              //   renderSpec: charts.SmallTickRendererSpec(
                              //       labelRotation: 60),
                              // ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'API URL: https://opendata.cwb.gov.tw/dataset/forecast/F-D0047-063')
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }));
      }
    });
  }
}

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:strongr/models/Bodyweight.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<charts.Series<Bodyweight, DateTime>> _seriesData;
  TextEditingController searchbarController;

  @override
  void initState() {
    super.initState();

    searchbarController = TextEditingController(text: "");
    _seriesData = List<charts.Series<Bodyweight, DateTime>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: StrongrText(
            "Masse corporelle",
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            height: 200,
            child: StrongrRoundedContainer(
              onPressed: null,
              content: buildBodyweightChart(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: StrongrText(
            "Performances par exercice",
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  // color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                          left: 8,
                          right: 8,
                          bottom: 4,
                        ),
                        child: StrongrText(
                          "Exercice",
                          color: StrongrColors.black80,
                          size: 18,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: StrongrRoundedContainer(
                          content: StrongrText(
                            "Aucun exercice",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            size: 18,
                            color: Colors.grey,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                          left: 8,
                          right: 8,
                          bottom: 4,
                        ),
                        child: StrongrText(
                          "Période",
                          color: StrongrColors.black80,
                          size: 18,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: StrongrRoundedContainer(
                          content: StrongrText(
                            "Aucune période",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            size: 18,
                            color: Colors.grey,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            height: 200,
            child: StrongrRoundedContainer(
              onPressed: null,
              content: StrongrText(
                "Disponible dans une prochaine mise à jour",
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBodyweightChart() {
    return charts.TimeSeriesChart(
      _seriesData,
      animate: true,
      animationDuration: Duration(milliseconds: 300),
      behaviors: [
        charts.ChartTitle(
          'Temps (jours)',
          titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
        ),
        charts.ChartTitle(
          'Masse (kg)',
          titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
        ),
      ],
      defaultRenderer: charts.LineRendererConfig(),
      customSeriesRenderers: [
        charts.PointRendererConfig(
          customRendererId: 'customPoint',
        )
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      // Axe horizontal
      domainAxis: charts.DateTimeAxisSpec(
        showAxisLine: true,
        tickProviderSpec:
            charts.AutoDateTimeTickProviderSpec(includeTime: false),
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 45,
          labelStyle: charts.TextStyleSpec(color: charts.Color.black),
          lineStyle: charts.LineStyleSpec(color: charts.Color.black),
        ),
      ),
      // Axe vertical
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelJustification: charts.TickLabelJustification.outside,
        ),
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredMinTickCount: 6,
          desiredMaxTickCount: 6,
          // dataIsInWholeNumbers: true,
          // desiredTickCount: 10
        ),
      ),
    );
  }

  _generateData() {
    var data1 = [
      Bodyweight(value: 54.0, date: DateTime.now().add(Duration(days: -6))),
      Bodyweight(value: 49.2, date: DateTime.now().add(Duration(days: -5))),
      Bodyweight(value: 52.5, date: DateTime.now().add(Duration(days: -4))),
      Bodyweight(value: 50.0, date: DateTime.now().add(Duration(days: -3))),
      Bodyweight(value: 55.0, date: DateTime.now().add(Duration(days: -2))),
      Bodyweight(value: 60.5, date: DateTime.now().add(Duration(days: -1))),
      Bodyweight(value: 70.0, date: DateTime.now()),
    ];

    _seriesData.addAll([
      charts.Series(
        id: "Bodyweight",
        data: data1,
        domainFn: (Bodyweight bodyweight, _) =>
            // DateFormater.format(bodyweight.date.toString()),
            bodyweight.date,
        measureFn: (Bodyweight bodyweight, _) => bodyweight.value,
        colorFn: (Bodyweight bodyweight, _) =>
            charts.ColorUtil.fromDartColor(StrongrColors.blue),
      ),
      charts.Series<Bodyweight, DateTime>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.black.lighter,
          domainFn: (Bodyweight bodyweight, _) => bodyweight.date,
          measureFn: (Bodyweight bodyweight, _) => bodyweight.value,
          data: data1)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ]);
  }
}

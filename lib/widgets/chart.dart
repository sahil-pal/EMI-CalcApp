
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';


class Piechart extends StatelessWidget {

  late Map<String,double> dataMap;
  Piechart(Map<String,double> this.dataMap);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      chartRadius: (MediaQuery.of(context).size.width / 2) - 150 / 3.2,
      dataMap: dataMap,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../constants/constants.dart';
import '../constants/responsive_widget.dart';
class PieChartSection extends StatelessWidget {
  final recovered;
  final cases;
  PieChartSection({
    super.key,
    required this.recovered,
    required this.cases
  });

  @override
  Widget build(BuildContext context) {
    double percent = (double.parse(recovered)/double.parse(cases)) * 100;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      height: ResponsiveWidget.isSmallScreen(context) ? height * 0.275 : width * 0.275,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: Colors.black.withOpacity(0.08))
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rate of Recovery',
            style: poppinsFont.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          PieChart(
            dataMap: {
              'Affected': double.parse(cases),
              'Recovered': double.parse(recovered)
            },
            chartType: ChartType.ring,
            chartValuesOptions: ChartValuesOptions(showChartValues: false),
            chartRadius: height * 0.123,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.right,
            ),
            chartLegendSpacing: 20,
            ringStrokeWidth: 10,
            colorList: [
              orangeColor,
              blueColor
            ],
          )
        ],
      ),
    );
  }
}

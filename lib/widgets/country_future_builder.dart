import 'package:covid19_app/Model/CountryStatesModel.dart';
import 'package:covid19_app/widgets/data_card.dart';
import 'package:covid19_app/widgets/pie_chart_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../Services/states_services.dart';
import '../constants/constants.dart';
import '../constants/responsive_widget.dart';

class CountryFutureBuilder extends StatelessWidget {
  final bool isTodaySelected;
  final int selectedCountryIndex;
  CountryFutureBuilder({
    super.key,
    required this.isTodaySelected,
    required this.selectedCountryIndex
  });

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: statesServices.fetchCountryRecord(),
      builder: (context, AsyncSnapshot<List<CountryStatesModel>> snapshot) {
        if(!snapshot.hasData){
          return Column(
            children: [
              SizedBox(height: height * 0.25,),
              Center(
                child: SpinKitFadingCircle(
                  color:orangeColor,
                  size: 50.0,
                ),
              ),
            ],
          );
        }else{
          String cases = '',deaths = '',recovered = '',active = '',critical = '';
          if(isTodaySelected){
            cases = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].todayCases);
            deaths = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].todayDeaths);
            recovered = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].todayRecovered);
            active = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].active);
            critical = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].critical);
          }else{
            cases = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].cases);
            deaths = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].deaths);
            recovered = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].recovered);
            active = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].active);
            critical = NumberFormat.decimalPattern().format(snapshot.data![selectedCountryIndex].critical);
          }
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05555556),
                  child: Row(
                    children: [
                      DataCard(
                        title: 'Cases',
                        value: cases,
                        color: blueColor,
                        cardHeight: ResponsiveWidget.isSmallScreen(context) ? height * 0.15 : height * 0.2,
                        cardWidth: width * 0.4166666,
                      ),
                      SizedBox(
                        width: width * 0.05555556,
                      ),
                      DataCard(
                        title: 'Deaths',
                        value: deaths,
                        color: orangeColor,
                        cardWidth: width * 0.4166666,
                        cardHeight: ResponsiveWidget.isSmallScreen(context) ? height * 0.15 : height * 0.2,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05555556),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DataCard(
                          title: 'Recovered',
                          titleSize: 10,
                          textColor: blueColor,
                          value: recovered,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context) ? height * 0.125 : height * 0.1855,
                        ),
                      ),
                      SizedBox(width: width * 0.02375,),
                      Expanded(
                        child: DataCard(
                          title: 'Active',
                          titleSize: 10,
                          textColor: blueColor,
                          value: active,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context) ? height * 0.125 : height * 0.1855,
                        ),
                      ),
                      SizedBox(width: width * 0.02375,),
                      Expanded(
                        child: DataCard(
                          title: 'Critical',
                          titleSize: 10,
                          textColor: orangeColor,
                          value: critical,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context) ? height * 0.125 : height * 0.1855,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05555556),
                  child: PieChartSection(
                    cases: snapshot.data![selectedCountryIndex].cases.toString(),
                    recovered: snapshot.data![selectedCountryIndex].recovered.toString(),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

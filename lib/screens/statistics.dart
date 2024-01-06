import 'package:covid19_app/Model/CountryStatesModel.dart';
import 'package:covid19_app/Model/WorldStatesModel.dart';
import 'package:covid19_app/Services/states_services.dart';
import 'package:covid19_app/constants/responsive_widget.dart';
import 'package:covid19_app/widgets/country_future_builder.dart';
import 'package:covid19_app/widgets/custom_button.dart';
import 'package:covid19_app/widgets/data_card.dart';
import 'package:covid19_app/widgets/world_future_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/constants.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with TickerProviderStateMixin {
  static bool isGlobalSelect = true; // global or country
  static bool isCountrySelected = false; // any name of country selected or not
  static bool isTodaySelected = false; // today or total
  static int selectedCountryIndex = 0;
  StatesServices statesServices = StatesServices();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05555556),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.04375,
                  ),
                  Center(
                    child: Text(
                      'Statistics',
                      style: poppinsFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.0125,
                  ),
                  Text(
                    'Explore COVID-19 regular updates on this tab',
                    textAlign: TextAlign.center,
                    style: poppinsFont.copyWith(
                      fontSize: 10,
                      color: greyColor,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  stateSelection(),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  timeSelection(height),
                  SizedBox(
                    height: height * 0.025,
                  ),
                ],
              ),
            ),
            isGlobalSelect
                ? buildFutureBuilder(height, width)
                : SizedBox(
                    height: height * 0.72,
                    child: Column(
                      children: [
                        isCountrySelected
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05555556),
                                child: CustomButton(
                                  text: 'Explore another country',
                                  textColor: blueColor,
                                  tap: () {
                                    setState(() {
                                      isCountrySelected = false;
                                      searchController.text = '';
                                    });
                                  },
                                  buttonHeight: 50,
                                ),
                              )
                            : searchField(width),
                        isCountrySelected
                            ? Expanded(
                                child: countryFutureBuilder(height, width))
                            : Expanded(
                                child: FutureBuilder(
                                  future: statesServices.fetchCountryRecord(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.07),
                                        child: ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return Shimmer.fromColors(
                                                baseColor: blueColor.withOpacity(0.2),
                                                highlightColor:
                                                    orangeColor.withOpacity(0.2),
                                                child: ListTile(
                                                  leading: Container(
                                                    height: 35,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  title: Container(
                                                    height: 10,
                                                    width: 89,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  subtitle: Container(
                                                    height: 10,
                                                    width: 89,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                ));
                                          },
                                        ),
                                      );
                                    } else {
                                      return countryFlagBuilder(
                                          width, snapshot);
                                    }
                                  },
                                ),
                              )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------------
  Padding countryFlagBuilder(double width, AsyncSnapshot<List<CountryStatesModel>> snapshot) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final imageUrl = snapshot.data![index].countryInfo!.flag.toString();
          final country = snapshot.data![index].country.toString();
          final cases = snapshot.data![index].cases.toString();
          if (searchController.text.isEmpty) {
            return InkWell(
              onTap: () {
                isCountrySelected = true;
                selectedCountryIndex = index;
                setState(() {});
              },
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Container(height: 35, width: 50,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl)),borderRadius: BorderRadius.circular(10)),),
                title: Text(country,style: poppinsFont.copyWith(fontSize: 13,color: blueColor,fontWeight: FontWeight.bold),),
                subtitle: Text(cases,style: poppinsFont.copyWith(fontSize: 12,color: greyColor)),
              ),
            );
          } else if (country
              .toLowerCase()
              .contains(searchController.text.toLowerCase().toString())) {
            return InkWell(
              onTap: () {
                isCountrySelected =
                    true; // country selected and show explore button
                selectedCountryIndex = index;
                isTodaySelected = false; // set to Total
                setState(() {});
              },
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Container(height: 35, width: 50,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl)),borderRadius: BorderRadius.circular(10)),),
                title: Text(country,style: poppinsFont.copyWith(fontSize: 13,color: blueColor),),
                subtitle: Text(cases,style: poppinsFont.copyWith(fontSize: 12,color: greyColor)),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  //----------------------------------------------------------------------------------
  buildFutureBuilder(double height, double width) {
    return FutureBuilder(
      future: statesServices.fetchWorldStatesRecord(),
      builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.25,
              ),
              Center(
                child: SpinKitFadingCircle(
                  color: orangeColor,
                  size: 50.0,
                ),
              ),
            ],
          );
        } else {
          String cases = '',
              deaths = '',
              recovered = '',
              active = '',
              critical = '';
          if (isTodaySelected) {
            cases =
                NumberFormat.decimalPattern().format(snapshot.data!.todayCases);
            deaths = NumberFormat.decimalPattern()
                .format(snapshot.data!.todayDeaths);
            recovered = NumberFormat.decimalPattern()
                .format(snapshot.data!.todayRecovered);
            active =
                NumberFormat.decimalPattern().format(snapshot.data!.active);
            critical =
                NumberFormat.decimalPattern().format(snapshot.data!.critical);
          } else {
            cases = NumberFormat.decimalPattern().format(snapshot.data!.cases);
            deaths =
                NumberFormat.decimalPattern().format(snapshot.data!.deaths);
            recovered =
                NumberFormat.decimalPattern().format(snapshot.data!.recovered);
            active =
                NumberFormat.decimalPattern().format(snapshot.data!.active);
            critical =
                NumberFormat.decimalPattern().format(snapshot.data!.critical);
          }
          return SingleChildScrollView(
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
                        cardHeight: ResponsiveWidget.isSmallScreen(context)
                            ? height * 0.15
                            : height * 0.2,
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
                        cardHeight: ResponsiveWidget.isSmallScreen(context)
                            ? height * 0.15
                            : height * 0.2,
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
                          cardHeight: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.125
                              : height * 0.1855,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02375,
                      ),
                      Expanded(
                        child: DataCard(
                          title: 'Active',
                          titleSize: 10,
                          textColor: blueColor,
                          value: active,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.125
                              : height * 0.1855,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02375,
                      ),
                      Expanded(
                        child: DataCard(
                          title: 'Critical',
                          titleSize: 10,
                          textColor: orangeColor,
                          value: critical,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.125
                              : height * 0.1855,
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
                  child: pieChartSection(snapshot.data!.cases.toString(),
                      snapshot.data!.recovered.toString()),
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

  //----------------------------------------------------------------------------------
  Widget stateSelection() {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: blueColor, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isGlobalSelect = true;
                    isCountrySelected = false;
                  });
                },
                child: Ink(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: isGlobalSelect ? blueColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Global',
                      textAlign: TextAlign.center,
                      style: poppinsFont.copyWith(
                          fontSize: 16,
                          color: isGlobalSelect ? Colors.white : blueColor),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isGlobalSelect = false;
                  });
                },
                child: Ink(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: isGlobalSelect ? Colors.transparent : blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Country',
                      textAlign: TextAlign.center,
                      style: poppinsFont.copyWith(
                          fontSize: 16,
                          color: isGlobalSelect ? blueColor : Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  //----------------------------------------------------------------------------------
  Row timeSelection(double height) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Total',
            textColor: (isTodaySelected) ? greyColor : Colors.white,
            fontSize: 10,
            tap: () {
              setState(() {
                isTodaySelected = false;
              });
            },
            buttonHeight: 30,
            backgroundColor: (isTodaySelected) ? Colors.white : orangeColor,
          ),
        ),
        SizedBox(
          width: height * 0.0125,
        ),
        Expanded(
          child: CustomButton(
            text: 'Today',
            textColor: (isTodaySelected) ? Colors.white : greyColor,
            fontSize: 10,
            tap: () {
              setState(() {
                isTodaySelected = true;
              });
            },
            buttonHeight: 30,
            backgroundColor: (isTodaySelected) ? orangeColor : Colors.white,
          ),
        ),
      ],
    );
  }

  //----------------------------------------------------------------------------------
  Container pieChartSection(String cases, String recovered) {
    double percent = (double.parse(recovered) / double.parse(cases)) * 100;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 170,
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
          ]),
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
            chartRadius: 70,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.right,
            ),
            chartLegendSpacing: 20,
            ringStrokeWidth: 10,
            colorList: [orangeColor, blueColor],
          )
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------------
  Container searchField(double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05555556),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: Colors.black.withOpacity(0.08))
          ]),
      child: TextFormField(
        style: poppinsFont.copyWith(fontSize: 15, color: greyColor),
        onChanged: (value) => setState(() {}),
        cursorColor: greyColor,
        cursorHeight: 22,
        controller: searchController,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: width * 0.05555556),
            suffixIcon: Icon(
              Icons.search,
              color: greyColor,
              size: 22,
            ),
            border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(minWidth: 50, maxHeight: 20),
            hintText: 'Search...',
            hintStyle: poppinsFont.copyWith(
                fontSize: 15, color: greyColor.withOpacity(0.7))),
      ),
    );
  }

  //----------------------------------------------------------------------------------
  countryFutureBuilder(double height, double width) {
    return FutureBuilder(
      future: statesServices.fetchCountryRecord(),
      builder: (context, AsyncSnapshot<List<CountryStatesModel>> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.25,
              ),
              Center(
                child: SpinKitFadingCircle(
                  color: orangeColor,
                  size: 50.0,
                ),
              ),
            ],
          );
        } else {
          String cases = '',
              deaths = '',
              recovered = '',
              active = '',
              critical = '';
          if (isTodaySelected) {
            cases = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].todayCases);
            deaths = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].todayDeaths);
            recovered = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].todayRecovered);
            active = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].active);
            critical = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].critical);
          } else {
            cases = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].cases);
            deaths = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].deaths);
            recovered = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].recovered);
            active = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].active);
            critical = NumberFormat.decimalPattern()
                .format(snapshot.data![selectedCountryIndex].critical);
          }
          return SingleChildScrollView(
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
                        cardHeight: ResponsiveWidget.isSmallScreen(context)
                            ? height * 0.15
                            : height * 0.2,
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
                        cardHeight: ResponsiveWidget.isSmallScreen(context)
                            ? height * 0.15
                            : height * 0.2,
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
                          cardHeight: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.125
                              : height * 0.1855,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02375,
                      ),
                      Expanded(
                        child: DataCard(
                          title: 'Active',
                          titleSize: 10,
                          textColor: blueColor,
                          value: active,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.125
                              : height * 0.1855,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02375,
                      ),
                      Expanded(
                        child: DataCard(
                          title: 'Critical',
                          titleSize: 10,
                          textColor: orangeColor,
                          value: critical,
                          valueSize: 14,
                          cardWidth: width * 0.26111111,
                          cardHeight: ResponsiveWidget.isSmallScreen(context)
                              ? height * 0.125
                              : height * 0.1855,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width * 0.05555556),
                    child: pieChartSection(
                        snapshot.data![selectedCountryIndex].cases.toString(),
                        snapshot.data![selectedCountryIndex].recovered
                            .toString())),
              ],
            ),
          );
        }
      },
    );
  }
}

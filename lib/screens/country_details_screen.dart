import 'package:covid19_app/screens/world_states_screen.dart';
import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatefulWidget {
  String image, name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  CountryDetailsScreen({
    required this.todayRecovered,
    required this.critical,
    required this.active,
    required this.name,
    required this.image,
    required this.test,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
});

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      ReuseableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                      ReuseableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                      ReuseableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                      ReuseableRow(title: 'Active', value: widget.active.toString()),
                      ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ReuseableRow(title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}

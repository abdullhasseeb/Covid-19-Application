import 'package:covid19_app/Model/WorldStatesModel.dart';
import 'package:covid19_app/Services/states_services.dart';
import 'package:covid19_app/screens/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2)
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  List<Color> colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
            future: statesServices.fetchWorldStatesRecord(),
            builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    controller: animationController,
                    size: 50.0,
                  ),
                );
              }else{
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * .01,),
                      PieChart(
                        dataMap: {
                          'Total' : snapshot.data!.cases!.toDouble(),
                          'Recovered' : snapshot.data!.recovered!.toDouble(),
                          'Deaths' : snapshot.data!.deaths!.toDouble()
                        },
                        colorList: colorList,
                        animationDuration: Duration(seconds: 2),
                        chartType: ChartType.ring,
                        chartRadius: width /3.2 ,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.06),
                        child: Card(
                          child: Column(
                            children: [
                              ReuseableRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                              ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths!.toString()),
                              ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                              ReuseableRow(title: 'Active', value: snapshot.data!.active!.toString()),
                              ReuseableRow(title: 'Critical', value: snapshot.data!.critical!.toString()),
                              ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths!.toString()),
                              ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered!.toString()),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList(),));
                          },
                          child: Ink(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('Track Countreis',style: TextStyle(color: Colors.white),)),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({
    required this.title,
    required this.value,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return
       Padding(
         padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
         child: Column(
           children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value)
              ],
             ),
             SizedBox(height: 5,),
             Divider()
           ],
         ),
       );
  }
}


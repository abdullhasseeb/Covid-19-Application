import 'package:covid19_app/Services/states_services.dart';
import 'package:covid19_app/screens/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))
                ),
              ),
              Expanded(
                child: FutureBuilder(
                future: statesServices.fetchCountryRecord(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if(!snapshot.hasData){
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: ListTile(
                                  leading: Container(height: 50, width: 50,color: Colors.white,),
                                  title: Container(height: 10, width: 89,color: Colors.white,),
                                  subtitle: Container(color: Colors.white,height: 10, width: 89,),
                                )
                            );
                          },
                        );
                      }else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final imageUrl = snapshot.data![index]['countryInfo']['flag'].toString();
                              final country = snapshot.data![index]['country'].toString();
                              final cases = snapshot.data![index]['cases'].toString();
                              if(searchController.text.isEmpty){
                                return InkWell(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetailsScreen(
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                      active: snapshot.data![index]['active'],
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag']  ,
                                      test: snapshot.data![index]['tests'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths: snapshot.data![index]['todayDeaths'],
                                      totalRecovered: snapshot.data![index]['recovered']
                                  )
                                    ,)),
                                  child: ListTile(
                                    leading: Image.network(height: 50,width: 50,imageUrl),
                                    title: Text(country),
                                    subtitle: Text(cases),
                                  ),
                                );
                              }else if(country.toLowerCase().contains(searchController.text.toLowerCase().toString())){
                                return InkWell(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetailsScreen(
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                      active: snapshot.data![index]['active'],
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag']  ,
                                      test: snapshot.data![index]['tests'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths: snapshot.data![index]['todayDeaths'],
                                      totalRecovered: snapshot.data![index]['recovered']
                                  )
                                    ,)
                                  ),
                                  child: ListTile(
                                    leading: Image.network(height: 50,width: 50,imageUrl),
                                    title: Text(country),
                                    subtitle: Text(cases),
                                  ),
                                );
                              }else{
                                return Container();
                              }

                            },
                        );
                      }
                    },
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}

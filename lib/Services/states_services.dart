import 'dart:convert';

import 'package:covid19_app/Model/CountryStatesModel.dart';
import 'package:covid19_app/Model/WorldStatesModel.dart';
import 'package:covid19_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart';

class StatesServices{

  Future<WorldStatesModel> fetchWorldStatesRecord() async{
    Uri uri = Uri.parse(AppUrls.worldStatesApi);
    Response response = await get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);

      return WorldStatesModel.fromJson(json);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<CountryStatesModel>> fetchCountryRecord() async{
    List<CountryStatesModel> list = [];
    Uri uri = Uri.parse(AppUrls.countriesApi);
    Response response = await get(uri);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      for(Map i in data){
        list.add(CountryStatesModel.fromJson(i));
      }
      return list;
    }else{
      throw Exception('Error');
    }
  }
}
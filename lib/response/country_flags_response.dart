import 'dart:convert';
import 'package:http/http.dart';

class CountryFlags{
  late List<dynamic> data;

  Future<void> getCountryFlags() async{
    var url = Uri.parse("https://restcountries.com/v3.1/all?fields=name,flags");
    Response response = await get(url);
    data = json.decode(response.body);
  }
}
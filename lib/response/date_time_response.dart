import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class DateTimeResponse{
    String time = "";
    String  countryName;

    DateTimeResponse({
    required this.countryName,
  });

    Future<void> getDateTime() async{
        var url = Uri.parse("https://restcountries.com/v2/name/$countryName?fullText=true");
        Response response = await get(url);
        List<dynamic> data = json.decode(response.body);
        String timezone = data[0]['timezones'][0].substring(4, 9);

        Duration offset =
        Duration(
          hours: int.parse(timezone.substring(0, 2)),
          minutes: int.parse(timezone.substring(3))
        );

        DateTime timeWithOffset = DateTime.now().toUtc().add(offset);

        time = DateFormat('HH:mm:ss').format(timeWithOffset);
    }
}
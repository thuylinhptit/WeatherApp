import 'package:http/http.dart' as http ;
import 'city.dart';
import 'json.dart';

class Handle {
  static const String url = 'https://www.metaweather.com/api/location';

  static Future<City> searchByCity (String city) async {
    final response = await http.get(url + "/search/?query=" + city);
    return cityFromJson(response.body).first;
  }

  static Future <ConsolidatedWeather> getDataById (int locationId) async {
    final response = await http.get(url + "/" + locationId.toString());
    return todoFromJson(response.bodyBytes).consolidatedWeather.first;
  }
}
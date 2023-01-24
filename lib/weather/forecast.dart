import 'dart:convert';

import 'package:http/http.dart' as http;

class Hourly {
  late double temp;
  late String desciption;

  Hourly({required this.temp, required this.desciption});

  // factory Hourly.fromJson(Map<String, dynamic> json) {
  //   return Hourly(
  //       temp: json['hourly'][0]['temp'],
  //       desciption: json['hourly'][0]['weather'][0]['description']);
  // }

  double getTemp() {
    return temp;
  }
}

class Daily {
  late double temp;
  late String description;

  Daily({required this.temp, required this.description});

// factory Daily.fromJson(Map<String, dynamic> json) {
//   return Daily(
//       temp: json['daily'][0]['temp'],
//       description: json['daily'][0]['weather'][0]['description']);
// }
}

Future getHourlyForecast(double lon, lat) async {
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?&lon=$lon&lat=$lat&appid=f54be8866d65f0cc3b9473f77b310168&units=metric'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return print(response.statusCode);
  }
}

Future getDailyForecast(double lon, lat) async {
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?&lon=$lon&lat=$lat&appid=f54be8866d65f0cc3b9473f77b310168&units=metric'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return print(response.statusCode);
  }
}

Future getLocation(String city) async {
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=f54be8866d65f0cc3b9473f77b310168'));

  Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
  Map<String, dynamic> location = {
    'lon': null,
    'lat': null,
  };

  location['lon'] = data['coord']['lon'];
  location['lat'] = data['coord']['lat'];

  return location;
}

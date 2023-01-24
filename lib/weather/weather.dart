class Weather {
  late double temp;
  late double feelslike;
  late double low;
  late double high;
  late String description;
  late String city;
  late String country;

  Weather({
    required this.temp,
    required this.feelslike,
    required this.low,
    required this.high,
    required this.description,
    required this.city,
    required this.country,
  });

  datafromWeather() {
    return "temp = ${temp}";
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temp: json['main']['temp'].toDouble(),
        feelslike: json['main']['feels_like'].toDouble(),
        low: json['main']['temp_min'].toDouble(),
        high: json['main']['temp_max'].toDouble(),
        description: json['weather'][0]['description'],
        city: json['name'],
        country: json['sys']['country']);
  }
}

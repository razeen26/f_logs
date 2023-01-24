import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logging_task_flog/flogs.dart';
import '../current_weather_page.dart';

Future getCurrentData(String city) async {
  final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=f54be8866d65f0cc3b9473f77b310168"));

  Map<String, dynamic> data = {};

  data = jsonDecode(response.body);
  return data;
}

Widget locationBox(String city) {
  return FutureBuilder(
    future: getCurrentData(city),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot == null) {
        return errorIcon();
      } else {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: LoadingAnimationWidget.prograssiveDots(
                color: const Color(0xFF14213D),
                size: 20,
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: InkWell(
              onTap: () async {
                FlogFunctions.logInfo('$city IS SELECTED FOR WEATHER DESCRIPTION');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => CurrentWeatherPage(cityName: city))));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 7, 0),
                child: SizedBox(
                  height: 150,
                  width: 50,
                  child: Card(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    // color: const Color.fromARGB(255, 240, 241, 242),
                    borderOnForeground: true,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(city,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                )),
                            Text(snapshot.data['weather'][0]['description'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                )),
                            const SizedBox(
                              height: 1,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${snapshot.data['main']['temp'].round()}º ',
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Min.${snapshot.data['main']['temp_min'].round()}º -  Max.${snapshot.data['main']['temp_max'].round()}º',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                )),
                            const SizedBox(
                              height: 1,
                            )
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    },
  );
}

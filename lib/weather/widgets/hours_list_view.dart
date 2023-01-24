import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logging_task_flog/weather/forecast.dart';
import 'package:logging_task_flog/weather/material/get_assets.dart';

Widget hourlyListView(double lon, lat) {
  return FutureBuilder(
      future: getHourlyForecast(lon, lat),
      builder: (context, snapshot) {
        double screenWidth = MediaQuery.of(context).size.width;

        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.black,
              size: 20,
            ),
          );
        } else {
          Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          List hours = data["hourly"];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
                // color: Color.fromARGB(255, 244, 244, 245),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: hours.length - 24,
                      itemBuilder: (context, int index) {
                        String asset = getAsset(hours[index]['weather'][0]['description'].toString());
                        return Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          FittedBox(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hoursList[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  FittedBox(
                                    child: SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(
                                          'assets/$asset',
                                        )),
                                  ),
                                  Text(
                                    '${hours[index]['temp'].round()}º ',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(),
                        ]);
                      }),
                )),
          );
        }
      });
}

List<String> hoursList = [
  'Now',
  '+1h',
  '+2h',
  '+3h',
  '+4h',
  '+5h',
  '+6h',
  '+7h',
  '+8h',
  '+9h',
  '+10h',
  '+11h',
  '+12h',
  '+13h',
  '+14h',
  '+15h',
  '+16h',
  '+17h',
  '+18h',
  '+19h',
  '+20h',
  '+21h',
  '+22h',
  '+23h',
];

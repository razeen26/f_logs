//The screen where the user can search for a location among the locations list

//TO DO : Fix the search bar filter

// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging_task_flog/flogs.dart';
import '../main.dart';
import 'widgets/location_box.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

List<String> cities = [
  'London',
  'Paris',
  'Algiers',
  'Berlin',
  'Jakarta',
  'Oslo',
  'Washington',
  'Mexico',
  'Roma',
  'Lisbonne',
  'Tokyo',
  'Seoul',
  'Pekin',
  'Montreal',
];

List<String> allcities = cities;

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlogFunctions.logInfo('ENTERED WEATHER APP');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FlogFunctions.logInfo('POPPED OUT FROM WEATHER APP');
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_sharp,
          ),
        ),
        title: Text("WEATHER APP"),
        centerTitle: true,
      ),
      body: Container(
        // color: const Color(0xFFE5E5E5),
        child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              return locationBox(cities[index]);
            }),
      ),
    );
  }

  void searchCity(String query) async {
    final suggestions = allcities.where((city) {
      final cityName = city.toLowerCase();
      final input = query.toLowerCase();
      print(input);
      return cityName.contains(input);
    }).toList();
    setState(() {
      cities = suggestions;
    });
  }
}

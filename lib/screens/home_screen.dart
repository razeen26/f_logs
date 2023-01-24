// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, depend_on_referenced_packages, avoid_print, unnecessary_brace_in_string_interps, unused_import, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:logging_task_flog/flogs.dart';
import 'package:logging_task_flog/screens/log_display_screen.dart';
import 'package:logging_task_flog/weather/choose_location.dart';
import '../main.dart';
import '../news/views/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.emailId}) : super(key: key);
  final emailId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlogFunctions.logInfo('ENTERED HOME PAGE');
  }

  Widget logButton() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: () {
          FlogFunctions.printLogs();
        },
        child: Text('TEST LOGS'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              FlogFunctions.logInfo('POPPED OUT OF HOME PAGE');
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
            ),
          ),
          title: Text("LOGGING"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FlogFunctions.printLogs();
                          },
                          child: Text('PRINT LOGS'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FlogFunctions.printFileLogs();
                          },
                          child: Text('PRINT FILE LOGS'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FlogFunctions.exportLogs();
                          },
                          child: Text('EXPORT LOGS'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            print('hello');
                            FlogFunctions.logWarning("WARNING LOG");
                          },
                          child: Text('WARNING LOGS'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FlogFunctions.clearLogs();
                          },
                          child: Text('CLEAR LOGS'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (builder) {
                              return MyStorageApp();
                            }));
                          },
                          child: Text('DISPLAY LOGS'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) {
                              return NewsHomeScreen();
                            },
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/news.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) {
                              return ChooseLocation();
                            },
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/cloudy.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

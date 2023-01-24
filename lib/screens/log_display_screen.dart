// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logging_task_flog/flogs.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'DISPLAY LOGS',
      home: MyStorageApp(),
    ),
  );
}

class MyStorageApp extends StatefulWidget {
  bool isText = true;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyStorageApp> {
  List<String> data = [];

  Future<Directory?> get _localPath async {
    final Directory? directory = await getExternalStorageDirectory();
    return directory;
  }

  Future<File> get _localFile async {
    final directory = await _localPath;

    var dir = "${directory!.path.toString()}/Flogs/flog.txt";
    return File(dir);
  }

  Future<Object> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      var contents = await file.readAsLines();
      // print(contents);
      // print(contents.runtimeType);
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // print(e);
      // If encountering an error, return
      return 'Error!';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              readContent().then((Object value) {
                setState(() {
                  data = value.toString().split(',');
                  widget.isText = false;
                });
              });
              print(data.runtimeType);
              print(data.length);
            },
            icon: Icon(Icons.smart_display_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            FlogFunctions.logInfo('POPPED OUT OF LOG DISPLAY PAGE');
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
        padding: const EdgeInsets.all(8.0),
        child: widget.isText
            ? Center(
                child: Text(
                  'HELLO THERE, TAP THE BUTTON ON TOP TO DISPLAY THE LOGS :)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return data.length == 1
                      ? Center(
                          child: Text(
                            'NO LOGS TO SHOW :(',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data[index].toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                }),
      ),
    );
  }
}

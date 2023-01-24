// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_field

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logging_task_flog/flogs.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logging/logging.dart';

class ArticleView extends StatefulWidget {
  final String webUrl;
  final String title;

  ArticleView({
    required this.webUrl,
    required this.title,
  });

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();

  @override
  void initState() {
    FlogFunctions.logInfo('"${widget.title}" PAGE ENTERED');
    // TODO: implement initState
    super.initState();
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FlogFunctions.logInfo('POPPED FROM "${widget.title}" PAGE');
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_sharp,
          ),
        ),
        title: Text("NEWS APP"),
        centerTitle: true,
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.webUrl,
          onProgress: (int progress) {},
          onWebViewCreated: ((WebViewController webController) {
            _completer.complete(webController);
          }),
        ),
      ),
    );
  }
}

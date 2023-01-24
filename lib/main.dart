// ignore_for_file: prefer_const_constructors, avoid_print, depend_on_referenced_packages, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, use_build_context_synchronously, unnecessary_import, unused_import, body_might_complete_normally_nullable

import 'dart:developer';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging_task_flog/flogs.dart';
import 'package:logging_task_flog/screens/home_screen.dart';
import 'package:logging_task_flog/screens/log_display_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// Email Password Validation
class Validator {
  static String? emailvalidator(String? value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return "Please Provide a Valid Email Id";
    }
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (value.length < 8) {
      return "Password should be minimum  8 characters";
    }
  }
}

// Dark/Light Mode Theming
class MyTheme extends ChangeNotifier {
  static bool _isDark = false;

  static bool get isDark => _isDark;

  void changeTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

void main() async {
  FLog.applyConfigurations(FlogFunctions.configFunction());
  runApp(
    MyApp(),
  );
}

// class CustomFormatter {
//   static String formatStackTrace(StackTrace stackTrace) {
//     return stackTrace.toString();
//   }
// }

Future<void> requestPermission(Permission permission) => permission.request();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Permission _permissionGroup = Permission.storage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission(_permissionGroup);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTheme>(
      create: (_) => MyTheme(),
      child: Consumer<MyTheme>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            themeMode: MyTheme.isDark ? ThemeMode.dark : ThemeMode.light,
            home: LoginPage(),
          );
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("LOGGING"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Provider.of<MyTheme>(context, listen: false).changeTheme();
              setState(() {
                if (!MyTheme.isDark) {
                  FlogFunctions.logInfo("LIGHT MODE ACTIVATED");
                } else {
                  FlogFunctions.logInfo("DARK MODE ACTIVATED");
                }
              });
            },
            icon: Icon(
              MyTheme.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                      validator: Validator.emailvalidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: Validator.passwordValidator,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FlogFunctions.logInfo("LOGIN SUCCESS");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) {
                                return HomePage(
                                  emailId: emailController.text,
                                );
                              },
                            ),
                          );
                        } else {
                          FlogFunctions.logError("LOGIN FAILURE");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

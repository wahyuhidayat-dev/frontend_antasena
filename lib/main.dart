import 'package:flutter/material.dart';
import 'package:report/screens/login_screen.dart';
import 'package:report/shared/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? access_token;
  int? id;
  String? name;
  String? email;
  String? profile_photo_url;
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data_token = prefs.getString('access_token');
    String? data_name = prefs.getString('name');
    String? data_email = prefs.getString('email');
    String? data_photo_url = prefs.getString('profile_photo_url');
    int? data_id = prefs.getInt('id');

    //print(userData);
    setState(() {
      access_token = data_token;
      id = data_id;
      name = data_name;
      email = data_email;
      profile_photo_url = data_photo_url;
    });
    //print(access_token);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Report',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: access_token != Null ? MainScreeen() : SignInPage(),
    );
  }
}

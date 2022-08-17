import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:report/config/dio_http.dart';
import 'package:report/shared/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  bool isLoading = false;
  var passwordVisible = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  BuildContext? _buildContext;
  BuildContext get buildContext => _buildContext!;
  set buildContext(BuildContext ctx) {
    if (ctx == null) {
      throw new ArgumentError();
    }
    _buildContext = ctx;
  }

  // String? email;
  // String? password;

  Future<dynamic> summary(int user_id) async {
    var data = {"user_id": user_id};
    try {
      // setState(() {
      isLoading = true;
      // });
      var response =
          await DioHttp.request.post("/api/reports/summary", data: data);
      print(data);
      // setState(() {
      isLoading = false;
      // });
      //Map<String, dynamic> user = response.data['data'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('access_token', response.data['data']['access_token']);
      // prefs.setInt('id', response.data['data']['user']['id']);
      // prefs.setString('name', response.data['data']['user']['name']);
      // prefs.setString('email', response.data['data']['user']['email']);
      //List<String> data = [];
      //prefs.setStringList('data', user);
      //print(prefs.setInt('id', response.data['data']['user']['id']));
      // Navigator.push(
      //   _buildContext!,
      //   MaterialPageRoute(builder: (context) => MainScreeen()),
      // );
    } on DioError catch (dioError) {
      String? message;
      if (dioError.response == null) {
        // setState(() {
        message = "Server Error!";
        isLoading = false;
        // });
      } else if (dioError.response!.statusCode == 400) {
        //setState(() {
        isLoading = false;
        message = dioError.response!.data["message"].toString();
        //});
      } else if (dioError.response!.statusCode == 404) {
        // setState(() {
        isLoading = false;
        message = "Server not found!";
        // });
      } else {
        //setState(() {
        isLoading = false;
        message = dioError.response!.data["message"].toString();
        //});
      }
      final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              //setState(() {
              isLoading = false;
              // });
            }),
      );
      ScaffoldMessenger.of(_buildContext!).showSnackBar(snackBar);
    }
  }
}

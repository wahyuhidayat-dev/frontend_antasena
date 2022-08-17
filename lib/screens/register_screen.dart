import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:report/shared/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/dio_http.dart';
import '../shared/const.dart';
import 'package:dio/dio.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  var _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  String? fullname;

  String? email;

  String? password;

  bool isLoading = false;
  Future<dynamic> _RegisterSubmit() async {
    var data = {"name": fullname, "email": email, "password": password};
    String? message;
    try {
      print(data);
      setState(() {
        isLoading = true;
      });
      var response = await DioHttp.request.post("/api/register", data: data);
      print(response.data);

      if (response.data['password'] != Null) {
        setState(() {
          message = "${response.data['password']}";
          isLoading = false;
        });
        final snackBar = SnackBar(
          content: Text(message!),
          action: SnackBarAction(label: "Undo", onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.data['email'] != Null) {
        setState(() {
          message = "${response.data['email']}";
          isLoading = false;
        });
        final snackBar = SnackBar(
          content: Text(message!),
          action: SnackBarAction(label: "Undo", onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.data['data'] != null) {
        List<String> user = [];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', response.data['access_token']);
        prefs.setStringList('data', user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreeen()),
        );
      }

      setState(() {
        isLoading = false;
      });
    } on DioError catch (dioError) {
      // String? message;
      if (dioError.response == null) {
        setState(() {
          message = "Server Error!";
          isLoading = false;
        });
      } else if (dioError.response!.statusCode == 400) {
        setState(() {
          isLoading = false;
          message = dioError.response!.data["message"].toString();
        });
      } else if (dioError.response!.statusCode == 404) {
        setState(() {
          isLoading = false;
          message = "Server not found!";
        });
      } else {
        setState(() {
          isLoading = false;
          message = dioError.response!.data["message"].toString();
        });
      }
      final snackBar = SnackBar(
        content: Text(message!),
        action: SnackBarAction(label: "Undo", onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: orange,
        iconTheme: IconThemeData(color: white, size: 30),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SafeArea(
          child: Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 24),
                    child: Text("Create Your, \nAccount",
                        style:
                            fontMedium.copyWith(fontSize: 30, color: orange)),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 26, defaultMargin, 6),
                    child: Text(
                      "Full Name",
                      style: fontRegular.copyWith(
                          color: grey, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: orange),
                    ),
                    child: TextFormField(
                      validator: (String? fullNameValue) {
                        if (fullNameValue!.isEmpty) {
                          return "type here full name";
                        }
                        fullname = fullNameValue;
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: fontRegular.copyWith(color: grey),
                          hintText: 'Type Your Full Name'),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 26, defaultMargin, 6),
                    child: Text(
                      "Email Address",
                      style: fontRegular.copyWith(
                          color: grey, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: orange),
                    ),
                    child: TextFormField(
                      validator: (String? emailValue) {
                        if (emailValue!.isEmpty) {
                          return "type here email";
                        }
                        email = emailValue;
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: fontRegular.copyWith(color: grey),
                          hintText: 'Type Your Email'),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 26, defaultMargin, 6),
                    child: Text(
                      "Password",
                      style: fontRegular.copyWith(
                          color: grey, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: orange),
                    ),
                    child: TextFormField(
                      validator: (String? passwordValue) {
                        if (passwordValue!.isEmpty) {
                          return "type here password";
                        }
                        password = passwordValue;
                        return null;
                      },
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: orange,
                              )),
                          border: InputBorder.none,
                          hintStyle: fontRegular.copyWith(color: grey),
                          hintText: 'Type Your Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Contunue to Sign up",
                        style: fontBold.copyWith(color: grey, fontSize: 18),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _RegisterSubmit();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                              primary: orange,
                              onPrimary: blue),
                          child: Icon(
                            Icons.arrow_forward,
                            color: white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

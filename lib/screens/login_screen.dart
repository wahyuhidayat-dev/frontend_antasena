import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:report/config/dio_http.dart';
import 'package:report/screens/register_screen.dart';
import 'package:report/shared/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String? email;
  String? password;
  bool _isLoading = false;

  Future<dynamic> _login() async {
    var data = {"email": email, "password": password};
    try {
      setState(() {
        _isLoading = true;
      });
      var response = await DioHttp.request.post("/api/login", data: data);
      print(response);
      setState(() {
        _isLoading = false;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', response.data['access_token']);
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreeen()));
      }
    } on DioError catch (dioError) {
      String? message;
      print(dioError);
      switch (dioError.response!.statusCode) {
        case 400:
          setState(() {
            _isLoading = false;
          });
          message = data["message"].toString();
          break;
        case 404:
          message = "Server not found!";
          break;
        default:
          setState(() {
            _isLoading = false;
          });
          message = "Server Error!";
      }
      final snackBar = SnackBar(
        content: const Text("Invalid Username and Password"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _isLoading = false;
              });
            }),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 24),
                    child: Text("Welcome Back, \nExplorer!",
                        style:
                            fontMedium.copyWith(fontSize: 30, color: orange)),
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
                          return "input your email";
                        }
                        email = emailValue;
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: fontRegular.copyWith(color: grey),
                          hintText: 'Type Your Email Address'),
                    ),
                  ),
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
                          return "input your password";
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
                        "Contunue to Sign in",
                        style: fontBold.copyWith(color: grey, fontSize: 18),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   _login();
                            // }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreeen()));
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
                    height: 50,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          "Create new account",
                          style:
                              fontRegular.copyWith(color: orange, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 66,
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

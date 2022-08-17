import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:report/config/dio_http.dart';
import 'package:report/models/user_model.dart';
import 'package:report/screens/register_screen.dart';
import 'package:report/shared/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/const.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;
  var _passwordVisible = false;
  String? email;
  String? password;

  Future<dynamic> _login() async {
    var data = {"email": email, "password": password};
    try {
      setState(() {
        isLoading = true;
      });
      var response = await DioHttp.request.post("/api/login", data: data);
      //print(response.data);
      setState(() {
        isLoading = false;
      });
      //Map<String, dynamic> user = response.data['data'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', response.data['data']['access_token']);
      prefs.setInt('id', response.data['data']['user']['id']);
      prefs.setString('name', response.data['data']['user']['name']);
      prefs.setString('email', response.data['data']['user']['email']);
      prefs.setString('profile_photo_url',
          response.data['data']['user']['profile_photo_url']);
      //List<String> data = [];
      //prefs.setStringList('data', user);
      //print(prefs.setInt('id', response.data['data']['user']['id']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreeen()),
      );
    } on DioError catch (dioError) {
      String? message;
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
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                isLoading = false;
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
      body: LoadingOverlay(
        isLoading: isLoading,
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
                      style: fontMedium.copyWith(fontSize: 30, color: orange)),
                ),
                const SizedBox(height: 13),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
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
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
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
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => MainScreeen()));
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:report/screens/login_screen.dart';

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

  bool _isLoading = false;
  Future<dynamic> _RegisterSubmit() async {
    var data = {"name": fullname, "email": email, "password": password};
    try {
      print(data);
      setState(() {
        _isLoading = true;
      });
      var response = await DioHttp.request.post("/api/register", data: data);
      print(response.data);

      if (response.data['password']) {
        final snackBar = SnackBar(
          content: Text('${response.data['password']}'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on DioError catch (dioError) {
      var message = "";
      switch (dioError.response!.statusCode) {
        case 422:
          Map<String, dynamic> _errorData = dioError.response!.data['errors'];
          var getListMessage = _errorData.values;
          var result = getListMessage.map((item) =>
              item.toString().substring(1, item.toString().length - 2));
          setState(() {
            _isLoading = false;
          });
          message = result.join("\n");
          break;
        case 404:
          setState(() {
            _isLoading = false;
          });
          message = "Server Not Found";
          break;
        default:
          setState(() {
            _isLoading = false;
          });
          message = "Server Error";
      }
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
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
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 24),
                  child: Text("Create Your, \nAccount",
                      style: fontMedium.copyWith(fontSize: 30, color: orange)),
                ),
                const SizedBox(height: 13),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
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
                        return "type here password";
                      }
                      password = passwordValue;
                      return null;
                    },
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
    );
  }
}

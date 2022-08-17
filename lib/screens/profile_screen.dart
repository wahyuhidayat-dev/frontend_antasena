import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:report/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/const.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;
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

  Future<void> logout() async {
    try {
      setState(() {
        isLoading = true;
      });
      var data = {"email": email};
      var response = await Dio().post("http://10.0.2.2:8000/api/logout",
          data: data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${access_token}"
          }));
      if (response.data['meta']['code'] == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        setState(() {
          isLoading = false;
        });
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
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
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Personal Data",
          style: fontBold.copyWith(color: white),
        ),
        backgroundColor: orange,
        iconTheme: IconThemeData(color: white, size: 30),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 24),
                  child: Text("Your Account",
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
                    decoration: InputDecoration(
                        enabled: false,
                        border: InputBorder.none,
                        hintStyle: fontRegular.copyWith(color: grey),
                        hintText: name),
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
                    decoration: InputDecoration(
                        enabled: false,
                        border: InputBorder.none,
                        hintStyle: fontRegular.copyWith(color: grey),
                        hintText: email),
                  ),
                ),
                const SizedBox(height: 13),
                // Container(
                //   width: double.infinity,
                //   margin:
                //       EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
                //   child: Text(
                //     "Password",
                //     style: fontRegular.copyWith(
                //         color: grey, fontWeight: FontWeight.w400),
                //   ),
                // ),
                // Container(
                //   width: double.infinity,
                //   margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(color: orange),
                //   ),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //         suffixIcon: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               _passwordVisible
                //                   ? Icons.visibility
                //                   : Icons.visibility_off,
                //               color: orange,
                //             )),
                //         border: InputBorder.none,
                //         hintStyle: fontRegular.copyWith(color: grey),
                //         hintText: 'Type Your Password'),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Log Out Here",
                      style: fontBold.copyWith(color: grey, fontSize: 18),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          logout();
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

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/const.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({Key? key}) : super(key: key);

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String? access_token;
  int? id;
  String? name;
  String? email;
  String? profile_photo_url;
  String? sum;
  int? asset;
  bool isLoading = false;
  List? listDataReport;
  Future<void> home() async {
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

  Future<dynamic> summary() async {
    try {
      Future.delayed(Duration.zero, () async {
        setState(() {
          isLoading = true;
        });
        var data = {"user_id": id};
        // var response =
        //     await Dio().post("http://10.0.2.2:8000/api/reports/summary",
        //         data: data,
        //         options: Options(headers: {
        //           "Accept": "application/json",
        //           "Content-Type": "application/json",
        //           "Authorization": "Bearer ${access_token}"
        //         }));
        //print(response.headers);
        //print(data);
        var response2 =
            await Dio().post("http://10.0.2.2:8000/api/reports/user",
                data: data,
                options: Options(headers: {
                  "Accept": "application/json",
                  "Content-Type": "application/json",
                  "Authorization": "Bearer ${access_token}"
                }));

        // List listData = response.data;
        List listData2 = response2.data;
        if (listData2 != Null) {
          setState(() {
            isLoading = false;
            // sum = listData[0]['sum'];
            // asset = listData[0]['asset'];
            listDataReport = listData2;
          });
        }

        // print(listData2);
      });

      setState(() {
        isLoading = false;
      });
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
              //setState(() {
              isLoading = false;
              // });
            }),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    home();
    summary();
    //dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "List Assets",
          style: fontBold.copyWith(color: white),
        ),
        backgroundColor: orange,
        iconTheme: IconThemeData(color: white, size: 30),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: grey,
                      blurRadius: 10,
                      offset: Offset(1, 2), // Shadow position
                    ),
                  ], borderRadius: BorderRadius.circular(10), color: white),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Thumbnail",
                              style: fontBold.copyWith(color: black),
                            ),
                            Text("Channel name",
                                style: fontBold.copyWith(color: black)),
                            Text("Final Revenue",
                                style: fontBold.copyWith(color: black))
                          ],
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: listDataReport?.length ?? 0,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  // decoration: BoxDecoration(
                                  //   boxShadow: [
                                  //     new BoxShadow(
                                  //       color: grey,
                                  //       blurRadius: 10,
                                  //       offset: Offset(1, 2),
                                  //     ),
                                  //   ],
                                  // ),
                                  child: Image(
                                    image: NetworkImage(
                                      "https://i.ytimg.com/vi/${listDataReport![index]['url_video'].substring(17)}/sddefault.jpg",
                                    ),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/no_images.png',
                                          fit: BoxFit.fitWidth);
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  listDataReport![index]['channel_name'] ?? "",
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id-ID',
                                          symbol: 'IDR ',
                                          decimalDigits: 0)
                                      .format(
                                          listDataReport![index]['share'] ?? 0),
                                  style: fontRegular.copyWith(
                                      color: black, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

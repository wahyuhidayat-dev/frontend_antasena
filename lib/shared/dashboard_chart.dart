import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color.fromARGB(255, 248, 120, 84);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  //GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    home();
    summary();
    //dispose();
  }

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
        var response =
            await Dio().post("http://10.0.2.2:8000/api/reports/chart",
                data: data,
                options: Options(headers: {
                  "Accept": "application/json",
                  "Content-Type": "application/json",
                  "Authorization": "Bearer ${access_token}"
                }));
        //print(response.headers);
        print(response);
        // var response2 =
        //     await Dio().post("http://10.0.2.2:8000/api/reports/user",
        //         data: data,
        //         options: Options(headers: {
        //           "Accept": "application/json",
        //           "Content-Type": "application/json",
        //           "Authorization": "Bearer ${access_token}"
        //         }));

        if (response.statusCode == 200) {
          List listData = await response.data;
          setState(() {
            isLoading = false;
            listDataReport = listData;
            // sum = listData[0]['sum'];
            // asset = listData[0]['asset'];
            // listDataReport = listData2;
          });
        }
        //List listData2 = await response2.data;
        // if (listData != Null) {

        // }

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
      } else if (dioError.response!.statusCode == 401) {
        setState(() {
          isLoading = false;
          message = "Unauthorized";
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
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff232d37),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    'Monthly',
                    style: TextStyle(
                        color: Color(0xff68737d),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Grafik Revenue',
                    style: TextStyle(
                        color: Color(0xff68737d),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: listDataReport?.length == null
                          ? Container()
                          : BarChart(
                              mainBarData(),
                              swapAnimationDuration: animDuration,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: IconButton(
            //       icon: Icon(
            //         isPlaying ? Icons.pause : Icons.play_arrow,
            //         color: const Color(0xff68737d),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           isPlaying = !isPlaying;
            //           if (isPlaying) {
            //             refreshState();
            //           }
            //         });
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    //! color bar
    Color barColor = const Color.fromARGB(255, 248, 120, 84),
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.blue : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.blue, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.grey[400],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(listDataReport?.length ?? 0, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                1, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                5, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(
                6, double.parse(listDataReport?[i]['share'] ?? 0.0),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
  // List.generate(7, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(0, 5, isTouched: i == touchedIndex);
  //         case 1:
  //           return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
  //         case 2:
  //           return makeGroupData(2, 5, isTouched: i == touchedIndex);
  //         case 3:
  //           return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
  //         case 4:
  //           return makeGroupData(4, 9, isTouched: i == touchedIndex);
  //         case 5:
  //           return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
  //         case 6:
  //           return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
  //         default:
  //           return throw Error();
  //       }
  //     });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Color.fromARGB(255, 248, 120, 84),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'].substring(0, 3) ?? ''}';
                  break;
                case 1:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'].substring(0, 3) ?? ''}';
                  break;
                case 2:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'].substring(0, 3) ?? ''}';
                  break;
                case 3:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'].substring(0, 3) ?? ''}';
                  break;
                case 4:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'].substring(0, 3) ?? ''}';
                  break;
                case 5:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'] ?? ''}';
                  break;
                case 6:
                  weekDay =
                      '${listDataReport?[group.x.toInt()]['periode'] ?? ''}';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      case 1:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      case 2:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      case 3:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      case 4:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      case 5:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      case 6:
        text = Text(
            '${listDataReport?[value.toInt()]['periode'].substring(0, 3)}',
            style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../shared/const.dart';
import '../shared/dashboard_chart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var link = "https://www.youtube.com/embed/ZnxK2yPHwr8";
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "HOME",
                      style: fontBold.copyWith(color: orange, fontSize: 18),
                    ),
                    CircleAvatar(
                      backgroundColor: orange,
                      child: Icon(
                        Icons.account_circle_sharp,
                        color: Colors.grey[300],
                        size: 40,
                      ),
                      // child: Image.network(
                      //   "",
                      //   fit: BoxFit.cover,
                      // ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 150,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: orange),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Revenue",
                            style: fontRegular.copyWith(
                                color: white, fontSize: 16),
                          ),
                          Text(
                            "IDR 12.000.000",
                            style:
                                fontBold.copyWith(color: white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 150,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: orange),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Asset",
                            style: fontRegular.copyWith(
                                color: white, fontSize: 16),
                          ),
                          Text(
                            "13 Video",
                            style:
                                fontBold.copyWith(color: white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: defaultMargin, bottom: 12),
                child: Text(
                  "Report by Monthly",
                  style: fontBold.copyWith(color: orange, fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Expanded(child: BarChartSample7()),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: defaultMargin, bottom: 12),
                child: Text(
                  "Asset List",
                  style: fontBold.copyWith(color: orange, fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: grey,
                      blurRadius: 4,
                      offset: Offset(1, 2), // Shadow position
                    ),
                  ], borderRadius: BorderRadius.circular(10), color: white),
                  child: Column(
                    children: [
                      Row(
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
                      Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              "https://i.ytimg.com/vi/ZnxK2yPHwr8/sddefault.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Lighting",
                          ),
                          Text("IDR 12,000,000")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

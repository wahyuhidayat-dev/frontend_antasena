import 'package:flutter/material.dart';

import '../shared/const.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({Key? key}) : super(key: key);

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: defaultMargin, top: 12),
              child: Text(
                "List Assets",
                style: fontBold.copyWith(color: orange, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
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
          ],
        ),
      ),
    );
  }
}

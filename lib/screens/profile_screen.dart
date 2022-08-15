import 'package:flutter/material.dart';

import '../shared/const.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Data",
          style: fontBold.copyWith(color: white),
        ),
        backgroundColor: orange,
        iconTheme: IconThemeData(color: white, size: 30),
      ),
      body: SingleChildScrollView(
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
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {},
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
                    "Contunue to Update",
                    style: fontBold.copyWith(color: grey, fontSize: 18),
                  ),
                  ElevatedButton(
                      onPressed: () {},
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
    );
  }
}
